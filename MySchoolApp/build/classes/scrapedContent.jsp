<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="mcps.phs.arx.NameFinder, mcps.phs.arx.LinkProcessing" %>
<%@ page import="java.io.BufferedReader, java.io.FileReader, java.io.IOException, java.util.ArrayList, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Record Submitted</title>
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
            height: 60px;
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

<h1>Newly Added Records</h1>

<%
    String scrapeUrl = request.getParameter("userLink");
    String csvFile = "names.csv";
    String interviewRecordsFile = "c:\\tmp\\interviewRecords.csv";
    
    try {
        NameFinder nf = new NameFinder(csvFile, scrapeUrl);
        int newLines = nf.findNamesInArticle();
        request.setAttribute("newLines", newLines);
%>
        <p>Successfully recorded</p>
<%
    } catch (IOException e) {
%>
        <p>Error fetching URL: <%= e.getMessage() %></p>
<%
    }

    try (BufferedReader br = new BufferedReader(new FileReader(interviewRecordsFile))) {
        String line;
        List<String> lines = new ArrayList<>();

        while ((line = br.readLine()) != null) {
            lines.add(line);
        }

        int newLines = (int) request.getAttribute("newLines");
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
            for (int i = lines.size() - 1; i >= lines.size() - newLines; i--) {
                String[] values = lines.get(i).split(",");
                if (values.length == 6) {
%>
                <tr>
                    <td><%= values[0] %></td>
                    <td><%= values[1] %></td>
                    <td><%= values[2] %></td>
                    <td><%= values[3] %></td>
                    <td><a href="<%= values[4] %>"><%= values[4] %></a></td>
                    <td><%= values[5] %></td>
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
        <p>Error reading interview records: <%= e.getMessage() %></p>
<%
    }
%>

</body>
</html>
