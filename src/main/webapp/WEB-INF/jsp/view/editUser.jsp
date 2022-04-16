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

        <h2>Edit User ${user.username}</h2>
        <form:form method="POST" enctype="multipart/form-data" modelAttribute="userForm">
            <form:label path="password">Password</form:label><br/>
            <form:input type="text" path="password" /><br/>
            <form:label path="fullname">Full Name</form:label><br>
            <form:input type="text" path="fullname" /><br>
            <form:label path="address">Address</form:label><br>
            <form:input path="address" type="text" /><br>
            <form:label path="phone">Phone</form:label><br>
            <form:input type="text" path="phone" /><br><br>
            <input type="submit" value="Edit User"/> <input type=button value="Back" onCLick="javascript:history.go(-1)">
        </form:form>
    </body>
</html>

