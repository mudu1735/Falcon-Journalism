<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mongodb.client.MongoClients, com.mongodb.client.MongoClient, com.mongodb.client.MongoDatabase, com.mongodb.client.MongoCollection" %>
<%@ page import="org.bson.Document" %>
<%@ page import="com.mongodb.client.model.Filters" %>
<%@ page import="java.util.ArrayList, java.util.List" %>

<jsp:include page="sessionCheck.jsp" />	

<!DOCTYPE html>
<html>
<head>
    <title>View All Records</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400&display=swap');
        body {
            font-family: 'Poppins', sans-serif;
            margin: 20px;
        }
        table {
            font-family: 'Poppins', sans-serif;
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
        }
        th {
            background-color: #f4f4f4;
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
            margin: -20px;
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
        }
        h1 {
            margin-top: 35px;
        }
        form {
            margin-top: 20px;
        }
        form label {
            margin-right: 10px;
            font-size: 16px;
        }
        form input, form select {
            font-family: 'Poppins', sans-serif;
            padding: 10px;
            margin-right: 10px;
            border: 1px solid #000000;
            border-radius: 5px;
            font-size: 16px;
            width: 150px;
        }
        form button {
            font-family: 'Poppins', sans-serif;
            padding: 10px 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f4f4f4;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        form button:hover {
            background-color: #ddd;
            color: black;
        }
        .nowrap {
            white-space: nowrap;
        }
    </style>
</head>
<body>
<nav>
    <div class="logo">
        <img src="https://raw.githubusercontent.com/mudu1735/Falcon-Journalism/main/ARXlogo-removebg-preview.png" alt="Logo Placeholder">
        <span>Falcon Journalism</span>
    </div>
    <div class="nav-links">
        <a href="mainPage.jsp">Home</a>
        <a href="viewAllRecords.jsp">View All Records</a>
        <a href="userManual.jsp">User Manual</a>
        <% if("admin".equals(session.getAttribute("user"))) {         
			System.out.println("I AM ADMIN PLEASE");
		%>
        	<a href="uploadNames.jsp">Update Names</a> 

        <% } %>
        
        <button onclick="window.location.href='sessionEnd.jsp'">Sign Out</button>
    </div>
</nav>

<h1>Records Database</h1>

<form method="GET">
    <label for="searchFirstName">First Name:</label>
    <input type="text" id="searchFirstName" name="searchFirstName">
    <label for="searchLastName">Last Name:</label>
    <input type="text" id="searchLastName" name="searchLastName">
    <label for="searchGrade">Grade:</label>    
    <select id="searchGrade" name="searchGrade">
        <option value="">All</option>
        <option value="9" <%= "9".equalsIgnoreCase(request.getParameter("searchGrade")) ? "selected" : "" %>>9</option>
        <option value="10" <%= "10".equalsIgnoreCase(request.getParameter("searchGrade")) ? "selected" : "" %>>10</option>
        <option value="11" <%= "11".equalsIgnoreCase(request.getParameter("searchGrade")) ? "selected" : "" %>>11</option>
        <option value="12" <%= "12".equalsIgnoreCase(request.getParameter("searchGrade")) ? "selected" : "" %>>12</option>
        <option value="Staff" <%= "Staff".equalsIgnoreCase(request.getParameter("searchGrade")) ? "selected" : "" %>>Staff</option>
    </select>
    <label for="searchHouse">House:</label>
    <select id="searchHouse" name="searchHouse">
        <option value="">All</option>
        <option value="SMCS" <%= "SMCS".equalsIgnoreCase(request.getParameter("searchHouse")) ? "selected" : "" %>>SMCS</option>
        <option value="Global" <%= "Global".equalsIgnoreCase(request.getParameter("searchHouse")) ? "selected" : "" %>>Global</option>
        <option value="Humanities" <%= "Humanities".equalsIgnoreCase(request.getParameter("searchHouse")) ? "selected" : "" %>>Humanities</option>
        <option value="ISP" <%= "ISP".equalsIgnoreCase(request.getParameter("searchHouse")) ? "selected" : "" %>>ISP</option>
    </select>
    <label for="sortOrder">Sort By Date:</label>
    <select id="sortOrder" name="sortOrder">
        <option value="desc" <%= "desc".equals(request.getParameter("sortOrder")) ? "selected" : "" %>>Descending</option>
        <option value="asc" <%= "asc".equals(request.getParameter("sortOrder")) ? "selected" : "" %>>Ascending</option>
    </select>
    <button type="submit">Search</button>
</form>

<%
    // MongoDB connection settings
    String connectionString = "mongodb+srv://mudu1735:nB6zdJu0ap6DXmni@cluster0.jeailsf.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";
    String databaseName = "mudu1735";
    String collectionName = "interviewRecords";

    try (MongoClient mongoClient = MongoClients.create(connectionString)) {
        MongoDatabase database = mongoClient.getDatabase(databaseName);
        MongoCollection<Document> collection = database.getCollection(collectionName);

        // Get search parameters from request
        String searchFirstName = request.getParameter("searchFirstName");
        String searchLastName = request.getParameter("searchLastName");
        String searchGrade = request.getParameter("searchGrade");
        String searchHouse = request.getParameter("searchHouse");
        String sortOrder = request.getParameter("sortOrder");

        // Build the filter
        Document filter = new Document();
        if (searchFirstName != null && !searchFirstName.isEmpty()) {
            filter.append("firstName", new Document("$regex", "^" + searchFirstName + "$").append("$options", "i"));
        }
        if (searchLastName != null && !searchLastName.isEmpty()) {
            filter.append("lastName", new Document("$regex", "^" + searchLastName + "$").append("$options", "i"));
        }
        if (searchGrade != null && !searchGrade.isEmpty()) {
        	filter.append("grade", new Document("$regex", "^" + searchGrade + "$").append("$options", "i"));
        }
        if (searchHouse != null && !searchHouse.isEmpty()) {
            filter.append("house", new Document("$regex", "^" + searchHouse + "$").append("$options", "i"));
        }

        // Sort order
        Document sort = new Document("time", "asc".equals(sortOrder) ? 1 : -1);

        // Query the collection
        List<Document> records = collection.find(filter).sort(sort).into(new ArrayList<>());

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
    <% for (Document record : records) { %>
    <tr>
        <td><%= record.getString("firstName") %></td>
        <td><%= record.getString("lastName") %></td>
        <td><%= record.getString("grade") %></td>
        <td><%= record.getString("house") %></td>
        <td><a href="<%= record.getString("url") %>"><%= record.getString("url") %></a></td>
        <td class="nowrap"><%= record.getString("date") %></td>
    </tr>
    <% } %>
    </tbody>
</table>
<%
    } catch (Exception e) {
%>
<p>Error connecting to MongoDB or retrieving records: <%= e.getMessage() %></p>
<%
    }
%>

</body>
</html>
