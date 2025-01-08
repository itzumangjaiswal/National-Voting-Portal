<%@ page import="java.util.List"%>
<%@ page import="com.votingSystem.entity.Election"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Voter Election History</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/tables.css">


</head>
<body>
	<%
	List<Election> elections = (List<Election>) request.getAttribute("elections");
	%>


	<h2 style="color: black">Voter Election History</h2>

	<table>
		<thead>
			<tr>
				<th>Election Name</th>
				<th>Election Type</th>
				<th>Date and Time</th>
			</tr>
		</thead>
		<tbody>
			<%
			if (elections != null && !elections.isEmpty()) {
				for (Election election : elections) {
			%>
			<tr>
				<td><%=election.getElectionName()%></td>
				<td><%=election.getElectionType()%></td>
				<td><%=election.getStartDate().toString().replace("T", " ")%></td>
				<!-- Format date to remove 'T' -->
			</tr>
			<%
			}
			} else {
			%>
			<tr>
				<td colspan="3" style="text-align: center;">No election history
					available</td>
			</tr>
			<%
			}
			%>
		</tbody>
	</table>

</body>
</html>
