<%--
  Created by IntelliJ IDEA.
  User: p5p53c
  Date: 8/5/2022
  Time: 13:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <form:form method="POST" modelAttribute="comments" action="/OnlineCourseWebsite/comment/create">
<%--    <form:form method="POST" modelAttribute="comments" action="/OnlineCourseWebsite_war/comment/create">--%>
        <form:label path="commentbody">Your comment: </form:label>
        <form:input path="commentbody" type="textarea"/>
        <input type="submit" value="Add Comment"/>
    </form:form>
</body>
</html>
