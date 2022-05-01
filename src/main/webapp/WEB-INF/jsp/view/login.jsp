<!DOCTYPE html>
<html>
    <head>
        <title>Online Course Website</title>
    </head>
    <body onLoad="init()">
        <h2 id="title">Online Course Login</h2>
        [<a href="#" onclick="trans(this.innerHTML)">English</a>
        |<a href="#" onclick="trans(this.innerHTML)">中文</a>]
        <form action="cslogin" method="POST">
            <label id="t_username" for="username">Username:</label><br/>
            <input type="text" id="username" name="username" /><br/><br/>
            <label id="t_password" for="password">Password:</label><br/>
            <input type="password" id="password" name="password" /><br/><br/>
            <input type="checkbox" id="remember-me" name="remember-me" />
            <label id="t_remember" for="remember-me">Remember me</label><br/><br/>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input id="t_login" type="submit" value="Log In"/>
        </form>
        <c:if test="${param.error != null}">
            <p id="t_error">Login failed.</p>
        </c:if>
        <c:if test="${param.logout != null}">
            <p id="t_logout">You have logged out.</p>
        </c:if>
        <c:url var="registerUrl" value="/user/create" />
        <form action="${registerUrl}" method="get">
            <br/><input id="t_signup"type="submit" value="Sign up" />
        </form>
        <script>
            const localStorage = window.localStorage;
            function init() {
                if (localStorage) {
                    console.log("localStorage: " + localStorage.getItem("language"));
                    console.log("init()");
                    trans(localStorage.getItem("language"));
                }
            }
            const trans = (language) => {
                console.log("translate");
                switch (language) {
                    case "English":
                        document.getElementById("title").innerHTML = "Online Course Login";
                        document.getElementById("t_username").innerHTML = "Username:";
                        document.getElementById("t_password").innerHTML = "Password:";
                        document.getElementById("t_remember").innerHTML = "Remember me";
                        document.getElementById("t_login").value = "Log In";
                        document.getElementById("t_signup").value = "Sign up";
                        if (document.getElementById("t_error"))
                            document.getElementById("t_error").innerHTML = "Login failed.";
                        if (document.getElementById("t_logout"))
                            document.getElementById("t_logout").innerHTML = "You have logged out.";
                        localStorage.setItem("language", "English");
                        console.log("localStorage: " + localStorage.getItem("language"));
                        break;
                    case "中文":
                        document.getElementById("title").innerHTML = "網上課程登入";
                        document.getElementById("t_username").innerHTML = "用戶名稱：";
                        document.getElementById("t_password").innerHTML = "密碼：";
                        document.getElementById("t_remember").innerHTML = "記住我";
                        document.getElementById("t_login").value = "登入";
                        document.getElementById("t_signup").value = "註冊";
                        //document.getElementById("t_error").innerHTML = "登入失敗";
                        //document.getElementById("t_logout").innerHTML = "你已登出";
                        localStorage.setItem("language", "中文");
                        console.log("localStorage: " + localStorage.getItem("language"));
                        break;
                }
            }
        </script>
    </body>
</html>
