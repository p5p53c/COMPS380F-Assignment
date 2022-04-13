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

<h2>Lecture ${lecture.id}: <c:out value="${lecture.lecturetitle}" /></h2>
<security:authorize access="hasRole('ADMIN')">
    <a href="<c:url value="/material/${lecture.id}/create" />">Create a Material</a><br /><br />
</security:authorize>
<br /><br />
<c:choose>
    <c:when test="${fn:length(lecture.materials) == 0}">
        <i>There are no lecture in the system.</i>
    </c:when>
    <c:otherwise>
        <c:forEach items="${lecture.materials}" var="material" varStatus="status">
            Material ${material.id}:
            <a href="<c:url value="/material/view/${material.id}" />">
                <c:out value="${material.materialname}" /></a>
            <security:authorize access="hasRole('ADMIN')">
                [<a href="<c:url value="/material/edit/${material.id}" />">Edit</a>]
                [<a href="<c:url value="/material/delete/${material.id}" />">Delete</a>]
            </security:authorize>
            <br /><br />
        </c:forEach>
    </c:otherwise>
</c:choose>

<input type=button value="Back" onCLick="history.back()">
</body>
</html>