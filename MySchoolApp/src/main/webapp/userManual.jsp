<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User Guide - Falcon Journalism</title>
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
        height: 60px;
        margin-right: 20px;
    }
    .logo span {
        color: #f2f2f2;
        font-size: 18px;
    }
    nav a, nav button {
        color: #f2f2f2;
        text-align: center;
        padding: 10px 15px;
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
        <button onclick="window.location.href='logout.jsp'">Sign Out</button>
    </div>
</nav>

<div class="container">
    <h1>Welcome to Falcon Journalism!</h1>
    <h2>User Guide</h2>
    <p>Welcome to Falcon Journalism's official website. This guide will help you navigate through our website and make the most out of our features.</p>

    <h2>1. Home Page</h2>
    <p>On the home page, you will find an input box that asks for the link of your article. Simply copy and paste the link of an existing article on the Poolesville Pulse. Click submit, and the article will automatically be processed.</p>

    <h2>2. View All Records</h2>
    <p>The "View All Records" page allows you to see a complete list of all interview records stored in our database. You can search for specific records using the search feature.</p>
    <ul>
        <li>To search by first name, enter the first name in the provided input box.</li>
        <li>To search by last name, enter the last name in the provided input box.</li>
        <li>To search by first AND last name, enter the first and last name in each corresponding input box.</li>
        <li>Click the "Search" button to filter the records based on your input.</li>
    </ul>

    <h2>3. Signing Out</h2>
    <p>To sign out, click the "Sign Out" button in the navigation bar. This will end your session and redirect you to the login page.</p>

    <h2>Contact Us</h2>
    <p>If you have any questions or need further assistance, please feel free to contact our support team at smcs2026.arx@gmail.com.</p>
</div>

</body>
</html>
