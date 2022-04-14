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

<h2>Course ${course.id}: <c:out value="${course.courseTitle}" /></h2>
<security:authorize access="hasRole('ADMIN')">
    <a href="<c:url value="/course/create?courseid=${course.id}" />">Create a Material</a><br /><br />
</security:authorize>
<br /><br />
<c:choose>
    <c:when test="${fn:length(course.materials) == 0}">
        <i>There are no material in the system.</i>
    </c:when>
    <c:otherwise>
        <c:forEach items="${course.materials}" var="material" varStatus="status">
            Material ${material.id}:
            <a href="<c:url value="/material/view/${material.id}" />">
                <c:out value="${material.materialname}" /></a>
            <br /><br />
        </c:forEach>
    </c:otherwise>
</c:choose>

<a href="<c:url value="/course" />">Return to list tickets</a>
</body>
</html>