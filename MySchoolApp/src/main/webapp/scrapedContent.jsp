<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="mcps.phs.arx.NameFinder, mcps.phs.arx.LinkProcessing" %>
<%@ page import="java.io.BufferedReader, java.io.FileReader, java.io.IOException, java.util.ArrayList, java.util.List" %>
<%@ page import="com.mongodb.client.MongoClients, com.mongodb.client.MongoClient, com.mongodb.client.MongoDatabase, com.mongodb.client.MongoCollection, com.mongodb.client.model.Sorts, com.mongodb.client.FindIterable"%>
<%@ page import="org.bson.Document" %>
<%@ page import="com.mongodb.client.model.Filters" %>
<!DOCTYPE html>
<html>
<head>
    <title>Most Recently Added Records</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400&display=swap');
        body {
            font-family: 'Poppins', sans-serif;
            margin: 10px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            font-family: 'Poppins', sans-serif;
        }
        th {
            background-color: #f4f4f4;
            font-family: 'Poppins', sans-serif;
        }
        nav {
            width: 100%;
            height: 10%;
            background-color: #000000;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
            margin: -10px;
            font-family: 'Poppins', sans-serif;
        }
        .logo {
            display: flex;
            align-items: center;
        }
        .logo img {
            height: 80px;
            margin-right: 2px;
        }
        .logo span {
            color: #f2f2f2;
            font-size: 16px;
            font-family: 'Poppins', sans-serif;
        }
        nav a, nav button, .logo span {
            display: block;
            color: #f2f2f2;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
            background: none;
            border: none;
            cursor: pointer;
            font-size: 18px;
            font-family: 'Poppins', sans-serif;
        }
        nav a:hover, nav button:hover {
            color: #d4af37;
        }
        .nav-links {
            display: flex;
            align-items: center;
            font-family: 'Poppins', sans-serif;
        }
        .nowrap {
        	white-space: nowrap;
        }
    </style>
</head>
<body>
<nav>
    <div class="logo">
        <img src="https://github.com/mudu1735/Falcon-Journalism/blob/main/ARXlogo-removebg-preview.png?raw=true" alt="Logo Placeholder">
        <span>Falcon Journalism</span>
    </div>
    <div class="nav-links">
        <a href="mainPage.jsp">Home</a>
        <a href="viewAllRecords.jsp">View All Records</a>
        <a href="userManual.jsp">User Manual</a>
        <a href="uploadNames.jsp">Update Names</a>
        <button onclick="window.location.href='loginPage.jsp'">Sign Out</button>
    </div>
</nav>

<h1>Newly Added Records</h1>

<%
    String scrapeUrl = request.getParameter("userLink");
    String csvFile = "names.csv";
    
    try {
        NameFinder nf = new NameFinder(scrapeUrl);
        int newLines = nf.findNamesInArticle(); // Retrieve the number of new lines
		//System.out.println(newLines);
        request.setAttribute("newLines", newLines);

        // Connect to MongoDB
        MongoClient mongoClient = MongoClients.create("mongodb+srv://mudu1735:nB6zdJu0ap6DXmni@cluster0.jeailsf.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0");
        MongoDatabase database = mongoClient.getDatabase("mudu1735");
        MongoCollection<Document> collection = database.getCollection("interviewRecords");

        // Find last `newLines` documents sorted by insertion order
        FindIterable<Document> cursor = collection.find().sort(Sorts.descending("_id")).limit(newLines);

        List<Document> documents = new ArrayList<>();
        cursor.into(documents);

%>
        <table>
            <thead>
                <tr>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Grade</th>
                    <th>House</th>
                    <th>URL</th>
                    <th>Date Added</th>
                </tr>
            </thead>
            <tbody>
<%
        if (newLines == 0) {
%>
            <p>No new interviews were found</p>
<%

        } else {
        	for (Document doc : documents) {
%>
                <tr>
                    <td><%= doc.getString("firstName") %></td>
                    <td><%= doc.getString("lastName") %></td>
                    <td><%= doc.getString("grade") %></td>
                    <td><%= doc.getString("house") %></td>
                    <td><a href="<%= doc.getString("url") %>"><%= doc.getString("url") %></a></td>
                    <td class = "nowrap"><%= doc.getString("date") %></td>
                </tr>
<%
        	}
        }
%>
            </tbody>
        </table>
<%
    } catch (IOException e) {
%>
        <p>Error fetching URL: <%= e.getMessage() %></p>
<%
    }
%>

</body>
</html>
