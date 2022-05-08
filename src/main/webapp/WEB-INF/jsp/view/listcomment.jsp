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
        <h2 class="listComment">
            Comments
        </h2>
        <c:choose>
            <c:when test="${fn:length(commentDatabase) == 0}">
                <i class="user">There are no comment in the system.</i>
                <security:authorize access="hasAnyRole('USER','ADMIN')" var="hasRole"/>
            </c:when>
            <c:otherwise>
                <table>
                    <tr>
                        <td class="listComment">Username</td>
                        <td class="listComment">Comment body</td>
                        <security:authorize access="hasRole('ADMIN')" var="hasRole">
                            <td class="action">Action</td>
                        </security:authorize>
                    </tr>
                    <c:forEach items="${commentDatabase}" var="comment">
                        <tr>
                            <td>${comment.username}</td>
                            <td>${comment.commentbody}</td>
                            <security:authorize access="hasRole('ADMIN')" var="hasRole">
                                <td>[<a class="hasRole action" href="<c:url value="/comment/delete/${comment.id}" />">Delete</a>]</td>
                            </security:authorize>
                        </tr>
                    </c:forEach>
                </table>
            </c:otherwise>
        </c:choose>
        <script>
            const transComment = (language) => {
                var listComment = document.getElementsByClassName("listComment");
                var action = document.getElementsByClassName("action");
                switch (language) {
                    case "English":
                        console.log("comment: language: " + localStorage.getItem("language"));
                            listComment[0].innerHTML = "Comments";
                        if (${fn:length(commentDatabase) == 0})
                            document.getElementsByClassName("user")[0].innerHTML = "There are no comment in the system.";
                        else {
                            listComment[1].innerHTML = "Username";
                            listComment[2].innerHTML = "Comment body";
                            if (${hasRole}) {
                                action[0].innerHTML = "Action";
                                for (let i = 1; i < action.length; i++)
                                    action[i].innerHTML = "Delete";
                            }
                        }
                        localStorage.setItem("language", "English");
                        break;
                    case "中文":
                        console.log("comment: language: " + localStorage.getItem("language"));
                            listComment[0].innerHTML = "留言";
                        if (${fn:length(commentDatabase) == 0})
                            document.getElementsByClassName("user")[0].innerHTML = "系統裡沒有任何留言";
                        else {
                            listComment[1].innerHTML = "使用者名稱";
                            listComment[2].innerHTML = "留言內容";
                            if (${hasRole}) {
                                action[0].innerHTML = "動作";
                                for (let i = 1; i < action.length; i++)
                                    action[i].innerHTML = "刪除";
                            }
                        }
                        localStorage.setItem("language", "中文");
                        break;
                }
            }
        </script>
    </body>
</html>
