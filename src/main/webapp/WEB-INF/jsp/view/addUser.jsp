<!DOCTYPE html>
<html>
    <head>
        <title>Customer Support</title>
    </head>
    <body onLoad="init()">
        <security:authorize access="hasAnyRole('USER', 'ADMIN')" var="hasAnyRole">
            <c:url var="logoutUrl" value="/cslogout"/>
            <form action="${logoutUrl}" method="post">
                <input class="translate" type="submit" value="Log out" />
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            </form>
        </security:authorize>

        <security:authorize access="isAnonymous()">
            <c:url var="loginUrl" value="/cslogin"/>
            <form id="t_login" action="${loginUrl}" method="get">
                <input class="translate" type="submit" value="Log in" />
            </form>
        </security:authorize>
        [<a href="#" onclick="trans(this.innerHTML)">English</a>
        | <a href="#" onclick="trans(this.innerHTML)">中文</a>]

        <h2>Create a User</h2>
        <form:form method="POST" enctype="multipart/form-data" modelAttribute="courseUsers">
            <form:label class="translate" path="username">Username</form:label><br/>
            <form:input type="text" path="username"/><br/><br/>
            <form:label class="translate"  path="password">Password</form:label><br/>
            <form:input type="text" path="password"/><br/><br/>
            <form:label class="translate"  path="fullname">Full Name</form:label><br/>
            <form:input type="text" path="fullname"/><br/><br/>
            <form:label class="translate" path="address">Address</form:label><br/>
            <form:input path="address" type="text"/><br/><br/>
            <form:label class="translate" path="phone">Phone</form:label><br/>
            <form:input type="text" path="phone"/><br><br>
            <form:label class="translate" path="roles">Roles (Don't choose any role default will be Student)</form:label><br/>
            <form:checkbox path="roles" value="ROLE_USER"/><span class="translate">Student</span>
            <security:authorize access="hasRole('ADMIN')" var="hasRole">
                <form:checkbox path="roles" value="ROLE_ADMIN"/><span id="lecturer">Lecturer</span>
            </security:authorize>
            <br/><br/>
            <input class="translate" type="submit" value="Add User"/>
            <input class="translate" type="button" value="Back" onCLick="javascript:history.go(-1)">
        </form:form>
        <script>
            const localStorage = window.localStorage;
            function init() {
                if (localStorage) {
                    trans(localStorage.getItem("language"));
                }
            }
            const trans = (language) => {
                var translate = document.getElementsByClassName("translate");
                switch (language) {
                    case "English":
                        translate[0].value = (${hasAnyRole}) ? "Log out" : "Log in";
                        translate[1].innerHTML = "Username";
                        translate[2].innerHTML = "Password";
                        translate[3].innerHTML = "Full Name";
                        translate[4].innerHTML = "Address";
                        translate[5].innerHTML = "Phone";
                        translate[6].innerHTML = "Roles (Don't choose any role default will be Student)";
                        translate[7].innerHTML = "Student";
                        translate[8].value = "Add User";
                        translate[9].value = "Back";
                        if (${hasRole})
                            document.getElementById("lecturer").innerHTML = "Lecturer";
                        document.getElementsByTagName("h2")[0].innerHTML = "Create a User";
                        localStorage.setItem("language", "English");
                        break;
                    case "中文":
                        translate[0].value = (${hasAnyRole}) ? "登出" : "登入";
                        translate[1].innerHTML = "使用者名稱";
                        translate[2].innerHTML = "密碼";
                        translate[3].innerHTML = "全名";
                        translate[4].innerHTML = "地址";
                        translate[5].innerHTML = "電話號碼";
                        translate[6].innerHTML = "身份（不選擇任何身份則預設爲學生）";
                        translate[7].innerHTML = "學生";
                        translate[8].value = "加入使用者";
                        translate[9].value = "返回";
                        if (${hasRole})
                            document.getElementById("lecturer").innerHTML = "講師";
                        document.getElementsByTagName("h2")[0].innerHTML = "建立使用者";
                        localStorage.setItem("language", "中文");
                        break;
                }
            }
        </script>
    </body>
</html>
