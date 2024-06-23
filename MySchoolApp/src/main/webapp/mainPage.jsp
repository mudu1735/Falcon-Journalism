<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Falcon Journalism Interview Database</title>
    <style>
    	@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400&display=swap');
    	
        body {
            font-family: 'Poppins', sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            height: 100vh;
            margin: 0;
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
            box-sizing: border-box; 
            
        }
        .logo {
            display: flex;
            align-items: center;
            height: 100%;
        }
        .logo img {
            height: 80px;
            margin-right: 2px;
            margin-left: 0px;
        }
        .logo span {
            color: #f2f2f2;
            font-size: 18px;
            line-height: 60px; /* Adjust line-height to center text vertically */
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
            line-height: 32px; /* Adjust line-height to center text vertically */
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
        h1 {
            margin-top: 50px;
            margin-bottom: 20px;
        }
        .input-container {
            display: flex;
            align-items: center;
            width: 450px;
            border: 1px solid #ccc;
            border-radius: 25px;
            padding: 10px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
        }
        .input-container input {
            font-family: 'Poppins', sans-serif;        	
            border: none;
            outline: none;
            flex: 1;
            padding: 10px;
            font-size: 16px;
            border-radius: 25px;
        }
        .input-container button {
            font-family: 'Poppins', sans-serif;
            background-color: #f1f1f1;
            border: none;
            padding: 10px 20px;
            border-radius: 25px;
            cursor: pointer;
            font-size: 16px;
            color: #555;
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        .input-container button:hover {
            background-color: #ddd;
            color: black;
        }
        .input-container input::placeholder {
            color: #aaa;
        }
        .input-container button:disabled {
            cursor: not-allowed;
            color: #aaa;
        }
        .view-all-button {
            margin-top: 20px;
        }
    </style>
</head>
<body>

<nav>
    <div class="logo">
        <img src="https://cdn.discordapp.com/attachments/649035487247597571/1253855182924677170/Untitled-removebg-preview.png?ex=66775f23&is=66760da3&hm=4fde98d0b3d7843fdcc82a73cdc921a507edafc110ffcce301d0e614bb9997fa&" alt="Logo Placeholder">
        <span>Falcon Journalism</span>
    </div>
    <div class="nav-links">
        <a href="mainPage.jsp">Home</a>
        <a href="viewAllRecords.jsp">View All Records</a>
        <a href="userManual.jsp">User Manual</a>
        <button onclick="window.location.href='loginPage.jsp'">Sign Out</button>
    </div>
</nav>

<h1>Falcon Journalism Interview Database</h1>

<form action="scrapedContent.jsp" method="post">
    <div class="input-container">
        <input type="text" id="inputText" name="userLink" placeholder="Enter the link of your article" required>
        <button type="submit">Submit</button>
    </div>
</form>

</body>
</html>
