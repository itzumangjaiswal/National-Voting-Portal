<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<jsp:include page="../alert.jsp"/>

<html lang="en">
<head>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/globalAlert.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/forms.css">



</head>
<body>

<h2 style="color: black">Regional Officer Registration </h2>

<div id="alert"></div>


<form action="/subAdmin/register" method="post" enctype="multipart/form-data">

	 <!-- Name -->
	    <label for="name">Full Name:</label>
	    <input type="text" id="name" name="name" placeholder="Enter your full name" required>

	    <!-- Email -->
	    <label for="email">Email:</label>
	    <input type="email" id="email" name="email" placeholder="Enter your email" required>

		<!-- 12-Digit Aadhaar Number (Separated by Dashes) -->
		    <label for="aadharNumber">Aadhar Number:</label>
		    <input type="text" id="aadharNumber" name="aadharNumber" placeholder="e.g. 1234-5678-9012" maxlength="14" onkeydown="addSpaces('aadharNumber')" required>
		
	    <!-- Profile Picture -->
	    <label for="profilePic">Profile Picture:</label>
	    <input type="file" id="profilePic" name="profilePic" accept="image/*" required>

	    <!-- Password -->
	    <label for="password">Password:</label>
	    <input type="password" id="password" name="password" placeholder="Enter your password" required>

	    <!-- Confirm Password -->
	    <label for="confirmPassword">Confirm Password:</label>
	    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm your password" required>

	    <!-- Submit Button -->
	<!--    <input type="submit" value="Register" id="submitButton">-->
	    <div class="button-container">
	        <button type="reset" id="resetButton">Reset</button>
	        <button type = "submit" id="submitButton">Submit</button>
	    </div>


</form>

<script>

    function addSpaces(elementId){

        let element = document.getElementById(elementId)

        if(element.value.length === 4 || element.value.length === 9){
            element.value = element.value + '-'
        }

    }


</script>



</body>





</html>
