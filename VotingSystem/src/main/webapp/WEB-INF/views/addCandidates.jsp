<%@ page import="java.util.List" %>
<%@ page import="com.votingSystem.entity.Candidate" %>
<%@ page import="com.votingSystem.entity.Election" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tables.css">
</head>
<body>
<%
    String electionId = request.getParameter("electionId");
    List<Candidate> allCandidates = (List<Candidate>) request.getAttribute("allCandidates");
%>

<h2 style="color: black">Select Candidates for Election ID: <%= electionId %></h2>
<form action="${pageContext.request.contextPath}/submitCandidates" method="post">
    <input type="hidden" name="electionId" value="<%= electionId %>">
    <div id="candidateList">
        <%
            if (allCandidates != null && !allCandidates.isEmpty()) {
                for (Candidate candidate : allCandidates) {
        %>
        <label>
            <input type="checkbox" name="candidateIds" value="<%= candidate.getCandidateId() %>">
            <%= candidate.getCandidateName() %> (ID: <%= candidate.getCandidateId() %>)
        </label><br>
        <%
                }
            } else {
        %>
        <p>No candidates available for selection.</p>
        <%
            }
        %>
    </div>
    <div class="button-container">
        <button type="button" class="btn-warning" onclick="window.history.back()">Cancel</button>
        <button type="submit" class="btn-cancel">Submit</button>
    </div>
</form>
</body>
</html>
