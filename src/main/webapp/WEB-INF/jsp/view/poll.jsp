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
            <form:label path="voteTarget">Choose one:</form:label><br/>
            <form:radiobutton path="voteTarget" value="${poll.pollMC1}" label="${poll.pollMC1}" /><br/>
            <c:if test="${!empty poll.pollMC2}">
                <form:radiobutton path="voteTarget" value="${poll.pollMC2}" label="${poll.pollMC2}" /><br/>
            </c:if>
            <c:if test="${!empty poll.pollMC3}">
                <form:radiobutton path="voteTarget" value="${poll.pollMC3}" label="${poll.pollMC3}" /><br/>
            </c:if>
            <c:if test="${!empty poll.pollMC4}">
                <form:radiobutton path="voteTarget" value="${poll.pollMC4}" label="${poll.pollMC4}" /><br/>
            </c:if>
                <br/>
                <form:hidden path="pollId" value="${poll.id}" /><br/>
                <form:hidden path="username" value="${pageContext.request.remoteUser}" />
                <input type="submit" value="Submit"/>
        </form:form>
        <br/><a href="<c:url value="/course" />">Return to Course List</a>
    </body>
</html>
