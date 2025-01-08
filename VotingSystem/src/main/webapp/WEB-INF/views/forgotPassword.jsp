<%--
  Created by IntelliJ IDEA.
  User: araaz
  Date: 20-10-2024
  Time: 15:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="alert.jsp"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <script>
        function hide(elementId) {
            document.getElementById(elementId).style.display = 'none'
        }
    </script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="${pageContext.request.contextPath}images/favicon.png" type="image/x-icon">
    <title>ECI | Password Reset</title>
    <title>Password Reset</title>
    <style>

        .container {
            width: 450px;
            max-width: 400px;
            margin: 5% auto;
            text-align: center;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        input {
            display: block;
            width: 90%;
            padding: 10px;
            margin: 10px 0;
        }

        .buttons {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 4px;
            display: flex;
            justify-content: center;
        }
        .buttons:disabled{
            opacity: 0.4;
            cursor: not-allowed;
        }

        #emailInput:disabled {
            opacity: 0.3;
            cursor: not-allowed;
        }

        .spinner {
            border: 4px solid rgba(0, 0, 0, 0.2);
            border-top: 4px solid #000;
            border-radius: 50%;
            width: 8px;
            height: 8px;
            animation: spin 1s linear infinite;
            margin-left: 10px; /* Space between text and spinner */
        }
        @keyframes spin {
            0% {
                transform: rotate(0deg);
            }
            100% {
                transform: rotate(360deg);
            }
        }
    </style>
</head>
<%
    boolean emailExists = (boolean) request.getAttribute("emailExists");
    boolean isOtpValid = (boolean) request.getAttribute("isOtpValid");
%>

<body>

<jsp:include page="header.jsp"/>

<div id="alert"></div>

<div class="container">
    <h1>Password Reset</h1>


    <form method="post" action="/password-reset">

        <!-- Email Input -->
        <input type="email" name="email" id="emailInput" placeholder="Enter your email"
               value="${email}" ${emailExists ? 'disabled' : ''} required>

        <!-- Submit button for email -->
        <button class="buttons" type="submit" id="emailSubmit" >Submit Email</button>

        <!-- OTP Input (only shown if emailExists is true) -->
        <%
            if (emailExists) {
        %>
        <script>hide('emailSubmit')</script>

        <input type="text" name="otp" id="otpInput" placeholder="Enter OTP" required>
        <button class="buttons" type="submit" id="otpSubmit">Submit OTP</button>
        <%
            }
        %>

        <!-- New Password Inputs (only shown if isOtpValid is true) -->
        <%
            if (isOtpValid) {
        %>
        <script>hide('otpSubmit')</script>
        <script>
            hide('otpInput')
            document.getElementById('otpInput').remove()
        </script>
        <input type="password" name="newPassword" id="newPasswordInput" placeholder="Enter new password" required>

        <input type="password" name="confirmPassword" id="confirmPasswordInput" placeholder="Confirm new password"
               required>
        <button class="buttons" type="submit" id="passwordSubmit">Reset Password</button>
        <%
            }
        %>
    </form>
</div>

</body>
<script>

    const form = document.querySelector('form'); // Select the form
    const submitButton = document.getElementById('emailSubmit')
    form.addEventListener('submit', (event) => {
        // Add spinning animation on the button
        submitButton.innerHTML = 'Submitting...<div class="spinner"></div>';

        // Also make it disabled to prevent multiple submissions
        submitButton.disabled = true;
    });

</script>
</html>
