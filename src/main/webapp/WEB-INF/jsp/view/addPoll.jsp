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

        <h2>Create a Poll</h2>
        <form:form method="POST" modelAttribute="pollForm">
            <form:label path="question">Question</form:label><br />
            <form:input type="text" path="question" required=""/><br /><br />
            <form:label path="mc1">MC1</form:label><br />
            <form:input type="text" path="mc1" required=""/><br /><br />
            <form:label path="mc2">MC2</form:label><br />
            <form:input type="text" path="mc2" required=""/><br /><br />
            <form:label path="mc3">MC3</form:label><br />
            <form:input type="text" path="mc3" value=""/><br /><br />
            <form:label path="mc4">MC4</form:label><br />
            <form:input type="text" path="mc4" value=""/><br /><br />
            <input type="hidden" name="pollId" value="${param.pollId}" />
            <input type="submit" value="Submit"/>
        </form:form>
    </body>
</html>