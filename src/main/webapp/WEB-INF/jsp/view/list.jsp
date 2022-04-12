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

<h2>Course</h2>
<security:authorize access="hasRole('ADMIN')">    
    <a href="<c:url value="/user" />">Manage User Accounts</a><br /><br />
</security:authorize>
<c:choose>
    <c:when test="${fn:length(courseDatabase) == 0}">
        <i>There are no course in the system.</i>
    </c:when>
    <c:otherwise>
        <c:forEach items="${courseDatabase}" var="course">
            Course ${course.id}:
            <a href="<c:url value="/course/view/${course.id}" />">
                <c:out value="${course.courseTitle}" /></a>
            <br /><br />
        </c:forEach>
    </c:otherwise>
</c:choose>

<h2>Poll</h2>
<security:authorize access="hasRole('ADMIN')">
    <a href="<c:url value="/poll/create" />">Create a Poll</a>
</security:authorize>
</body>
