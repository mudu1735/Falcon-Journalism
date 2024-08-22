<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <jsp:include page="sessionCheck.jsp" />
 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User Manual</title>
<style>
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400&display=swap');
    body {
        font-family: 'Poppins', sans-serif;
        margin: 0;
        padding: 0;
        background: #f9f9f9;
        color: #333;
        margin-bottom: 25px;        
    }
    nav {
        width: 100%;
        height: 10vh;
        background-color: #000000;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 10px 20px;
        box-sizing: border-box; 
        
    }
    .logo {
        display: flex;
        align-items: center;
    }
    .logo img {
        height: 80px;
        margin-right: 20px;
    }
    .logo span {
        color: #f2f2f2;
        font-size: 18px;
    }
    nav a, nav button {
        color: #f2f2f2;
        text-align: center;
        padding: 0px 18px;
        text-decoration: none;
        background: none;
        border: none;
        cursor: pointer;
        font-size: 18px;
        font-family: 'Poppins', sans-serif;
        transition: 0.3s ease;

    }
    nav a:hover, nav button:hover {
        color: #d4af37;
    }
    .nav-links {
        display: flex;
        align-items: center;
    }
    .container {
        padding: 20px;
        max-width: 800px;
        margin: 0 auto;
        background: #fff;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        border-radius: 8px;
        margin-top: 20px;
    }
    h1, h2 {
        text-align: center;
        color: #333;
    }
    p {
        line-height: 1.6;
    }
    ul {
        margin: 20px 0;
        padding-left: 20px;
    }
    ul li {
        margin-bottom: 10px;
    }
    .center {
  		display: block;
 		margin-left: auto;
  		margin-right: auto;
 		width: 50%;
 		margin-top: 35px;
 		margin-bottom: 35px;
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
		%>
        	<a href="uploadNames.jsp">Update Names</a> 

        <% } %>
        
        <button onclick="window.location.href='sessionEnd.jsp'">Sign Out</button>
    </div>
</nav>

<div class="container">
    <h1>Welcome to Falcon Journalism!</h1>
    <h2>User Guide</h2>
    <p>Welcome to Falcon Journalism's official website. This guide will help you navigate through our website and make the most out of our features.</p>

    <h2>1. Home Page</h2>
    <p>On the home page, you will find an input box that asks for the link of your article. Simply copy and paste the link of an existing article on the Poolesville Pulse. Click submit, and the article will automatically be processed. It will display all of the interviews found in your submitted article. Note that some may not show up because duplicate submissions are filtered out.</p>

    <h2>2. View All Records</h2>
    <p>The "View All Records" page allows you to see a complete list of all interview records stored in our database. You can search for specific records using the search feature.</p>
    <ul>
        <li>To search by first name, enter the first name in the provided input box.</li>
        <li>To search by last name, enter the last name in the provided input box.</li>
        <li>To search by first AND last name, enter the first and last name in each corresponding input box.</li>
        <li>To filter by grade, enter a grade level from 9-12. Enter "Staff" to filter records of staff members.</li>
        <li>To filter by house, select a house from the dropdown menu.</li>
        <li>To view the records from oldest to newest, select ascending in the "Sort by Date" dropdown menu.</li>
        <li>To view the records from newest to oldest, select descending in the "Sort by Date" dropdown menu.</li>
        <li>Click the "Search" button to filter the records based on your input.</li>
        
    </ul>

    <h2>3. Signing Out</h2>
    <p>To sign out, click the "Sign Out" button in the navigation bar. This will end your session and redirect you to the login page.</p>
	
	<h2>4. Updating Names</h2>
	<p>To update the names of students and staff, click the "Upload CSV" button in the navigation bar. </p>
	<ol>
		<li>Create a new Google Spreadsheet</li>
		<li>Format the student and staff information as shown below:</li>
	</ol>
	<img src="https://github.com/mudu1735/Falcon-Journalism/blob/main/dataExample.png?raw=true" alt="alternatetext" class="center">
	<ol start="3">
		<li>In the top right corner, click <strong>File -> Download -> Comma Separated Values (.csv)</strong></li>
		<li>Upload your .csv file in the "Upload CSV" page, and click upload</li>
	</ol>
	
    <h2>Contact Us</h2>
    <p>If you have any questions or need further assistance, please feel free to contact our support team at smcs2026.arx@gmail.com.</p>
</div>

</body>
</html>
