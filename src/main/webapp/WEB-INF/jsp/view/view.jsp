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
        <br /><br />
        <c:choose>
            <c:when test="${fn:length(course.lecture) == 0}">
                <i>There are no lecture in the system.</i>
            </c:when>
            <c:otherwise>
                <c:forEach items="${course.lecture}" var="lecture" varStatus="status">
                    Lecture ${lecture.lecturenumber}:
                    <a href="<c:url value="/lecture/view/${lecture.id}" />">
                        <c:out value="${lecture.lecturetitle}" /></a>
                    <br /><br />
                </c:forEach>
            </c:otherwise>
        </c:choose>

        <input type=button value="Back" onCLick="javascript:history.go(-1)">
    </body>
</html>