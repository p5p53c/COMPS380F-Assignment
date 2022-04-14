<!DOCTYPE html>
<html>
<head><title>Customer Support User Management</title></head>
<body>
<c:url var="logoutUrl" value="/cslogout"/>
<form action="${logoutUrl}" method="post">
    <input type="submit" value="Log out" />
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form>
<br /><br />
<h2>Users</h2>
<a href="<c:url value="/user/create" />">Create a User</a><br /><br />
<c:choose>
    <c:when test="${fn:length(courseUsers) == 0}">
        <i>There are no users in the system.</i>
    </c:when>
    <c:otherwise>
    <table>
        <tr>
            <th>Username</th><th>Password</th><th>Roles</th><th>Action</th>
        </tr>
        <c:forEach items="${courseUsers}" var="user">
        <tr>
            <td>${user.username}</td><td>${user.password.split("}")[1]}</td>
            <td>
                <c:forEach items="${user.roles}" var="role" varStatus="status">
                    <c:if test="${!status.first}">, </c:if>
                    ${role.role}
                </c:forEach>
            </td>
            <td>
            [<a href="<c:url value="/user/edit/${user.username}" />">Edit</a>]
            [<a href="<c:url value="/user/delete/${user.username}" />">Delete</a>]
            </td>
        </tr>
        </c:forEach>
    </table>
    </c:otherwise>
</c:choose>
<input type=button value="Back" onCLick="history.back()">
</body>
