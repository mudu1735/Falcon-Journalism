package mcps.phs.arx;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.IOException;

public class LinkProcessing {
    public static String webScrape(String url) {
        try {
            // Fetch the HTML content from the URL
            Document document = Jsoup.connect(url).get();

            // Select elements with the specified class
            Elements bodyContents = document.getElementsByClass("sno-story-body-content");
            Elements titles = document.getElementsByClass("sno-story-headline");
            Elements categories = document.select("sno-story-cat-block-list");
            
            // Combine the title and body content, handling null or empty cases
            StringBuilder combinedContent = new StringBuilder();

            if (titles != null && !titles.isEmpty()) {
                combinedContent.append(titles.first().html());
            } else {
                combinedContent.append("<h1>No title found</h1>");
            }

            if (bodyContents != null && !bodyContents.isEmpty()) {
                Element bodyContent = bodyContents.first();
                // Remove photo captions
                Elements captions = bodyContent.select("div.photo-caption, figcaption");
                captions.remove();
                combinedContent.append(bodyContent.html());
            } else {
                combinedContent.append("<p>No body content found</p>");
            }

            // Append the URL
            combinedContent.append("<p>").append(url).append("</p>");
            for (Element e: categories){
            	
            	combinedContent.append(e.html());
            }

            return combinedContent.toString();

        } catch (IOException e) {
            e.printStackTrace();
            return "Something went wrong retrieving the link";
        }
    }
}
