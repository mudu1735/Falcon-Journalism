package mcps.phs.arx;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;


public class LinkProcessing {
    public static String webScrape(String url) {
        
    	try {
            // Fetch the HTML content from the URL
            Document document = Jsoup.connect(url).get();

            // Select elements with snopostid attribute
            Element element = document.getElementById("sno-story-body-content");
            return element.html();

        } catch (IOException e) {
            e.printStackTrace();
            return "Something wrong to retrieve the link";
        } 
        
    }
    
    
}
