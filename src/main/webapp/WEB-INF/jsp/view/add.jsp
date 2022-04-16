<!DOCTYPE html>
<html>
<head>
    <title>Customer Support</title>
</head>
<body>
<c:url var="logoutUrl" value="/cslogout"/>
<form action="${logoutUrl}" method="post">
    <input type="submit" value="Log out" />
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form>

<h2>Create a Material</h2>
    <form:form method="POST" enctype="multipart/form-data"
                             modelAttribute="materialForm">
        <form:label path="materialname">Subject</form:label><br />
        <form:input type="text" path="materialname" /><br /><br />
        <form:label path="materialbody">Body</form:label><br />
        <form:textarea path="materialbody" rows="5" cols="30" /><br /><br />
        <b>Attachments</b><br />
<<<<<<< HEAD
        <input type="file" name="attachments" multiple="multiple" /><br /><br />
        <input type="hidden" name="courseid" value="${param.courseid}" />
        <input type="submit" value="Submit"/>
=======
        <!-- <input type="file" name="attachments" multiple="multiple" /><br /><br /> -->

        <div class="drop-zone">
            <span class="drop-zone__prompt">Drop file here or click to upload</span>
            <input type="file" name="attachments" class="drop-zone__input" multiple="multiple">
        </div>

        <input type="hidden" name="courseid" value="${param.courseid}" />
        <input type="submit" value="Submit" />
        <input type=button value="Back" onCLick="javascript:history.go(-1)">
>>>>>>> 7ddc8f24d1d65bf52f1297d63a3d526df2b58d8d
    </form:form>
</body>
</html>
