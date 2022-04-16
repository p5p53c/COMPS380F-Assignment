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
            <c:url var="registerUrl" value="/user/create" />
            <form action="${loginUrl}" method="get">
                <input type="submit" value="Log in" />
            </form>
            <form action="${registerUrl}" method="get">
                <input type="submit" value="Sign up" />
            </form>
        </security:authorize>

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
            <a href="<c:url value="/poll/create" />">Create a Poll</a><br/><br/>
        </security:authorize>
        <c:choose>
            <c:when test="${fn:length(pollDatabase) == 0}">
                <i>There are no poll in the system.</i>
            </c:when>
            <c:otherwise>
                <c:forEach items="${pollDatabase}" var="poll">
                    Poll ${poll.id}:
                    <a href="<c:url value="/poll/${poll.id}" />">
                        <c:out value="${poll.pollQuestion}" /></a>
                    <br /><br />
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </body>
</html>