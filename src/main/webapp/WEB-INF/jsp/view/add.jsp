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
        <input type="file" name="attachments" multiple="multiple" /><br /><br />
        <input type="hidden" name="courseid" value="${param.courseid}" />
        <input type="submit" value="Submit"/>
        <input type=button value="Back" onCLick="history.back()">
    </form:form>
</body>
</html>
