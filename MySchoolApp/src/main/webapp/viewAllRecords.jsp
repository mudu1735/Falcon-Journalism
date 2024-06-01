<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            margin-top: 20px;
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

<h1>Records Database</h1>

<form method="GET">
    <label for="searchFirstName">First Name:</label>
    <input type="text" id="searchFirstName" name="searchFirstName">
    <label for="searchLastName">Last Name:</label>
    <input type="text" id="searchLastName" name="searchLastName">
    <button type="submit">Search</button>
</form>

<%
    String interviewRecordsFile = "c:\\tmp\\interviewRecords.csv";

    // Reading and displaying the interviewRecords.csv file
    try (BufferedReader br = new BufferedReader(new FileReader(interviewRecordsFile))) {
        String line;

        List<String[]> records = new ArrayList<>();

        // Read all lines into the list
        while ((line = br.readLine()) != null) {
            System.out.println(line);
            String[] values = line.split(",");
            if (values.length == 4) {  // Ensure there are exactly four columns
                records.add(values);
            }
        }

        // Get search first name and last name from request parameters
        String searchFirstName = request.getParameter("searchFirstName");
        String searchLastName = request.getParameter("searchLastName");

        // Filter records based on search first name and last name
        List<String[]> filteredRecords = new ArrayList<>();
        if ((searchFirstName != null && !searchFirstName.isEmpty()) || (searchLastName != null && !searchLastName.isEmpty())) {
            for (String[] record : records) {
                if ((searchFirstName == null || searchFirstName.isEmpty() || record[0].equalsIgnoreCase(searchFirstName)) &&
                        (searchLastName == null || searchLastName.isEmpty() || record[1].equalsIgnoreCase(searchLastName))) {
                    filteredRecords.add(record);
                }
            }
        } else {
            filteredRecords = records; // If search first name and last name are not provided, show all records
        }
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
    <% for (String[] record : filteredRecords) { %>
    <tr>
        <td><%= record[0] %></td>
        <td><%= record[1] %></td>
        <td><a href="<%= record[2] %>"><%= record[2] %></a></td>
        <td><%= record[3] %></td>
    </tr>
    <% } %>
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
