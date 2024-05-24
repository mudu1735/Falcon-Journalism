<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="mcps.phs.arx.NameFinder, mcps.phs.arx.LinkProcessing" %>
<%@ page import="java.io.BufferedReader, java.io.FileReader, java.io.IOException" %>
<!DOCTYPE html>
<html>
<head>
    <title>Scraped Content</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
        }
        th {
            background-color: #f4f4f4;
        }
    </style>
</head>
<body>

<h1>Scraped Content</h1>

<%
    String scrapeUrl = request.getParameter("userLink");
    String csvFile = "names.csv";
    String interviewRecordsFile = "c:\\tmp\\interviewRecords.csv";
    
    try {
        // Process the link to find names
        NameFinder nf = new NameFinder(csvFile, scrapeUrl);
        int newLines = nf.findNamesInArticle();
        // Store newLines in request object
        request.setAttribute("newLines", newLines);
%>
        <p>Successfully recorded</p>
<%
    } catch (IOException e) {
%>
        <p>Error fetching URL: <%= e.getMessage() %></p>
<%
    }

    // Reading and displaying the interviewRecords.csv file
    try (BufferedReader br = new BufferedReader(new FileReader(interviewRecordsFile))) {
        String line;
        // Retrieve newLines from request object
        int newLines = (int) request.getAttribute("newLines");
%>
        <table>
            <thead>
                <tr>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>URL</th>
                </tr>
            </thead>
            <tbody>
<%      
        int count = 0;
        while ((line = br.readLine()) != null && count < newLines + 1) {
            String[] values = line.split(",");
            if (values.length == 3) {  // Ensure there are exactly three columns
%>
                <tr>
                    <td><%= values[0] %></td>
                    <td><%= values[1] %></td>
                    <td><a href="<%= values[2] %>"><%= values[2] %></a></td>
                </tr>
<%
            }
            count++;
        }
%>
            </tbody>
        </table>
<%
    } catch (IOException e) {
%>
        <p>Error reading CSV file: <%= e.getMessage() %></p>
<%
    }
%>

</body>
</html>
