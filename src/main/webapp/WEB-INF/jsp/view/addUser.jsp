<!DOCTYPE html>
<html>
    <head>
        <title>Customer Support</title>
    </head>
    <body onLoad="init()">
        <security:authorize access="hasAnyRole('USER', 'ADMIN')">
            <c:url var="logoutUrl" value="/cslogout"/>
            <form action="${logoutUrl}" method="post">
                <input id="t_logout" type="submit" value="Log out" />
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            </form>
        </security:authorize>
        [<a href="#" onclick="trans(this.innerHTML)">English</a>
        |<a href="#" onclick="trans(this.innerHTML)">中文</a>]
        <security:authorize access="isAnonymous()">
            <c:url var="loginUrl" value="/cslogin"/>
            <form id="t_login" action="${loginUrl}" method="get">
                <input type="submit" value="Log in" />
            </form>
        </security:authorize>
        <h2>Create a User</h2>
        <form:form method="POST" enctype="multipart/form-data" modelAttribute="courseUsers">
            <form:label class="t_form" path="username">Username</form:label><br/>
            <form:input type="text" path="username"/><br/><br/>
            <form:label class="t_form"  path="password">Password</form:label><br/>
            <form:input type="text" path="password"/><br/><br/>
            <form:label class="t_form"  path="fullname">Full Name</form:label><br>
            <form:input type="text" path="fullname"/><br>
            <form:label class="t_form" path="address">Address</form:label><br>
            <form:input path="address" type="text"/><br>
            <form:label class="t_form" path="phone">Phone</form:label><br>
            <form:input type="text" path="phone"/><br><br>
            <form:label class="t_form" path="roles">Roles (Don't choose any role default will be Student)</form:label><br/>
            <form:checkbox class="t_form" path="roles" value="ROLE_USER"/><span class="t_role">Student</span>
            <security:authorize access="hasRole('ADMIN')">
                <form:checkbox class="t_form" path="roles" value="ROLE_ADMIN"/><span class="t_role">Lecturer</span>
            </security:authorize>
            <br/><br/>
            <input id="t_submit" type="submit" value="Add User"/> <input id="t_back" type=button value="Back" onCLick="javascript:history.go(-1)">
        </form:form>
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
                        if (document.getElementById("t_login"))
                            document.getElementById("t_login").value = "Log in";
                        document.getElementsByTagName("H2")[0].innerHTML = "Create a User";
                        var form = document.getElementsByClassName("t_form");
                        form[0].innerHTML = "Username";
                        form[1].innerHTML = "Password";
                        form[2].innerHTML = "Full Name";
                        form[3].innerHTML = "Address";
                        form[4].innerHTML = "Phone";
                        form[5].innerHTML = "Roles (Don't choose any role default will be Student)";
                        var role = document.getElementsByClassName("t_role");
                        role[0].innerHTML = "Student";
                        role[1].innerHTML = "Lecturer";
                        document.getElementById("t_submit").value = "Add User";
                        document.getElementById("t_back").value = "Back";
                        localStorage.setItem("language", "English");
                        break;
                    case "中文":
                        document.getElementById("t_logout").value = "登出";
                        if (document.getElementById("t_login"))
                            document.getElementById("t_login").value = "登入";
                        document.getElementsByTagName("H2")[0].innerHTML = "建立使用者";
                        var form = document.getElementsByClassName("t_form");
                        form[0].innerHTML = "使用者名稱";
                        form[1].innerHTML = "密碼";
                        form[2].innerHTML = "全名";
                        form[3].innerHTML = "地址";
                        form[4].innerHTML = "電話號碼";
                        form[5].innerHTML = "身份（不選擇任何身份則預設爲學生）";
                        var role = document.getElementsByClassName("t_role");
                        role[0].innerHTML = "學生";
                        role[1].innerHTML = "講師";
                        document.getElementById("t_submit").value = "加入使用者";
                        document.getElementById("t_back").value = "返回";
                        localStorage.setItem("language", "中文");
                        break;
                }
            }
        </script>
    </body>
</html>
