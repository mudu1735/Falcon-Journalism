package mcps.phs.arx;

import java.util.Iterator;

import org.bson.Document;

import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.MongoIterable;
import com.mongodb.client.model.Filters.*;
import static com.mongodb.client.model.Filters.eq;
import static com.mongodb.client.model.Filters.and;
import javax.servlet.RequestDispatcher; 
import javax.servlet.ServletException; 
import javax.servlet.annotation.WebServlet; 
import javax.servlet.http.HttpServlet; 
import javax.servlet.http.HttpServletRequest; 
import javax.servlet.http.HttpServletResponse; 
import javax.servlet.http.HttpSession; 



public class LoginValidation {
	private static MongoClient mongoClient = MongoClients.create("mongodb+srv://mudu1735:nB6zdJu0ap6DXmni@cluster0.jeailsf.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0");
	private static MongoDatabase database = mongoClient.getDatabase("mudu1735");
	private static MongoCollection<Document> logins;
	
	public static void main(String[] args) {
		MongoIterable<String> list = database.listCollectionNames();
	    for (String name : list) {
	        System.out.println(name);
	    }
	    logins = database.getCollection("loginInfo");

	   // Document loginCheck = logins.find(eq("username", "a")).first();
	   // System.out.println(loginCheck);
	    //System.out.println(loginCheck.toJson());
		LoginValidation lv = new LoginValidation();
	    System.out.println(lv.loginCheck("admin","a"));

		
	}
	public boolean loginCheck(String user, String pass) {
		logins = database.getCollection("loginInfo");
		//System.out.println("User- " + user);
		//System.out.println("Pass- " + pass);
	    Document loginCheck = logins.find(and(eq("username", user), eq("password", pass))).first();

	    //Document userCheck = logins.find(eq("username", user)).first();
	    //Document passCheck = logins.find(eq("password", pass)).first();
	    
	    //System.out.println(myDoc);
	    if(loginCheck == null) {
	    	return false;
	    }
		
		return true;
	}
    
}
