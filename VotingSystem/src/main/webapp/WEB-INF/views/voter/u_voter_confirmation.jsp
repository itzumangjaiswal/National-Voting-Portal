<%@ page import="com.votingSystem.entity.Candidate" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="${pageContext.request.contextPath}images/favicon.png" type="image/x-icon">
    <title>ECI | Election Commissioner</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"> <!-- FontAwesome for icons -->

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/u_voterConfirmation.css">

</head>

<%
    String cloudinaryPrefix = "https://res.cloudinary.com/dl1hqxniz/image/upload/v1727458264/";

    Candidate candidate = (Candidate) request.getAttribute("candidate");

    String profilePicture = (String) request.getAttribute("profilePicture");
    String partyLogo = (String) request.getAttribute("partyLogo");
    String electionName = (String) request.getAttribute("electionName");

    int voterId = (int) request.getAttribute("voterId");
    int electionId = (int) request.getAttribute("electionId");
    int candidateId = (int) request.getAttribute("candidateId");

%>

<body>

<jsp:include page="../header.jsp" />

<div class="profile-container">
    <!-- Left Section: Profile Picture -->
    <div class="left-section">
        <div class="profile-picture">
            <img src="<%=cloudinaryPrefix + partyLogo%>" alt="Party Logo" style="margin-top: 10em;">
            <br/><br/><br/>
            <label for="party-name" style="margin-top: 45%">Party Name:</label>
            <p id="party-name"> <%=candidate.getPartyName()%> </p>
        </div>
    </div>

    <!-- Right Section: Profile Details and Confirmation -->
    <div class="right-section">
        <div class="container">
            <!-- Candidate Details and Image -->
            <div class="profile-details">
                <h2>Candidate Details</h2>

                <!-- Flex container to align details and image -->
                <div class="profile-info-wrapper">
                    <!-- Candidate Info -->
                    <div class="profile-info">

                        <label for="profile-name">Candidate Name:</label>
                        <p id="profile-name"> <%=candidate.getCandidateName()%> </p>
                        <br/><br/><br/>

                        <label for="election-name">Election Name:</label>
                        <p id="election-name"> <%=electionName%> </p>
                        <br/><br/><br/>


                        <label for="about-candidate">About:</label>
                        <p id="about-candidate"> <%=candidate.getCandidateDescription()%> </p>
                    </div>

                    <!-- Image on the right side -->
                    <div class="profile-picture-right">
                        <img src="<%=cloudinaryPrefix + profilePicture%>" alt="Party Logo">
                    </div>
                </div>

                <form action="/voter/voting" method="post" enctype="multipart/form-data">

                    <input type="hidden" name="voterId" value="<%=voterId%>">
                    <input type="hidden" name="electionId" value="<%=electionId%>">
                    <input type="hidden" name="candidateId" value="<%=candidateId%>">
                    <input type="hidden" name="electionName" value="<%=electionName%>">

                    <!-- Buttons -->
                    <div class="confirmation-buttons">

                        <button type="submit" id="yesButton" class="btn">Vote</button>
                    </div>
                </form>


            </div>
        </div>
    </div>
</div>



</body>

<script>
    const form = document.querySelector('form'); // Select the form
    const submitButton = document.getElementById('yesButton');

    form.addEventListener('submit', (event) => {
        // Add spinning animation on the button
        submitButton.innerHTML = 'Voting...<div class="spinner"></div>';

        // Also make it disabled to prevent multiple submissions
        submitButton.disabled = true;
    });


    function goBack(){
        window.history.back()
    }
</script>

</html>
