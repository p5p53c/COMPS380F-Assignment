<!DOCTYPE html>
<html>
    <head>
        <title>Customer Support</title>
    </head>
    <body onLoad="init()">
        <c:url var="logoutUrl" value="/cslogout"/>
        <form action="${logoutUrl}" method="post">
            <input id="t_logout" type="submit" value="Log out" />
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            [<a href="#" onclick="trans(this.innerHTML)">English</a>
            |<a href="#" onclick="trans(this.innerHTML)">中文</a>]
        </form>

            <h2><span id="h2">Edit User</span> ${user.username}</h2>
        <form:form method="POST" enctype="multipart/form-data" modelAttribute="userForm">
            <form:label class="t_form" path="password">Password</form:label><br/>
            <form:input type="text" path="password" /><br/>
            <form:label class="t_form" path="fullname">Full Name</form:label><br>
            <form:input type="text" path="fullname" /><br>
            <form:label class="t_form" path="address">Address</form:label><br>
            <form:input path="address" type="text" /><br>
            <form:label class="t_form" path="phone">Phone</form:label><br>
            <form:input type="text" path="phone" /><br><br>
            <input class="t_submit" type="submit" value="Edit User"/> <input class="t_submit" type=button value="Back" onCLick="javascript:history.go(-1)">
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
                        document.getElementById("h2").innerHTML = "Edit User";
                        var form = document.getElementsByClassName("t_form");
                        form[0].innerHTML = "Password";
                        form[1].innerHTML = "Full Name";
                        form[2].innerHTML = "Address";
                        form[3].innerHTML = "Phone";
                        var submit = document.getElementsByClassName("t_submit");
                        submit[0].value = "Edit User";
                        submit[1].value = "Back";
                        localStorage.setItem("language", "English");
                        break;
                    case "中文":
                        document.getElementById("t_logout").value = "登出";
                        document.getElementById("h2").innerHTML = "編輯使用者";
                        var form = document.getElementsByClassName("t_form");
                        form[0].innerHTML = "密碼";
                        form[1].innerHTML = "全名";
                        form[2].innerHTML = "地址";
                        form[3].innerHTML = "電話號碼";
                        var submit = document.getElementsByClassName("t_submit");
                        submit[0].value = "編輯使用者";
                        submit[1].value = "返回";
                        localStorage.setItem("language", "中文");
                        break;
                }
            }
            </script>
    </body>
</html>

