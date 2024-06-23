package mcps.phs.arx;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.Date;

import org.bson.Document;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;

public class NameFinder {
    private String articleUrl;
    private static MongoClient mongoClient = MongoClients.create("mongodb+srv://mudu1735:nB6zdJu0ap6DXmni@cluster0.jeailsf.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0");
    private static MongoCollection<Document> interviews;
    private static MongoCollection<Document> names;
    private static MongoDatabase database = mongoClient.getDatabase("mudu1735");

    public static void main(String[] args) {
        String url = "https://poolesvillepulse.org/5833/recent-posts/boys-basketball-team-wins-regional-championship-for-first-time-in-decades/";
        NameFinder nf = new NameFinder(url);
        nf.findNamesInArticle();
    }

    public NameFinder(String articleUrl) {
        this.articleUrl = articleUrl;
    }

    public int findNamesInArticle() {
        int count = 0;
        String line;
        String articleContent = LinkProcessing.webScrape(articleUrl);
        //System.out.println(articleContent);
        names = database.getCollection("names");
        try (MongoCursor<Document> cursor = names.find().iterator()) {
            while (cursor.hasNext()) {
                Document doc = cursor.next();
                String firstN = doc.getString("firstName");
                String lastN = doc.getString("lastName");
                String grade = doc.getString("grade");
                String house = doc.getString("house");
                String name = firstN + " " + lastN;

                System.out.println("searching " + name);

                if (articleContent.contains(name)) {
                    System.out.println("found " + name);
                    if (writeNametoRecord(firstN, lastN, grade, house, articleUrl)) {
                        count++;
                    }
                    System.out.println("count in findNamesInArticle:" + count);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public boolean writeNametoRecord(String first, String last, String grade, String house, String url) {
        String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        Date currentTime = new Date();
        
        Document record = new Document("firstName", first)
                .append("lastName", last)
                .append("grade", grade)
                .append("house", house)
                .append("url", url)
                .append("date", date)
                .append("time", currentTime);
        		
        		
        
        Document query = new Document("firstName", first)
                .append("lastName", last)
                .append("grade", grade)
                .append("house", house)
                .append("url", url);
        
        interviews = database.getCollection("interviewRecords");
        

        if (interviews.find(query).first() == null) {
            interviews.insertOne(record);
            System.out.println("Document inserted successfully!");
            return true;
        } else {
            System.out.println("IT IS A DUPE");
            return false;
        }
    }
}
