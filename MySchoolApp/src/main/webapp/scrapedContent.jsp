<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="mcps.phs.arx.NameFinder, mcps.phs.arx.LinkProcessing" %>
<%@ page import="java.io.BufferedReader, java.io.FileReader, java.io.IOException, java.util.ArrayList, java.util.List" %>
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

<button onclick="window.location.href='mainPage.jsp'">Back to Main Page</button>

<h1>Newly Added Records</h1>

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
        List<String> lines = new ArrayList<>();
        
        // Read all lines into the list
        while ((line = br.readLine()) != null) {
            lines.add(line);
        }
        
        // Retrieve newLines from request object
        int newLines = (int) request.getAttribute("newLines");
%>
        <table>
            <thead>
                <tr>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>URL</th>
                    <th>Date Added</th>
                </tr>
            </thead>
            <tbody>
<%
        // Print a message if newLines is 0
        if (newLines == 0) {
%>
            <p>No new interviews were found</p>
<%
        } else {
            // Iterate over the entire list in reverse order
            for (int i = lines.size() - 1; i >= lines.size() - newLines; i--) {
                String[] values = lines.get(i).split(",");
                //System.out.println(lines);
                
                if (values.length == 4) {  // Ensure there are exactly four columns
%>
                <tr>
                    <td><%= values[0] %></td>
                    <td><%= values[1] %></td>
                    <td><a href="<%= values[2] %>"><%= values[2] %></a></td>
                    <td><%= values[3] %></td>
                </tr>
<%
                }
            }
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
