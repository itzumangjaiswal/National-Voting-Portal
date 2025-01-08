<%@ page import="java.util.List" %>
<%@ page import="com.votingSystem.entity.Candidate" %>
<%@ page import="com.votingSystem.entity.User" %>
<%@ page import="com.votingSystem.entity.Election" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/confirmation.css">

</head>
<body>

<%
    List<User> allVoters = (List<User>) request.getAttribute("allVoters");
	User currentUser = (User)request.getAttribute("currentUser");
%>

<h2 style="color: black">All Pending Voters Information</h2>

<table>
    <thead>
        <tr>
            <th>Id</th>
            <th>Name</th>
            <th>Email</th>
            <th>Aadhar Number</th>
            <th>Disapprove Voter</th>
            <th>Approve Voter</th>
        </tr>
    </thead>
    <tbody>
        <%
        if (allVoters != null && !allVoters.isEmpty()) {
            for (User user : allVoters) {
        %>
        <tr>
            <td><%=user.getUserId()%></td>
            <td><%=user.getName()%></td>
            <td><%=user.getEmail()%></td>
            <td><%=user.getAadharNumber()%></td>

            <!-- Remove quotes around voterId, passing it as a number -->
            <td class="action-icons">
                <button class="icon-button icon-revoke" title="Move to Rejection list"
                        onclick="openRejectionModal(<%=user.getUserId()%>, <%=currentUser.getUserId()%>)">
                    <i class="fas fa-times-circle"></i>
                </button>
            </td>

            <td class="action-icons">
                <button class="icon-button icon-authorize" title="Approve Now"
                        onclick="confirmAction('/subAdmin/manageVoters?subAdminId=<%=currentUser.getUserId()%>&voterId=<%=user.getUserId()%>')">
                    <i class="fas fa-check-circle"></i>
                </button>
            </td>
        </tr>
        <%
            }
        }
        %>
    </tbody>
</table>

<!-- Confirmation Modal -->
<div id="confirmationModal" class="modal" style="display: none">
    <div class="modal-content">
        <h3>Are you sure you want to proceed?</h3>
        <div class="button-container">
            <button class="btn-warning" id="cancelButton">Cancel</button>
            <button class="btn-cancel" id="confirmButton">Confirm</button>
        </div>
    </div>
</div>

<!-- Rejection Modal -->
<div id="rejectionModal" class="modal" style="display: none">
      <form action = "/subAdmin/rejectVoterWithReason" method= "Post">
    <div class="modal-content">
    
        <h3>Are you sure you want to disapprove this voter?</h3>
        <p>If yes, please provide a reason for rejection:</p>
        <textarea  name= "reason" id="rejectionReason" placeholder="Describe reason"></textarea>
        <input name = "voterId" type = "hidden" id = "voterId" required/>
         <input name = "rejectorId" type = "hidden" id = "rejectorId" />  
        <div class="button-container">
        
            <button class="btn-warning" id="cancelRejectionButton">Cancel</button>
            <button class="btn-cancel" id="confirmRejectionButton" type ="submit">Confirm</button>
        </div>
    </div>
    </form>
</div>

<script>
// Declare variables globally
let globalVoterId = null;
let globalRejectorId = null;

// Function to handle approval confirmation modal
function confirmAction(actionUrl) {
    const modal = document.getElementById('confirmationModal');
    modal.style.display = 'block';

    document.getElementById('confirmButton').onclick = function () {
        window.top.location.href = actionUrl;
    };

    document.getElementById('cancelButton').onclick = function () {
        modal.style.display = 'none';
    };
}

// Function to handle rejection with reason
function openRejectionModal(voterId, rejectorId) {
    const modal = document.getElementById('rejectionModal');
    modal.style.display = 'block';

    document.getElementById('voterId').value = voterId
    document.getElementById('rejectorId').value = rejectorId
    

    // Handle confirm button action for rejection
  

    // Handle cancel button action
    document.getElementById('cancelRejectionButton').onclick = function () {
        modal.style.display = 'none';
    };
}
</script>

</body>
</html>