<%@ page import="java.util.List" %>
<%@ page import="com.votingSystem.entity.Election" %>
<%@ page import="com.votingSystem.entity.User" %>
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
    List<Election> allElections = (List<Election>) request.getAttribute("allOngoingElections");
    List<Election> previousElections = (List<Election>) request.getAttribute("allPreviousElections");
    List<User> allSubAdmins = (List<User>) request.getAttribute("allSubAdmins");
%>


<h2 style="color: black">All Regional Officers Information</h2>


<table>
    <thead>
    <tr>
        <th>Id</th>
        <th>Name</th>
        <th>Email</th>
        <th>Aadhaar Number</th>
        <th>Authority</th>
        <th>Manage Authority</th>
    </tr>
    </thead>
    <tbody>
    <%
        if (!allSubAdmins.isEmpty()){
            for(User user : allSubAdmins){

         %>
    <tr>
        <td> <%=user.getUserId() %> </td>
        <td> <%=user.getName() %> </td>
        <td> <%=user.getEmail() %> </td>
        <td> <%=user.getAadharNumber() %> </td>

        <%
            if(user.isAuthorityRevoked()){

        %>
                <td class="status-inactive">Inactive</td>
                <td class="action-icons">

                    <button class="icon-button icon-authorize" title="Authorize" onclick="confirmAction('/admin/manageAuthority?subAdmin=<%=user.getUserId() %>')">
                        <i class="fas fa-check-circle"></i>
                    </button>
                </td>
            <%
            }else{
            %>
                <td class="status-active">Active</td>
                <td class="action-icons">
                    <button class="icon-button icon-revoke" title="Revoke Authority" onclick="confirmAction('/admin/manageAuthority?subAdmin=<%=user.getUserId() %>')">
                        <i class="fas fa-times-circle"></i>
                    </button>
                </td>


    </tr>

           <%}
            }
        }else {
            %>
            <tr> -- No Sub Admins -- </tr>
        <%
        }
        %>


    </tbody>
</table>


<h2 style="color: black">All Election Information</h2>


<table>
    <thead>
    <tr>
        <th>Id</th>
        <th>Name</th>
        <th>Type</th>
        <th>Start Date</th>
        <th>End Date</th>
        <th>Created By</th>
        <th>Managed By</th>
    </tr>
    </thead>
    <tbody>

    <%
        if(!allElections.isEmpty()){
            for(Election election : allElections){
    %>
    <tr>
        <td><%=election.getElectionId() %></td>
        <td><%=election.getElectionName() %></td>
        <td><%=election.getElectionType() %></td>
        <td><%=election.getStartDate() %></td>
        <td><%=election.getEndDate() %></td>
        <td><%=election.getCreatedBy() %></td>
        <td><%=election.getAssignedTo() %></td>

    </tr>

    <%      }
    }else{
    %>
    <tr> -- No Elections -- </tr>
    <%
        }%>

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

<script>
    function confirmAction(actionUrl) {
        const modal = document.getElementById('confirmationModal');
        modal.style.display = 'block';

        document.getElementById('confirmButton').onclick = function () {
            // If confirmed, execute the action and refresh the main page
            window.top.location.href = actionUrl;
        };

        document.getElementById('cancelButton').onclick = function () {
            // If canceled, close the modal and do nothing
            modal.style.display = 'none';
        };
    }
</script>

</body>
</html>

