package mcps.phs.arx;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Date;

public class NameFinder {
    private String csvFile;
    private String articleUrl;

    public static void main(String[] args) {
        String csvFile = "src/main/webapp/resource/names.csv";
        String url = "https://poolesvillepulse.org/5833/recent-posts/boys-basketball-team-wins-regional-championship-for-first-time-in-decades/";
        NameFinder nf = new NameFinder(csvFile, url);
        nf.findNamesInArticle();
    }

    public NameFinder(String csvFile, String articleUrl) {
        this.csvFile = csvFile;
        this.articleUrl = articleUrl;
    }

    public int findNamesInArticle() {
        int count = 0;
        String line;
        String articleContent = LinkProcessing.webScrape(articleUrl);

        System.out.println(articleContent);
        ClassLoader classLoader = getClass().getClassLoader();
        try (BufferedReader br = new BufferedReader(new InputStreamReader(classLoader.getResource(csvFile).openStream(), "UTF-8"))) {
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                String firstN = parts[0];
                String lastN = parts[1];
                String grade = parts[2];
                String house = parts[3];
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
        } catch (IOException e) {
            e.printStackTrace();
        }
        return count;
    }

    public boolean writeNametoRecord(String first, String last, String grade, String house, String url) {
        String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        String[] row = new String[]{first, last, grade, house, url, date};
        String[] rowNoDate = new String[]{first, last, grade, house, url};

        try (FileWriter writer = new FileWriter("c:\\tmp\\interviewRecords.csv", true)) {
            BufferedReader interviewReader = new BufferedReader(new FileReader("c:\\tmp\\interviewRecords.csv"));
            String readLine;

            while ((readLine = interviewReader.readLine()) != null) {
                int indexOfLastComma = readLine.lastIndexOf(",");
                if (String.join(",", rowNoDate).equals(readLine.substring(0, indexOfLastComma))) {
                    System.out.println("IT IS A DUPE");
                    return false;
                }
            }

            writer.append(String.join(",", row));
            writer.append("\n");
            interviewReader.close();
            return true;

        } catch (IOException e) {
            e.printStackTrace();
            System.err.println("Error writing data to CSV: " + e.getMessage());
            return false;
        }
    }
}
