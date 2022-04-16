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

        <h2>Poll ${poll.id}: <c:out value="${poll.pollQuestion}" /></h2>
        <security:authorize access="hasRole('ADMIN')">
            [<a href="<c:url value="/poll/delete/${poll.id}" />">Delete</a>]<br />
        </security:authorize>
        <form:form method="POST" modelAttribute="voteForm">
            <label for="mcList">Choose one:</label><br/>
            <input type="radio" name="mcList" id="mc1"  value="${poll.pollMC1}">${poll.pollMC1}<br />
            <c:if test="${!empty poll.pollMC2}">
                <input type="radio" name="mcList" id="mc2"  value="${poll.pollMC2}">${poll.pollMC2}<br />
            </c:if>
            <c:if test="${!empty poll.pollMC3}">
                <input type="radio" name="mcList" id="mc2"  value="${poll.pollMC2}">${poll.pollMC3}<br />
            </c:if>
            <c:if test="${!empty poll.pollMC4}">
                <input type="radio" name="mcList" id="mc2"  value="${poll.pollMC2}">${poll.pollMC4}<br />
            </c:if>
            <br/>
            <input type="hidden" name="pollId" value="${poll.id}" />
            <input type="hidden" name="username" value="${user.username}" />
            <input type="submit" value="Submit"/>
        </form:form>
        <br/><a href="<c:url value="/course" />">Return to Course List</a>
    </body>
</html>
