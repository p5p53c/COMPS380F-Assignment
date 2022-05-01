<!DOCTYPE html>
<html>
    <head><title>Customer Support User Management</title></head>
    <body onload="init()">
        <c:url var="logoutUrl" value="/cslogout"/>
        <form action="${logoutUrl}" method="post">
            <input class="t_button" type="submit" value="Log out" />
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            [<a href="#" onclick="trans(this.innerHTML)">English</a>
            |<a href="#" onclick="trans(this.innerHTML)">中文</a>]
        </form>
        <br />
        <h2 id="t_users">Users</h2>
        <a id="t_cuser" href="<c:url value="/user/create" />">Create a User</a><br /><br />
        <c:choose>
            <c:when test="${fn:length(courseUsers) == 0}">
                <i id="t_nouser">There are no users in the system.</i>
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
                                [<a class="t_action" href="<c:url value="/user/edit/${user.username}" />">Edit</a>]
                                [<a class="t_action" href="<c:url value="/user/delete/${user.username}" />">Delete</a>]
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </c:otherwise>
        </c:choose>
        <br/><input class="t_button" type=button value="Back" onCLick="javascript:history.go(-1)">
        <script>
            const localStorage = window.localStorage;
            function init() {
                if (localStorage) {
                    trans(localStorage.getItem("language"));
                }
            }
            const trans = (language) => {
                switch (language) {
                    case "English":
                        var button = document.getElementsByClassName("t_button");
                        button[0].value = "Log out";
                        button[1].value = "Back";
                        document.getElementById("t_users").innerHTML = "Users";
                        document.getElementById("t_cuser").innerHTML = "Create a User";
                        if (document.getElementById("t_nosuer"))
                            document.getElementById("t_nosuer").innerHTML = "There are no users in the system.";
                        var tr = document.getElementsByTagName("th");
                        tr[0].innerHTML = "Username";
                        tr[1].innerHTML = "Password";
                        tr[2].innerHTML = "Roles";
                        tr[3].innerHTML = "Action";
                        var action = document.getElementsByClassName("t_action");
                        if (action) {
                            action[0].innerHTML = "Edit";
                            action[1].innerHTML = "Delete";
                        }
                        localStorage.setItem("language", "English");
                        break;
                    case "中文":
                        var button = document.getElementsByClassName("t_button");
                        button[0].value = "登出";
                        button[1].value = "返回";
                        document.getElementById("t_users").innerHTML = "使用者";
                        document.getElementById("t_cuser").innerHTML = "建立使用者";
                        if (document.getElementById("t_nosuer"))
                            document.getElementById("t_nosuer").innerHTML = "系統裡沒有任何使用者";
                        var tr = document.getElementsByTagName("th");
                        tr[0].innerHTML = "使用者名稱";
                        tr[1].innerHTML = "密碼";
                        tr[2].innerHTML = "身份";
                        tr[3].innerHTML = "動作";
                        var action = document.getElementsByClassName("t_action");
                        if (action) {
                            action[0].innerHTML = "編輯";
                            action[1].innerHTML = "刪除";
                        }
                        localStorage.setItem("language", "中文");
                        break;
                }
            }
        </script>
    </body>
</html>