<%@ page import="com.votingSystem.entity.User" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<jsp:include page="../alert.jsp"/>

<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/globalAlert.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/forms.css">

</head>
<body>

<h2 style="color: black">Candidate Registration </h2>


<%
    User currentUser = (User) request.getAttribute("currentUser");

%>

<div id="alert"></div>


<form action="/candidate/register" method="post" enctype="multipart/form-data" onsubmit="return validateFormBeforeSubmit()">

    <!-- Name -->
    <label for="name">Full Name:</label>
    <input type="text" id="name" name="name" placeholder="Enter Candidate Full Name" maxlength="30">


    <!-- Candidate Description -->
    <label for="description">Candidate Description:</label>
    <input type="text" id="description" name="description" placeholder="Will be shown to Voters" maxlength="60">


    <!-- 12-Digit Aadhaar Number (Separated by Dashes) -->
    <label for="aadharNumber">Aadhar Number:</label>
    <input type="text" id="aadharNumber" name="aadharNumber" placeholder="e.g. 1234-5678-9012" maxlength="14" onkeydown="addSpaces('aadharNumber')">


    <!-- Profile Picture -->
    <label for="profilePic">Profile Picture:</label>
    <input type="file" id="profilePic" name="profilePic" accept="image/*" >

    <!-- Party Name -->
    <label for="partyName">Party Name:</label>
    <input type="text" id="partyName" name="partyName" placeholder="Enter Candidate Party Name" maxlength="45">

    <!-- Party Logo -->
    <label for="partyLogo">Party Logo:</label>
    <input type="file" id="partyLogo" name="partyLogo" accept="image/*" >


    <!-- Created By -->
    <label for="createdBy">Created By:</label>
    <input type="text"  placeholder="<%= currentUser.getName()%>" disabled style="cursor: not-allowed">
    <input type="hidden" id="createdBy" value="<%=currentUser.getUserId()%>" name="createdBy">



    <!-- Submit Button -->
    <div class="button-container">
        <button type="reset" id="resetButton">Reset</button>
        <button id="submitButton">Submit</button>
    </div>


</form>

<h2 style="color: black">Update Candidate Party </h2>


<form action="/candidate/update" method="post" enctype="multipart/form-data"  >

    

    

   <!-- 12-Digit Aadhaar Number (Separated by Dashes) -->
    <label for="aadharNumber">Aadhar Number:</label>
    <input type="text" id="aadharNumber" name="aadharNumber" placeholder="e.g. 1234-5678-9012" maxlength="14" onkeydown="addSpaces('aadharNumber')">

    
    <label for="partyName">Party Name:</label>
    <input type="text" id="_partyName" name="partyName" placeholder="Enter Candidate Party Name" maxlength="45">

    <!-- Party Logo -->
    <label for="partyLogo">Party Logo:</label>
    <input type="file" id="_partyLogo" name="partyLogo" accept="image/*" >


    <!-- Created By -->
    <label for="createdBy">Updated By:</label>
    <input type="text"  placeholder="<%= currentUser.getName()%>" disabled style="cursor: not-allowed">
    <input type="hidden" id="createdBy" value="<%=currentUser.getUserId()%>" name="createdBy">



    <!-- Submit Button -->
    <div class="button-container">
        <button type="reset" id="resetButton">Reset</button>
        <button id="submitButton">Submit</button>
    </div>


</form>

<!-- Alert Messages -->
<div class="alert-position">
    <div class="alert-box failed" id="failedAlert" style="display:none;">
        <button class="close-btn" onclick="closeAlert('failedAlert')">&times;</button>
        <p id="errorMessage" style="font-weight: bold"></p>
    </div>
    <div class="alert-box success" id="successAlert" style="display:none;">
        <button class="close-btn" onclick="closeAlert('successAlert')">&times;</button>
        <p><strong>Success!</strong> Your form has been submitted successfully.</p>
    </div>
</div>

<script>

    function validateFormBeforeSubmit(){
        const name = document.getElementById('name').value
        const description = document.getElementById('description').value
        const aadharNumber = document.getElementById('aadharNumber').value
     //   const _aadharNumber = document.getElementById('_aadharNumber').value
        const profilePic = document.getElementById('profilePic')
        const partyName = document.getElementById('partyName').value
        const partyLogo = document.getElementById('partyLogo')

        let errorMessage = ''

        // check name
        if(!name){
            errorMessage += '<br>Full Name is required.'
        }else if(name.length < 3) {
            errorMessage += '<br>Full Name should have minimum 3 letters.'
        }

        // check description
        if(!description){
            errorMessage += '<br>Candidate Description is required.'
        }else if(description.length < 6) {
            errorMessage += '<br>Candidate Description should have minimum 6 letters.'
        }

        // check aadharNumber
        if(!aadharNumber){
            errorMessage += '<br>Aadhar Number is required.'
        }else if(aadharNumber.length != 14) {
            errorMessage += '<br>Aadhaar Number must be of 12 digits.'
        }
        if(!_aadharNumber){
            errorMessage += '<br>Aadhar Number is required.'
        }else if(_aadharNumber.length != 14) {
            errorMessage += '<br>Aadhaar Number must be of 12 digits.'
        }

        // check profilePic
        if(!profilePic.files || profilePic.files.length === 0){
            errorMessage += '<br>Profile Picture is required.'
        }

        // check partyName
        if(!partyName){
            errorMessage += '<br>Party Name is required.'
        }else if(partyName.length < 3) {
            errorMessage += '<br>Party Name should have minimum 3 letters.'
        }

        // check partyLogo
        if(!partyLogo.files || partyLogo.files.length === 0){
            errorMessage += '<br>Party Logo is required.'
        }


        if(errorMessage){
            console.log('err:' + errorMessage)
            document.getElementById('errorMessage').innerHTML = errorMessage;
            document.getElementById('failedAlert').style.display = 'flex';
            return false
        }

        // showAlert('success','check')

        console.log('done')
        // Proceed with form submission
        submitButton.innerHTML = 'Submitting... <div class="spinner"></div>';
        submitButton.disabled = true;
        document.getElementById('failedAlert').style.display = 'none';  // Hide error alert if no error
        return true;




    }



    function addSpaces(elementId){

        let element = document.getElementById(elementId)

        if(element.value.length === 4 || element.value.length === 9){
            element.value = element.value + '-'
        }

    }

</script>

</body>


