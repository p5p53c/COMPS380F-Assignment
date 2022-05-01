<!DOCTYPE html>
<html>
    <head><title>Customer Support User Management</title></head>
    <body onload="init()">
        <c:url var="logoutUrl" value="/cslogout"/>
        <form action="${logoutUrl}" method="post">
            <input id="t_logout" type="submit" value="Log out" />
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
                                [<a id="t_edit" href="<c:url value="/user/edit/${user.username}" />">Edit</a>]
                                [<a id="t_delete" href="<c:url value="/user/delete/${user.username}" />">Delete</a>]
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </c:otherwise>
        </c:choose>
        <br/><input id="t_back" type=button value="Back" onCLick="javascript:history.go(-1)">
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
                        document.getElementById("t_logout").value = "Log out";
                        document.getElementById("t_users").innerHTML = "Users";
                        document.getElementById("t_cuser").innerHTML = "Create a User";
                        if (document.getElementById("t_nosuer"))
                            document.getElementById("t_nosuer").innerHTML = "There are no users in the system.";
                        var tr = document.getElementsByTagName("th");
                        tr[0].innerHTML = "Username";
                        tr[1].innerHTML = "Password";
                        tr[2].innerHTML = "Roles";
                        tr[3].innerHTML = "Action";
                        if (document.getElementById("t_edit"))
                            document.getElementById("t_edit").innerHTML = "Edit";
                        if (document.getElementById("t_delete"))
                            document.getElementById("t_delete").innerHTML = "Delete";
                        /*if (document.getElementById("t_edit"))
                         document.getElementById("t_edit").innerHTML = "Edit";
                         if (document.getElementById("t_delete"))
                         document.getElementById("t_delete").innerHTML = "Delete";*/
                        document.getElementById("t_back").value = "Back";
                        localStorage.setItem("language", "English");
                        console.log("localStorage: " + localStorage.getItem("language"));
                        break;
                    case "中文":
                        document.getElementById("t_logout").value = "登出";
                        document.getElementById("t_users").innerHTML = "使用者";
                        document.getElementById("t_cuser").innerHTML = "建立使用者";
                        if (document.getElementById("t_nosuer"))
                            document.getElementById("t_nosuer").innerHTML = "系統裡沒有任何使用者";
                        var tr = document.getElementsByTagName("th");
                        tr[0].innerHTML = "使用者名稱";
                        tr[1].innerHTML = "密碼";
                        tr[2].innerHTML = "身份";
                        tr[3].innerHTML = "動作";
                        if (document.getElementById("t_edit"))
                            document.getElementById("t_edit").innerHTML = "編輯";
                        if (document.getElementById("t_delete"))
                            document.getElementById("t_delete").innerHTML = "刪除";
                        /*if (document.getElementById("t_edit"))
                         document.getElementById("t_edit").innerHTML = "Edit";
                         if (document.getElementById("t_delete"))
                         document.getElementById("t_delete").innerHTML = "Delete";*/
                        document.getElementById("t_back").value = "返回";
                        localStorage.setItem("language", "中文");
                        console.log("localStorage: " + localStorage.getItem("language"));
                        break;
                }
            }
        </script>
    </body>
</html>