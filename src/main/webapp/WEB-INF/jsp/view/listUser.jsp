<!DOCTYPE html>
<html>
    <head><title>Customer Support User Management</title></head>
    <body onload="init()">
        <c:url var="logoutUrl" value="/cslogout"/>
        <form action="${logoutUrl}" method="post">
            <input class="translate" type="submit" value="Log out" />
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            [<a href="#" onclick="trans(this.innerHTML)">English</a>
            | <a href="#" onclick="trans(this.innerHTML)">中文</a>]
        </form>
        <br />
        <h2 class="translate">Users</h2>
        <a class="translate" href="<c:url value="/user/create" />">Create a User</a><br /><br />
        <c:choose>
            <c:when test="${fn:length(courseUsers) == 0}">
                <i class="user">There are no users in the system.</i>
            </c:when>
            <c:otherwise>
                <table>
                    <tr>
                        <th>Username</th><th>Password</th><th>Roles</th><th>Action</th>
                    </tr>
                    <c:forEach items="${courseUsers}" var="user">
                        <tr>
                            <td>${user.username}</td><td>${user.password.split("}")[1]}</td>
                            <td>
                                <c:forEach items="${user.roles}" var="role" varStatus="status">
                                    <c:if test="${!status.first}">, </c:if>
                                    ${role.role}
                                </c:forEach>
                            </td>
                            <td>
                                [<a class="action" href="<c:url value="/user/edit/${user.username}" />">Edit</a>]
                                [<a class="action" href="<c:url value="/user/delete/${user.username}" />">Delete</a>]
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </c:otherwise>
        </c:choose>
        <br/><input class="translate" type=button value="Back" onCLick="javascript:history.go(-1)">
        <script>
            const localStorage = window.localStorage;
            function init() {
                if (localStorage) {
                    trans(localStorage.getItem("language"));
                }
            }
            const trans = (language) => {
                var translate = document.getElementsByClassName("translate");
                var tr = document.getElementsByTagName("th");
                var user = document.getElementsByClassName("user");
                var action = document.getElementsByClassName("action");
                switch (language) {
                    case "English":
                        translate[0].value = "Log out";
                        translate[1].innerHTML = "Users";
                        translate[2].innerHTML = "Create a User";
                        translate[3].value = "Back";
                        if (document.getElementById("t_nosuer"))
                            tr[0].innerHTML = "Username";
                        tr[1].innerHTML = "Password";
                        tr[2].innerHTML = "Roles";
                        tr[3].innerHTML = "Action";
                        if (${fn:length(courseUsers) == 0})
                            user[0].innerHTML = "There are no users in the system.";
                        else
                            for (var i = 0; i < action.length; i += 2) {
                                action[0].innerHTML = "Edit";
                                action[1].innerHTML = "Delete";
                            }
                        localStorage.setItem("language", "English");
                        break;
                    case "中文":
                        translate[0].value = "登出";
                        translate[1].innerHTML = "使用者";
                        translate[2].innerHTML = "建立使用者";
                        translate[3].value = "返回";
                        tr[0].innerHTML = "使用者名稱";
                        tr[1].innerHTML = "密碼";
                        tr[2].innerHTML = "身份";
                        tr[3].innerHTML = "動作";
                        if (${fn:length(courseUsers) == 0})
                            user[0].innerHTML = "系統裡沒有任何使用者";
                        else
                            for (var i = 0; i < action.length; i += 2) {
                                action[i].innerHTML = "編輯";
                                action[i + 1].innerHTML = "刪除";
                            }
                        localStorage.setItem("language", "中文");
                        break;
                }
            }
        </script>
    </body>
</html>