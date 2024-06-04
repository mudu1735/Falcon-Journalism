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

    public NameFinder(
    	String csvFile, String articleUrl) {
        this.csvFile = csvFile;
        this.articleUrl = articleUrl;
    }


    /**
     * Search .......
     */
    public int findNamesInArticle() {
    	int count = 0;
        String line;
        String articleContent = LinkProcessing.webScrape(articleUrl);
        //System.out.println(articleContent);
        ClassLoader classLoader = getClass().getClassLoader();
        try (BufferedReader br = new BufferedReader(new InputStreamReader(classLoader.getResource(csvFile).openStream(),"UTF-8"))) {
            // Read each line of the CSV file
            while ((line = br.readLine()) != null) {
            	int spaceIndex = line.indexOf(",");
            	String firstN = line.substring(0,spaceIndex);
            	String lastN = line.substring(spaceIndex + 1);
                String name = line.replace(",", " ");
                System.out.println("searching "+name);
                if (articleContent.contains(name)) {
                	System.out.println("found "+name);
                	if (writeNametoRecord(firstN, lastN, articleUrl)) {
                        count++;
                    }
                	System.out.println("count in findNamesInArticle:"+count);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return count;
    }
    
    
    /**
     * Write the person's first name, last name and the url of the article that the person appears in to the record file - interviewRecords.csv.
     * @param first: first name
     * @param last: last name
     * @param url: the url of the article
     */
    public boolean writeNametoRecord(String first, String last, String url) {
        String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
    	String[] row = new String[]{first, last, url, date};
    	String[] rowNoDate = new String[] {first, last, url};
    	
    	try (FileWriter writer = new FileWriter("c:\\tmp\\interviewRecords.csv",true)) {
    			BufferedReader interviewReader = new BufferedReader(new FileReader("c:\\tmp\\interviewRecords.csv"));
    			String readLine;
    			
    			while((readLine = interviewReader.readLine()) != null) {
    		    	int indexOfLastComma = readLine.lastIndexOf(",");
    				if (String.join(",", rowNoDate).equals(readLine.substring(0,indexOfLastComma)) == true){
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

    

