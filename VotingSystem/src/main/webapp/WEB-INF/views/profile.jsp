<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<jsp:include page="alert.jsp"/>
<!DOCTYPE html>
<html lang="en">
<head>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/profile.css"> <!-- Link to external CSS file -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- FontAwesome for icons -->
</head>
<body>

<%
    String cloudinaryPrefix = "https://res.cloudinary.com/dl1hqxniz/image/upload/v1727458264/";
    Map<String, String> userDetails = (Map<String, String>) request.getAttribute("userDetails");

    String imageLink = cloudinaryPrefix + userDetails.get("imagePublicId");
%>


<div class="profile-container">
    <!-- Left Section: Profile Picture -->
    <div class="left-section">
        <div class="profile-picture">
            <img src="<%= imageLink%>" alt="Profile Picture">
        </div>
        <div class="update-picture">
            <button class="btn" disabled>Update Picture</button>
        </div>
    </div>

    <!-- Right Section: Profile Details -->
    <div class="right-section">

        <div class="profile-details">
            <h2>Profile Details</h2>


            <button id="logout-btn" class="logout-button">Logout</button>


            <div class="profile-info">
<%--                <label for="profile_role">Role:</label>--%>
                <p id="profile_role" style="color: red;font-weight: bolder;font-size: large;"> <%=userDetails.get("role")%> </p>
            </div>

            <div class="profile-info">
                <label for="profile-id">Id:</label>
                <p id="profile-id"><%=userDetails.get("userId")%>
                </p>
            </div>


            <div class="profile-info">
                <label for="profile-name">Name:</label>
                <p id="profile-name"><%=userDetails.get("name")%>
                </p>
            </div>

            <div class="profile-info">
                <label for="profile-email">Email:</label>
                <p id="profile-email"><%=userDetails.get("email")%>
                </p>
            </div>


            <div class="profile-info">
                <label for="profile-id">Aadhaar Number:</label>
                <p id="aadharNumber"><%=userDetails.get("aadharNumber")%>
                </p>
            </div>


        </div>
    </div>
</div>

<script>

    btn = document.getElementById('logout-btn')
    btn.addEventListener('click', () => {
        // Reset the token cookie on the client side
        document.cookie = "token=NA; Max-Age=0; Path=/;"; // Clear the cookie

        // Store a flash message in session storage
        sessionStorage.setItem('logoutMessage', 'Logged Out!');


        // Redirect the entire parent window to the root ("/")
        window.top.location.href = '/'; // Redirect the whole page
    })

</script>


</body>
</html>
