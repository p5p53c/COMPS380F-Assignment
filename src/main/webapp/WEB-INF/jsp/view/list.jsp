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
    <a href="<c:url value="/course/create" />">Create a Ticket</a><br /><br />
</security:authorize>
<c:choose>
    <c:when test="${fn:length(courseDatabase) == 0}">
        <i>There are no tickets in the system.</i>
    </c:when>
    <c:otherwise>
        <c:forEach items="${courseDatabase}" var="course">
            Ticket ${course.id}:
            <a href="<c:url value="/course/view/${course.id}" />">
                <c:out value="${course.courseTitle}" /></a>
            <security:authorize access="hasRole('ADMIN')">
                [<a href="<c:url value="/course/edit/${course.id}" />">Edit</a>]
                [<a href="<c:url value="/course/delete/${course.id}" />">Delete</a>]
            </security:authorize>
            <br /><br />
        </c:forEach>
    </c:otherwise>
</c:choose>
</body>
