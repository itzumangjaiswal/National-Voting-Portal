<%--
  Created by IntelliJ IDEA.
  User: araaz
  Date: 18-10-2024
  Time: 20:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.png" type="image/x-icon">
  <title>ECI | Election Commissioner</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin_dashboard.css">
</head>

<%
  String message = (String) request.getAttribute("message");
%>

<body>
<!-- Header -->
<jsp:include page="../header.jsp" />

<!-- Dashboard Body Section with gradient background and centered container -->
<div class="dashboard-body">

  <div class="container">
    <% if(message != null){%>
    <h1> <%=message%> </h1>
    <%}%>
    <p>Click <a href="http://localhost:9091/u_voter_dashboard.html">here</a> to return to home</p>
  </div>
</div>
</body>

</html>

