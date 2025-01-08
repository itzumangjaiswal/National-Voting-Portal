<%@ page import="java.util.List" %>
<%@ page import="com.votingSystem.entity.User" %>
<%--
  Created by IntelliJ IDEA.
  User: araaz
  Date: 05-10-2024
  Time: 20:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="../alert.jsp"/>

<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/forms.css">

    <style>
        #created_by::placeholder {
            color: #b0c4de;
            opacity: 1;
            font-size: medium;
        }
    </style>

</head>
<body>
<%
    List<User> subAdmins = (List<User>) request.getAttribute("allSubAdmins");
    User currentUser = (User) request.getAttribute("currentUser");
%>

<h2 style="color: black">Create New Election</h2>

<div id="alert"></div>

<form action="/election/create" method="post" enctype="multipart/form-data">

    <!-- Name -->
    <label for="name">Election Name:</label>
    <input type="text" id="name" name="name" placeholder="Enter Election Name" title="Election Name" required>

    <!-- Election Type -->
    <!-- Dropdown Input -->
    <label for="election_type">Election Type:</label>
    <select id="election_type" name="election_type" title="Select Election Type">
        <option value="drop-down-default" selected style="font-size: 12px">Select an election type</option>
        <option value="Lok Sabha">Lok Sabha Election</option>
        <option value="Rajya Sabha">Rajya Sabha Election</option>
        <option value="Municipal Corporation">Municipal Corporation Election</option>
    </select>

    <!-- Start Date -->
    <label for="start_date">Start Date and Time:</label>
    <input type="datetime-local" id="start_date" name="start_date" title="dd-mm-yyyy hh:mm" required>

    <!-- End Date -->
    <label for="end_date">End Date and Time:</label>
    <input type="datetime-local" id="end_date" name="end_date" title="dd-mm-yyyy hh:mm" required>


    <label for="assign_to">Regional Officer:</label>
    <select id="assign_to" name="assignedTo" title="Select Regional Officer">
        <option value="drop-down-default" selected style="font-size: 12px">Select Regional Officer</option>

        <%
            if (subAdmins.isEmpty()) {
        %>
        <option value="drop-down-default">
            -- No Regional Officers --
        </option>
                <%
                return;
            }
            for (User subAdmin : subAdmins) {
                %>
        <option value="<%= subAdmin.getUserId()%>">
            ID: <%= subAdmin.getUserId()%> &#x2014; <%= subAdmin.getName()%>
        </option>
        <%

            }
        %>

    </select>


    <!-- Created By -->
    <label for="created_by">Created By:</label>
    <input type="text" id="created_by"  placeholder="<%= currentUser.getName()%>" style="cursor: not-allowed;" disabled>
    <input type="hidden" name="created_by" value="<%= currentUser.getUserId()%>" >

    <!-- Submit Button -->
    <div class="button-container">
        <button type="reset" id="resetButton">Reset</button>
        <button type="submit" id="submitButton">Submit</button>
    </div>


</form>


</body>


