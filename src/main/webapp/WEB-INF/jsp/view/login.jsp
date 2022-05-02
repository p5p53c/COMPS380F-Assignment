<!DOCTYPE html>
<html>
    <head>
        <title>Online Course Website</title>
    </head>
    <body onLoad="init()">
        <h2 class="translate">Online Course Login</h2>
        [<a href="#" onclick="trans(this.innerHTML)">English</a>
        | <a href="#" onclick="trans(this.innerHTML)">中文</a>]
        <form action="cslogin" method="POST">
            <label class="translate" for="username">Username:</label><br/>
            <input type="text" id="username" name="username" /><br/><br/>
            <label class="translate" for="password">Password:</label><br/>
            <input type="password" id="password" name="password" /><br/><br/>
            <input type="checkbox" id="remember-me" name="remember-me" />
            <label class="translate" for="remember-me">Remember me</label><br/><br/>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input class="translate" type="submit" value="Log In"/>
        </form>
        <c:if test="${param.error != null}">
            <p id="t_error">Login failed.</p>
        </c:if>
        <c:if test="${param.logout != null}">
            <p id="t_logout">You have logged out.</p>
        </c:if>
        <c:url var="registerUrl" value="/user/create" />
        <form action="${registerUrl}" method="get">
            <br/><input class="translate" type="submit" value="Sign up" />
        </form>
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
                        translate[0].innerHTML = "Online Course Login";
                        translate[1].innerHTML = "Username:";
                        translate[2].innerHTML = "Password:";
                        translate[3].innerHTML = "Remember me";
                        translate[4].value = "Log In";
                        translate[5].value = "Sign up";
                        if (document.getElementById("t_error"))
                            document.getElementById("t_error").innerHTML = "Login failed.";
                        if (document.getElementById("t_logout"))
                            document.getElementById("t_logout").innerHTML = "You have logged out.";
                        localStorage.setItem("language", "English");
                        break;
                    case "中文":
                        translate[0].innerHTML = "網上課程登入";
                        translate[1].innerHTML = "用戶名稱：";
                        translate[2].innerHTML = "密碼：";
                        translate[3].innerHTML = "記住我";
                        translate[4].value = "登入";
                        translate[5].value = "註冊";
                        if (document.getElementById("t_error"))
                            document.getElementById("t_error").innerHTML = "登入失敗";
                        if (document.getElementById("t_logout"))
                            document.getElementById("t_logout").innerHTML = "你已登出";
                        localStorage.setItem("language", "中文");
                        break;
                }
            }
        </script>
    </body>
</html>
