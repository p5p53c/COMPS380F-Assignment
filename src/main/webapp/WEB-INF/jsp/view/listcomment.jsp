<%--
  Created by IntelliJ IDEA.
  User: p5p53c
  Date: 8/5/2022
  Time: 13:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Comment</title>
</head>
<body>
<c:choose>
    <c:when test="${fn:length(commentDatabase) == 0}">
        <i class="user">There are no comment in the system.</i>
    </c:when>
    <c:otherwise>
        <h1>
            Comments
        </h1>
        <table>
            <tr>
                <td>Username</td>
                <td>Comment body</td>
            </tr>
            <c:forEach items="${commentDatabase}" var="comment">
                <tr>
                    <td>${comment.username}</td>
                    <td>${comment.commentbody}</td>
                </tr>
            </c:forEach>
        </table>
    </c:otherwise>
</c:choose>
</body>
</html>
