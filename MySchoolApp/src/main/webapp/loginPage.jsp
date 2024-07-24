<%@ page import="mcps.phs.arx.NameFinder, mcps.phs.arx.LinkProcessing, mcps.phs.arx.LoginValidation" %>

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
            position: relative;
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
        	margin-top: -20px;
            margin-bottom: 40px;
            font-size: 22px; /* Smaller font size to fit in one line */
            text-align: center;
        }
        h2 {
            margin-top: 20px;
            margin-bottom: 20px;
            font-size: 24px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="password"], input[type = "text"] {
        	width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }
        input[type="password"], input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }
        .show-password {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        .show-password input {
            margin-right: 10px;
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
            margin-bottom: 10px;
        }
        input[type="submit"]:hover {
            background-color: #D3D3D3;
        }
        .footer {
        	margin-bottom: -10px;
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
        .login-message {
            display: none;
            position: absolute;
            top: 89%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: rgba(255, 255, 255, 0);
            padding: 20px;
            border-radius: 0px;
            color: green;
            font-weight: bold;
            z-index: 10;
        }
        
        .login-failed {
            display: none;
            position: absolute;
            top: 89%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: rgba(255, 255, 255, 0);
            padding: 20px;
            border-radius: 0px;
            color: red;
            font-weight: bold;
            z-index: 10;
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
                <form action = "loginPage.jsp" method = "post">
                   	<label for="username">Username</label>
                  	<input type="text" id="username" name="username" required>
                   	<label for="password">Password</label>
                   	<input type="password" id="password" name="pass" required>
                
                    <div class="show-password">
                        <input type="checkbox" id="showPassword" onclick="togglePasswordVisibility()">
                        <label for="showPassword">Show password</label>
                    </div>
                    <input type="submit" value="Sign In">
               </form>
               <div class="login-message" id="loginMessage" style = "display: none;">Logging you in...</div>
			   <div class="login-failed" id="loginFailed" style="display: none;">Invalid credentials</div>
               
               
<%
		String user = request.getParameter("username");
        String pass = request.getParameter("pass");
        //System.out.println("Entered user: " + user);
        //System.out.println("Entered pass: " + pass);
		
        //HttpSession session1 = request.getSession(); 

		LoginValidation lv = new LoginValidation();
		boolean vali = true;
		vali = lv.loginCheck(user, pass);
		//System.out.println(vali);
		if(vali == true) {
	            session.setAttribute("user", user); 
	            
				System.out.println("Login info valid");
		
%>
 				<script type="text/javascript">
 					var loginMessage = document.getElementById("loginMessage");
 	                loginMessage.style.display = "block"; // Show the login message

 	                setTimeout(function() {
 	                    window.location.href = "mainPage.jsp"; // Redirect to mainPage.jsp after 1.5 second
 	                }, 1500);
 				</script>
				
<%	
		}
		if(user != null && pass != null && !vali){
			System.out.println("WRONGWRONGWRONG");
			
%>
 			<script type="text/javascript">
 				
 			document.getElementById("loginFailed").style="display: block;";
 			</script>
<% 
			}
		
%>
                
            </div>
            <div class="footer">
                &copy; 2024 - ARX
            </div>
        </div>
    </div>

    <script>
        function togglePasswordVisibility() {
        	var passwordInput = document.getElementById("password");
            var showPasswordCheckbox = document.getElementById("showPassword");
            if (showPasswordCheckbox.checked) {
                passwordInput.type = "text";
            } else {
                passwordInput.type = "password";
            }
        }
        


        function loginRedirect() {		
            // Validation
            
            	alert("HIIIII");
                var loginMessage = document.getElementById("loginMessage");
                loginMessage.style.display = "block"; // Show the login message

                setTimeout(function() {
                    window.location.href = "mainPage.jsp"; // Redirect to mainPage.jsp after 1.5 second
                }, 1500);
   
        }
    </script>
</body>
</html>