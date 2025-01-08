<%@ page import="java.util.List"%>
<%@ page import="com.votingSystem.entity.Election"%>
<%@ page import="com.votingSystem.entity.Candidate"%>
<%@ page import="com.votingSystem.entity.User"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/tables.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/confirmation.css">

</head>
<body>
	<%
	List<Election> allElections = (List<Election>) request.getAttribute("allElections");
	List<Candidate> allCandidates = (List<Candidate>) request.getAttribute("allCandidates");
	User currentUser = (User) request.getAttribute("currentUser");
	%>


	<h2 style="color: black">All Candidates Information</h2>
	<table>
		<thead>
			<tr>
				<th>Id</th>
				<th>Name</th>
				<th>Aadhaar Number</th>
				<th>Party Name</th>
				<th>Authority</th>
				<th>Manage Authority</th>
			</tr>
		</thead>
		<tbody>
			<%
			if (!allCandidates.isEmpty()) {
				for (Candidate candidate : allCandidates) {
			%>
			<tr>
				<td><%=candidate.getCandidateId()%></td>
				<td><%=candidate.getCandidateName()%></td>
				<td><%=candidate.getAadharNumber()%></td>
				<td><%=candidate.getPartyName()%></td>

				<%
				if (candidate.isCandidatureRevoked()) {
				%>
				<td class="status-inactive">Inactive</td>
				<td class="action-icons">

					<button class="icon-button icon-authorize" title="Authorize"
						onclick="confirmAction('/subAdmin/manageAuthority?subAdminId=<%=currentUser.getUserId()%>&candidateId=<%=candidate.getCandidateId()%>')">
						<i class="fas fa-check-circle"></i>
					</button>
				</td>
				<%
				} else {
				%>
				<td class="status-active">Active</td>
				<td class="action-icons">
					<button class="icon-button icon-revoke" title="Revoke Authority"
						onclick="confirmAction('/subAdmin/manageAuthority?subAdminId=<%=currentUser.getUserId()%>&candidateId=<%=candidate.getCandidateId()%>')">
						<i class="fas fa-times-circle"></i>
					</button>
				</td>


			</tr>

			<%
			}
			}
			} else {
			%>
			<tr>-- No Candidates --
			</tr>
			<%
			}
			%>


		</tbody>
	</table>


	<h2 style="color: black">All Elections Assigned To You</h2>
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
				<th>Add Candidates</th>
			</tr>
		</thead>
		<tbody>

			<%
			if (!allElections.isEmpty()) {
				for (Election election : allElections) {
			%>
			<tr>
				<td><%=election.getElectionId()%></td>
				<td><%=election.getElectionName()%></td>
				<td><%=election.getElectionType()%></td>
				<td><%=election.getStartDate()%></td>
				<td><%=election.getEndDate()%></td>
				<td><%=election.getCreatedBy()%></td>
				<td><%=election.getAssignedTo()%></td>

				<td><a href="javascript:void(0)" style="color: blue;"
					onclick="openCandidateModal('<%=election.getElectionId()%>')">Click
						here</a></td>



				<%
				}
				} else {
				%>
			
			<tr>-- No Elections --
			</tr>
			<%
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

	<!-- Modal for Managing Candidates -->
	<div id="candidateModal" class="modals" style="display: none">
		<div class="modals-content">
			<h3>
				Select Candidates for Election ID: <span id="electionIdSpan"></span>
			</h3>
			<form id="candidateForm"
				action="/subAdmin/addCandidates"
				method="post">
				<input type="hidden" name="electionId" id="electionIdInput" value="">
				<div id="candidateList">
					<!-- Candidate checkboxes will be populated here by JavaScript -->
				</div>
				<div class="button-container">
					<button type="button" class="btn-warning"
						onclick="closeCandidateModal()">Cancel</button>
					<button type="submit" class="btn-cancel">Submit</button>
				</div>
			</form>
		</div>
	</div>


	<script>
	 // Manually convert Java list of candidates to a JavaScript array
    const candidates = [
        <%if (allCandidates != null && !allCandidates.isEmpty()) {
	for (int i = 0; i < allCandidates.size(); i++) {
		Candidate candidate = allCandidates.get(i);%>
        {
            candidateId: "<%=candidate.getCandidateId()%>",
            candidateName: "<%=candidate.getCandidateName()%>"
        }<%if (i < allCandidates.size() - 1) {%>,<%}%> <!-- Add a comma except for the last element -->
        <%}
}%>
    ];
		function confirmAction(actionUrl) {
			const modal = document.getElementById('confirmationModal');
			modal.style.display = 'block';

			document.getElementById('confirmButton').onclick = function() {
				// If confirmed, execute the action and refresh the main page
				window.top.location.href = actionUrl;
			};

			document.getElementById('cancelButton').onclick = function() {
				// If canceled, close the modal and do nothing
				modal.style.display = 'none';
			};
		}
		
		// Function to open the candidate modal
	    function openCandidateModal(electionId) {
	        // Set the election ID in the modal
	        document.getElementById('electionIdSpan').innerText = electionId;
	        document.getElementById('electionIdInput').value = electionId;

	        // Populate the candidate list with checkboxes
	        const candidateListDiv = document.getElementById('candidateList');
	        candidateListDiv.innerHTML = ''; // Clear previous list

	        <%
			if (!allCandidates.isEmpty()) {
				for (Candidate candidate : allCandidates) {
			%>
	            candidateListDiv.innerHTML +=
	            	 
	             `<label>
	            
                <input type='checkbox' name="candidateIds" value= "<%=candidate.getCandidateId()%>">
				 <%=candidate.getCandidateName()%>     
            </label>
            </br>`;
            
	                
	 	        
	        <%
			}}
	        %>

	        // Display the modal
	        document.getElementById('candidateModal').style.display = 'block';
	    }

	    // Function to close the candidate modal
	    function closeCandidateModal() {
	        document.getElementById('candidateModal').style.display = 'none';
	    }
	</script>

</body>
</html>