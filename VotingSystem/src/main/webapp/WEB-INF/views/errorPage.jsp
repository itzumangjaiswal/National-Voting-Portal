 
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.png" type="image/x-icon">
    <title>ECI | Application Error</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f2f2f2;
            margin: 0;
        }

        .error-container {
            text-align: center;
            animation: fadeIn 2s ease-in-out;
        }

        @keyframes fadeIn {
            0% {
                opacity: 0;
                transform: translateY(-30px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .error-image {
            width: 300px;
            margin-bottom: 20px;
        }

        h1 {
            color: #ff4c4c;
            font-size: 48px;
            margin-bottom: 10px;
        }

        p {
            font-size: 18px;
            color: #333;
        }

        .back-home {
            display: inline-block;
            padding: 10px 20px;
            margin-top: 20px;
            color: white;
            background-color: #007bff;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .back-home:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="error-container">
    <img src="${pageContext.request.contextPath}/images/error-bg.png" alt="Error Image" class="error-image">

    <p>We can't seem to find the resource you're looking for.</p>
    <p style="color: red">${message}</p>
    <a onclick="goBack()" class="back-home">Go Back</a>
</div>

</body>

<script>
    function goBack() {
        window.history.back();
    }
</script>

</html>
