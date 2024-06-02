<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400&display=swap');

        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            font-family: 'Poppins', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            background: #f0f0f0;
        }
        .container {
            display: flex;
            width: 900px;
            height: 500px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.25);
            background: #fff;
            border-top-left-radius: 8px;
            border-bottom-left-radius: 8px;
            border-top-right-radius: 8px;
            border-bottom-right-radius: 8px;
        }
        .image-section {
            flex: 1;
            background-image: url('https://lh7-us.googleusercontent.com/ijnjbn2z7Haqm89zaW21ot3TIBEuhhjyQYGQDwdBGuMHQkp6H_pcRUGa3VKrzASCpef2Pw72pb7JcZZiigMblJkBHupfFxS80Khc6vmaV86DcVVNRSe75hLnnkSIehhz1O4BM39Uxmi0NgYYk3jNlyI'); /* Replace with your image URL */
            background-size: cover;
            background-position: center;
            border-top-left-radius: 8px;
            border-bottom-left-radius: 8px;
        }
        .form-section {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            padding: 20px;
            position: relative;
        }
        .form-container {
            width: 80%;
        }
        h1 {
            margin-bottom: 10px;
            font-size: 22px; /* Smaller font size to fit in one line */
            text-align: center;
        }
        h2 {
            margin-top: 50px;
            margin-bottom: 30px;
            font-size: 24px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            background-color: #ffffff;
            color: black;
            font-size: 16px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #D3D3D3;
        }
        .footer {
            position: absolute;
            bottom: 20px;
            text-align: center;
            width: 100%;
            color: #aaa;
            font-size: 12px;
        }
        .footer a {
            color: #aaa;
            text-decoration: none;
        }
        .footer a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="image-section"></div>
        <div class="form-section">
            <div class="form-container">
                <h1>Poolesville Pulse Database</h1>
                <h2>Sign In</h2>
                <form id="loginForm" onsubmit="return validateForm()">
                    <label for="username">Token</label>
                    <input type="text" id="username" name="username" required>
                    <input type="submit" value="Sign In">
                </form>
            </div>
            <div class="footer">
                &copy; 2024 - ARX
            </div>
        </div>
    </div>

    <script>
        function validateForm() {
            var username = document.getElementById("username").value;

            // Simple validation
            if (username === "a") {
                alert("Login successful!");
                window.location.href = "mainPage.jsp"; // Redirect to mainPage.jsp
                return false; // Prevent form submission
            } else {
                alert("Invalid username");
                return false; // Prevent form submission
            }
        }
    </script>
</body>
</html>
