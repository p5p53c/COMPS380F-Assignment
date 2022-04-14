<!DOCTYPE html>

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
        [<a href="<c:url value="/poll/delete/${poll.id}" />">Delete</a>]
    </security:authorize>
    <br /><br />
    <form action="/${poll.id}" method="POST">
        <label for="mcList">Choose one:</label><br/>
        <input type="radio" name="mcList" id="mc1"  value="mc1">${poll.pollMC1}<br />
        <input type="radio" name="mcList" id="mc2"  value="mc2">${poll.pollMC2}<br />
        <c:if test="${!empty poll.pollMC3}">
        <input type="radio" name="mcList" id="mc2"  value="mc3">${poll.pollMC3}<br />
        </c:if>
        <c:if test="${!empty poll.pollMC4}">
        <input type="radio" name="mcList" id="mc2"  value="mc4">${poll.pollMC4}<br />
        </c:if>

        <input type="submit" value="Submit"/>
    </form>
    <a href="<c:url value="/course" />">Return to Course List</a>
</body>
</html>
