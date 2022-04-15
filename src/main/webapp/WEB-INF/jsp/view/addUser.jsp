<!DOCTYPE html>
<html>
<head>
    <title>Customer Support</title>
</head>
<body>
<security:authorize access="hasAnyRole('USER', 'ADMIN')">
    <c:url var="logoutUrl" value="/cslogout"/>
    <form action="${logoutUrl}" method="post">
        <input type="submit" value="Log out" />
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    </form>
</security:authorize>

<security:authorize access="isAnonymous()">
    <c:url var="loginUrl" value="/cslogin"/>
    <form action="${loginUrl}" method="get">
        <input type="submit" value="Log in" />
    </form>
</security:authorize>
<h2>Create a User</h2>
<form:form method="POST" enctype="multipart/form-data" modelAttribute="courseUsers">
    <form:label path="username">Username</form:label><br/>
    <form:input type="text" path="username"/><br/><br/>
    <form:label path="password">Password</form:label><br/>
    <form:input type="text" path="password"/><br/><br/>
    <form:label path="fullname">Full Name</form:label><br>
    <form:input type="text" path="fullname"/><br>
    <form:label path="address">Address</form:label><br>
    <form:input path="address" type="text"/><br>
    <form:label path="phone">Phone</form:label><br>
    <form:input type="text" path="phone"/><br><br>
    <form:label path="roles">Roles (Don't choose any role default will be Student)</form:label><br/>
    <form:checkbox path="roles" value="ROLE_USER"/>Student
    <security:authorize access="hasRole('ADMIN')">
        <form:checkbox path="roles" value="ROLE_ADMIN"/>Lecturer
    </security:authorize>
    <br/><br/>
    <input type="submit" value="Add User"/> <input type=button value="Back" onCLick="history.back()">
</form:form>
</body>
</html>
