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

<h2>Material #${material.id}</h2>
<form:form method="POST" enctype="multipart/form-data" modelAttribute="materialForm">
    <form:label path="materialname">Material Name</form:label><br/>
    <form:input type="text" path="materialname" /><br/><br/>
    <form:label path="materialbody">Body</form:label><br/>
    <form:textarea path="materialbody" rows="5" cols="30" /><br/><br/>
    <c:if test="${fn:length(material.attachments) > 0}">
        <b>Attachments:</b><br/>
        <ul>
            <c:forEach items="${material.attachments}" var="attachment">
                <li>
                    <c:out value="${attachment.name}" />
                    [<a href="<c:url
                            value="/material/${material.id}/delete/${attachment.name}"
                            />">Delete</a>]
                </li>
            </c:forEach>
        </ul>
    </c:if>
    <b>Add attachments</b><br />
    <input type="file" name="attachments" multiple="multiple"/><br/><br/>
    <input type="submit" value="Save"/> <input type=button value="Back" onCLick="history.back()">
</form:form>

</body>
</html> 