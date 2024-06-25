<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="mcps.phs.arx.NameFinder, mcps.phs.arx.LinkProcessing" %>
<%@ page import="java.io.*, java.util.*, com.mongodb.client.*" %>
<%@ page import="com.mongodb.client.MongoClients, com.mongodb.client.MongoClient, com.mongodb.client.MongoDatabase, com.mongodb.client.MongoCollection" %>
<%@ page import="org.bson.Document" %>
<%@ page import="com.mongodb.client.model.Filters" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Names</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400&display=swap');
        
        body {
            font-family: 'Poppins', sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: flex-start;
            height: 100vh;
            margin: 0;
            background-color: #f4f4f4;
        }
        nav {
            width: 100%;
            height: 80px;
            background-color: #000000;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
            box-sizing: border-box; 
        }
        .logo {
            display: flex;
            align-items: center;
            height: 100%;
        }
        .logo img {
            height: 80px;
            margin-right: 10px;
        }
        .logo span {
            color: #f2f2f2;
            font-size: 18px;
        }
        nav a, nav button, .logo span {
            display: flex;
            align-items: center;
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
            height: 100%;
        }
        .upload-container {
            display: flex;
            flex-direction: column;
            justify-content: center;
            width: 400px;
            min-height: 350px;
            border: 1px solid #ccc;
            border-radius: 10px;
            padding: 30px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-top: 75px;
            
        }
        .upload-container h1 {
            margin: 0 0 20px;
            margin-top: -35px;
            font-size: 24px;
            color: #333;
        }
        .upload-container p {
            font-size: 14px;
            color: #777;
            margin-bottom: 20px;
        }
        .file-upload {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            width: 100%;
            height:90%;
            border: 2px dashed #ddd;
            border-radius: 10px;
            background-color: #fafafa;
            cursor: pointer;
            text-align: center;
        }
        .file-upload:hover {
            border-color: #c1c1c1;
        }
        .file-upload input[type="file"] {
            display: none;
        }
        .file-upload img {
            width: 50px;
            margin-bottom: 10px;
        }
        .file-upload span {
            color: #6200EE;
            font-size: 16px;
            margin-bottom: 5px;
        }
        .file-upload small {
            color: #888;
            font-size: 12px;
        }
        .button-container {
            display: flex;
            width: 100%;
            margin-top: 20px;
            margin-left: 0px;
            justify-content: center; /* Center content horizontally */

        }
        .button-container button {
            font-family: 'Poppins', sans-serif;
            padding: 10px 20px;
            border-radius: 25px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease, color 0.3s ease;
            border: none;
            width: 48%;
        }
        
        
        .button-container .upload-button {
            background-color: #f1f1f1;
            color: #555;
        }
        .button-container .upload-button:hover {
            background-color: #ddd;
            color: black;
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

<div class="upload-container">
    <h1>Upload CSV File</h1>
    <p>Select a CSV file to upload.</p>
    <form action="uploadNames.jsp" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
        <label class="file-upload">
            <img src="https://raw.githubusercontent.com/mudu1735/Falcon-Journalism/main/uploadIcon.png" alt="File Upload">
            <span id="file-name-placeholder">Click to upload</span> 
            <input type="file" name="file" id="file" accept=".csv" onchange="updateFileName(this)">
            <small id="file-type-info">CSV format only.</small>
        </label>
        <div class="button-container">
            <button type="submit" class="upload-button">Upload</button>
        </div>
    </form>
</div>

<script>
    // Function to update file name display
    function updateFileName(input) {
        var fileName = input.files[0].name;
        document.getElementById('file-name-placeholder').textContent = fileName;
        document.getElementById('file-type-info').textContent = ''; // Clear file type info
    }

    // Optional: Client-side form validation
    function validateForm() {
        var fileInput = document.getElementById('file');
        if (!fileInput.value) {
            alert('Please select a file to upload.');
            return false;
        }
        return true;
    }
</script>

<%
if ("POST".equalsIgnoreCase(request.getMethod())) {
    // MongoDB connection settings
    String connectionString = "mongodb+srv://mudu1735:nB6zdJu0ap6DXmni@cluster0.jeailsf.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";
    String databaseName = "mudu1735";
    String collectionName = "test";

    // Set up MongoDB client
    try (MongoClient mongoClient = MongoClients.create(connectionString)) {
        MongoDatabase database = mongoClient.getDatabase(databaseName);
        MongoCollection<Document> collection = database.getCollection(collectionName);

        // Clear the existing collection contents
        collection.deleteMany(new Document());

        // Handle file upload
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);

        try {
            List<FileItem> items = upload.parseRequest(request);
            for (FileItem item : items) {
                if (!item.isFormField()) {
                    // Process the uploaded file
                    try (InputStream inputStream = item.getInputStream();
                         BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream))) {
                        String line;
                        while ((line = reader.readLine()) != null) {
                            String[] data = line.split(",");
                            if (data.length == 4) {
                                Document doc = new Document("firstName", data[0].trim())
                                                .append("lastName", data[1].trim())
                                                .append("grade", data[2].trim())
                                                .append("house", data[3].trim());
                                collection.insertOne(doc);
                            }
                        }
                    }
                }
            }
            out.println("<p>CSV file uploaded and database updated successfully.</p>");
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    } catch (Exception e) {
        out.println("<p>Error connecting to MongoDB: " + e.getMessage() + "</p>");
    }
}
%>

</body>
</html>
