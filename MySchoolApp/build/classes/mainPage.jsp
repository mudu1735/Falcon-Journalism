<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Falcon Journalism Interview Database</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f4f4f4;
        }
        h1 {
            margin-bottom: 20px;
        }
        .input-container {
            display: flex;
            align-items: center;
            width: 100%;
            max-width: 600px;
            border: 1px solid #ccc;
            border-radius: 25px;
            padding: 10px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .input-container input {
            border: none;
            outline: none;
            flex: 1;
            padding: 10px;
            font-size: 16px;
            border-radius: 25px;
        }
        .input-container button {
            background-color: #f1f1f1;
            border: none;
            padding: 10px 20px;
            border-radius: 25px;
            cursor: pointer;
            font-size: 16px;
            color: #555;
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

<h1>Falcon Journalism Interview Database</h1>

<form action="scrapedContent.jsp" method="post">
    <div class="input-container">
        <input type="text" id="inputText" name="userLink" placeholder="Enter the link of your article" required>
        <button type="submit">Submit</button>
    </div>
</form>

<button class="view-all-button" onclick="window.location.href='viewAllRecords.jsp'">View All Records</button>

</body>
</html>
