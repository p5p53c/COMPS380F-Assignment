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
            [<a href="<c:url value="/poll/delete/${poll.id}" />">Delete</a>]<br/>
        </security:authorize>
        <form:form method="POST" modelAttribute="voteForm">
            <table>
                <tr>
                    <td><form:label path="voteTarget">Choose one:</form:label></td>
                </tr>
                <tr>
                    <td><form:radiobutton path="voteTarget" value="${poll.pollMC1}" label="${poll.pollMC1}" /></td>
                    <td>${totalVote1}</td>
                </tr>
                <c:if test="${!empty poll.pollMC2}">
                    <tr>
                        <td><form:radiobutton path="voteTarget" value="${poll.pollMC2}" label="${poll.pollMC2}" /></td>
                    <td>${totalVote2}</td>
                    </tr>
                </c:if>
                <c:if test="${!empty poll.pollMC3}">
                    <tr>
                        <td><form:radiobutton path="voteTarget" value="${poll.pollMC3}" label="${poll.pollMC3}" /></td>
                    <td>${totalVote3}</td>
                    </tr>
                </c:if>
                <c:if test="${!empty poll.pollMC4}">
                    <tr>
                        <td><form:radiobutton path="voteTarget" value="${poll.pollMC4}" label="${poll.pollMC4}" /></td>
                    <td>${totalVote4}</td>
                    </tr>
                </c:if>
                <form:hidden path="pollId" value="${poll.id}" />
                <form:hidden path="username" value="${pageContext.request.remoteUser}" />
                <tr>
                    <td><input type="submit" value="Submit"/></td>
                    <td>Total votes: ${totalVotes}</td>
                </tr>
            </table>
        </form:form>
        <br/><a href="<c:url value="/course" />">Return to Course List</a>
    </body>
</html>
