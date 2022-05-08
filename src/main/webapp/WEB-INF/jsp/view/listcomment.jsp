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
                <security:authorize access="hasRole('ADMIN')" var="hasRole">
                    <td>Action</td>
                </security:authorize>
            </tr>
            <c:forEach items="${commentDatabase}" var="comment">
                <tr>
                    <td>${comment.username}</td>
                    <td>${comment.commentbody}</td>
                    <security:authorize access="hasRole('ADMIN')" var="hasRole">
                        <td>[<a class="hasRole" href="<c:url value="/comment/delete/${comment.id}" />">Delete</a>]</td>
                    </security:authorize>
                </tr>
            </c:forEach>
        </table>
    </c:otherwise>
</c:choose>
<input class="translate" type=button value="Back" onCLick="javascript:history.go(-1);Location.reload();">
</body>
</html>
