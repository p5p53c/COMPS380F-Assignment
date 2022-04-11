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

<h2>Ticket #${course.id}: <c:out value="${course.courseTitle}" /></h2>
<security:authorize access="hasRole('ADMIN')">
    [<a href="<c:url value="/course/edit/${course.id}" />">Edit</a>]
    [<a href="<c:url value="/course/delete/${course.courseTitle}" />">Delete</a>]
</security:authorize>
<br /><br />
<i>Student Name - <c:out value="${course.courseTitle}" /></i><br /><br />

<a href="<c:url value="/course" />">Return to list tickets</a>
</body>
</html>