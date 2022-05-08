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
        <form:form method="POST" modelAttribute="comments" action="/OnlineCourseWebsite_war/comment/create">
            <form:label class="addComment" path="commentbody">Your comment: </form:label>
            <form:input path="commentbody" type="textarea"/>
            <input class="addComment" type="submit" value="Add Comment"/>
        </form:form>
        <script>
            const transAdd = (language) => {
                var addComment = document.getElementsByClassName("addComment");
                switch (language) {
                    case "English":
                        addComment[0].innerHTML = "Your comment: ";
                        addComment[1].value = "Add Comment";
                        localStorage.setItem("language", "English");
                        break;
                    case "中文":
                        addComment[0].innerHTML = "你的留言：";
                        addComment[1].value = "加入留言";
                        localStorage.setItem("language", "中文");
                        break;
                }
            }
        </script>
    </body>
</html>
