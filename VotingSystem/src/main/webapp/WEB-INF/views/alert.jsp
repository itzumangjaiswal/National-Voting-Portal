<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/globalAlert.css">
</head>

<%
    String tokenExpired = (String) request.getAttribute("tokenExpired");
%>

<script>
    //handle token expiry redirect
    var tokenExpired = "<%= tokenExpired %>";
    // console.log("TokenExpired: " + tokenExpired)
    // console.log("TokenExpired: " + typeof tokenExpired)
    if (tokenExpired === "EXP") {
        // Store a flash message in session storage
        sessionStorage.setItem('tokenExpired', 'Your login token is expired.');
        window.top.location.href = "/"
    }
</script>

<%
    String errorMessage = (String) request.getAttribute("error");
    String successMessage = (String) request.getAttribute("success");
%>

<%
    if (errorMessage != null) {
%>
<script type="module">

    import { showAlert } from '${pageContext.request.contextPath}/js/globalAlert.js';
    showAlert('failed', '<%= errorMessage%>')

</script>

<%
    }

    if (successMessage != null) {
%>
<script type="module">
    // show db alerts
    import { showAlert } from '${pageContext.request.contextPath}/js/globalAlert.js';
    showAlert('success', '<%= successMessage%>')

</script>

<%
    }
%>