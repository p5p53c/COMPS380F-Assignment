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
<c:if test="${param.error == 'role'}">
    <p>Please select role</p>
</c:if>
<h2>Create a User</h2>
<form:form method="POST" enctype="multipart/form-data" modelAttribute="courseUsers">
    <form:label path="username">Username</form:label><br/>
    <form:input type="text" path="username" /><br/><br/>
    <form:label path="password">Password</form:label><br/>
    <form:input type="text" path="password" /><br/><br/>
    <form:label path="fullname">Full Name</form:label><br>
    <form:input type="text" path="fullname" /><br>
    <form:label path="address">Address</form:label><br>
    <form:input path="address" type="text" /><br>
    <form:label path="phone">Phone</form:label><br>
    <form:input type="text" path="phone" /><br><br>
    <form:label path="roles">Roles</form:label><br/>
    <form:checkbox path="roles" value="ROLE_USER" />Student
    <form:checkbox path="roles" value="ROLE_ADMIN" />Lecturer
    <br /><br />
    <input type="submit" value="Add User"/> <input type=button value="Back" onCLick="history.back()">
</form:form>
</body>
</html>
