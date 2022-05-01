<!DOCTYPE html>
<html>
    <head>
        <title>Customer Support</title>
    </head>
    <body onLoad="init()">
        <c:url var="logoutUrl" value="/cslogout"/>
        <form action="${logoutUrl}" method="post">
            <input type="submit" value="Log out" />
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>

        <h2>Create a Poll</h2>
        <form:form method="POST" modelAttribute="pollForm">
            <form:label path="question">Question:</form:label><br />
            <form:input type="text" path="question" /><br /><br />
            <form:label path="mc1">Choice 1:</form:label><br />
            <form:input type="text" path="mc1" /><br /><br />
            <form:label path="mc2">Choice 2:</form:label><br />
            <form:input type="text" path="mc2" /><br /><br />
            <form:label path="mc3">Choice 3:</form:label><br />
            <form:input type="text" path="mc3" /><br /><br />
            <form:label path="mc4">Choice 4:</form:label><br />
            <form:input type="text" path="mc4" /><br /><br />
            <input type="submit" value="Submit"/>
        </form:form>
    </body>
</html>