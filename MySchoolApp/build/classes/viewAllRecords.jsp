<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.BufferedReader, java.io.FileReader, java.io.IOException, java.util.ArrayList, java.util.Collections, java.util.List" %>
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
            height: 60px;
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
    </style>
</head>
<body>
<nav>
    <div class="logo">
        <img src="https://lh7-us.googleusercontent.com/ijnjbn2z7Haqm89zaW21ot3TIBEuhhjyQYGQDwdBGuMHQkp6H_pcRUGa3VKrzASCpef2Pw72pb7JcZZiigMblJkBHupfFxS80Khc6vmaV86DcVVNRSe75hLnnkSIehhz1O4BM39Uxmi0NgYYk3jNlyI" alt="Logo Placeholder">
        <span>Falcon Journalism</span>
    </div>
    <div class="nav-links">
        <a href="mainPage.jsp">Home</a>
        <a href="viewAllRecords.jsp">View All Records</a>
        <a href="userManual.jsp">User Manual</a>
        <button onclick="window.location.href='loginPage.jsp'">Sign Out</button>
    </div>
</nav>

<h1>Records Database</h1>

<form method="GET">
    <label for="searchFirstName">First Name:</label>
    <input type="text" id="searchFirstName" name="searchFirstName">
    <label for="searchLastName">Last Name:</label>
    <input type="text" id="searchLastName" name="searchLastName">
    <label for="searchGrade">Grade:</label>
    <input type="text" id="searchGrade" name="searchGrade">
    <label for="searchHouse">House:</label>
    <select id="searchHouse" name="searchHouse">
        <option value="">All</option>
        <option value="SMCS" <%= "SMCS".equals(request.getParameter("searchHouse")) ? "selected" : "" %>>SMCS</option>
        <option value="Global" <%= "Global".equals(request.getParameter("searchHouse")) ? "selected" : "" %>>Global</option>
        <option value="Humanities" <%= "Humanities".equals(request.getParameter("searchHouse")) ? "selected" : "" %>>Humanities</option>
        <option value="ISP" <%= "ISP".equals(request.getParameter("searchHouse")) ? "selected" : "" %>>ISP</option>
    </select>
    <label for="sortOrder">Sort By Date:</label>
    <select id="sortOrder" name="sortOrder">
        <option value="asc" <%= "asc".equals(request.getParameter("sortOrder")) ? "selected" : "" %>>Ascending</option>
        <option value="desc" <%= "desc".equals(request.getParameter("sortOrder")) ? "selected" : "" %>>Descending</option>
    </select>
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
            String[] values = line.split(",");
            if (values.length == 6) {  // Ensure there are exactly six columns
                records.add(values);
            }
        }

        // Get search parameters from request
        String searchFirstName = request.getParameter("searchFirstName");
        String searchLastName = request.getParameter("searchLastName");
        String searchGrade = request.getParameter("searchGrade");
        String searchHouse = request.getParameter("searchHouse");
        String sortOrder = request.getParameter("sortOrder");

        // Filter records based on search parameters
        List<String[]> filteredRecords = new ArrayList<>();
        if ((searchFirstName != null && !searchFirstName.isEmpty()) || 
            (searchLastName != null && !searchLastName.isEmpty()) || 
            (searchGrade != null && !searchGrade.isEmpty()) || 
            (searchHouse != null && !searchHouse.isEmpty())) {
            for (String[] record : records) {
                if ((searchFirstName == null || searchFirstName.isEmpty() || record[0].equalsIgnoreCase(searchFirstName)) &&
                        (searchLastName == null || searchLastName.isEmpty() || record[1].equalsIgnoreCase(searchLastName)) &&
                        (searchGrade == null || searchGrade.isEmpty() || record[2].equalsIgnoreCase(searchGrade)) &&
                        (searchHouse == null || searchHouse.isEmpty() || record[3].equalsIgnoreCase(searchHouse))) {
                    filteredRecords.add(record);
                }
            }
        } else {
            filteredRecords = records; // If no search parameters are provided, show all records
        }

        // Reverse the list if sortOrder is "desc"
        if ("desc".equals(sortOrder)) {
            Collections.reverse(filteredRecords);
        }

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
    <% for (String[] record : filteredRecords) { %>
    <tr>
        <td><%= record[0] %></td>
        <td><%= record[1] %></td>
        <td><%= record[2] %></td>
        <td><%= record[3] %></td>
        <td><a href="<%= record[4] %>"><%= record[4] %></a></td>
        <td><%= record[5] %></td>
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
