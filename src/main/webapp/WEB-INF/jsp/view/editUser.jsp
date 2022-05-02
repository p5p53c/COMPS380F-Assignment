<!DOCTYPE html>
<html>
    <head>
        <title>Customer Support</title>
    </head>
    <body onLoad="init()">
        <c:url var="logoutUrl" value="/cslogout"/>
        <form action="${logoutUrl}" method="post">
            <input class="translate" type="submit" value="Log out" />
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            [<a href="#" onclick="trans(this.innerHTML)">English</a>
            | <a href="#" onclick="trans(this.innerHTML)">中文</a>]
        </form>

        <h2><span class="translate">Edit User</span> ${user.username}</h2>
        <form:form method="POST" enctype="multipart/form-data" modelAttribute="userForm">
            <form:label class="translate" path="password">Password</form:label><br/>
            <form:input type="text" path="password" /><br/><br/>
            <form:label class="translate" path="fullname">Full Name</form:label><br>
            <form:input type="text" path="fullname" /><br/><br/>
            <form:label class="translate" path="address">Address</form:label><br>
            <form:input path="address" type="text" /><br><br/>
            <form:label class="translate" path="phone">Phone</form:label><br>
            <form:input type="text" path="phone" /><br><br>
            <input class="translate" type="submit" value="Edit User"/>
            <input class="translate" type=button value="Back" onCLick="javascript:history.go(-1)">
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
                        translate[0].value = "Log out";
                        translate[1].innerHTML = "Edit User";
                        translate[2].innerHTML = "Password";
                        translate[3].innerHTML = "Full Name";
                        translate[4].innerHTML = "Address";
                        translate[5].innerHTML = "Phone";
                        translate[6].value = "Edit User";
                        translate[7].value = "Back";
                        localStorage.setItem("language", "English");
                        break;
                    case "中文":
                        translate[0].value = "登出";
                        translate[1].innerHTML = "編輯使用者";
                        translate[2].innerHTML = "密碼";
                        translate[3].innerHTML = "全名";
                        translate[4].innerHTML = "地址";
                        translate[5].innerHTML = "電話號碼";
                        translate[6].value = "編輯使用者";
                        translate[7].value = "返回";
                        localStorage.setItem("language", "中文");
                        break;
                }
            }
        </script>
    </body>
</html>

