<!DOCTYPE html>
<html>
<head>
    <title>Online Course Website</title>
</head>
<body>
<c:url var="logoutUrl" value="/cslogout"/>
<form action="${logoutUrl}" method="post">
    <input type="submit" value="Log out" />
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form>

<h2>Material #${material.id}: <c:out value="${material.materialname}" /></h2>
<security:authorize access="hasRole('ADMIN')">
    [<a href="<c:url value="/material/edit/${material.id}" />">Edit</a>]
    [<a href="<c:url value="/material/delete/${material.id}" />">Delete</a>]
</security:authorize>
<br /><br />
<c:out value="${material.materialbody}" /><br /><br />
<c:if test="${fn:length(material.attachments) > 0}">
    Attachments:
    <c:forEach items="${material.attachments}" var="attachment" varStatus="status">
        <c:if test="${!status.first}">, </c:if>
        <a href="<c:url value="/material/${material.id}/attachment/${attachment.name}" />">
            <c:out value="${attachment.name}" /></a>
    </c:forEach><br /><br />
</c:if>
<input type=button value="Back" onCLick="javascript:history.go(-1)">
</body>
</html>