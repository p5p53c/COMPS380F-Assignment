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

        <h2>Create a Poll</h2>
        <form:form method="POST" modelAttribute="pollForm">
            <form:label class="t_form" path="question">Question:</form:label><br />
            <form:input type="text" path="question" /><br /><br />
            <form:label class="t_form" path="mc1">Choice 1:</form:label><br />
            <form:input type="text" path="mc1" /><br /><br />
            <form:label class="t_form" path="mc2">Choice 2:</form:label><br />
            <form:input type="text" path="mc2" /><br /><br />
            <form:label class="t_form" path="mc3">Choice 3:</form:label><br />
            <form:input type="text" path="mc3" /><br /><br />
            <form:label class="t_form" path="mc4">Choice 4:</form:label><br />
            <form:input type="text" path="mc4" /><br /><br />
            <input id="t_submit" type="submit" value="Submit"/> <input id="t_back" type=button value="Back" onCLick="javascript:history.go(-1)">
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
                        document.getElementsByTagName("H2")[0].innerHTML = "Create a Poll";
                        var form = document.getElementsByClassName("t_form");
                        form[0].innerHTML = "Question:";
                        form[1].innerHTML = "Choice 1:";
                        form[2].innerHTML = "Choice 2:";
                        form[3].innerHTML = "Choice 3:";
                        form[4].innerHTML = "Choice 4:";
                        document.getElementById("t_submit").value = "Submit";
                        document.getElementById("t_back").value = "Back";
                        localStorage.setItem("language", "English");
                        break;
                    case "中文":
                        document.getElementById("t_logout").value = "登出";
                        document.getElementsByTagName("H2")[0].innerHTML = "建立投票";
                        var form = document.getElementsByClassName("t_form");
                        form[0].innerHTML = "問題：";
                        form[1].innerHTML = "選擇一：";
                        form[2].innerHTML = "選擇二：";
                        form[3].innerHTML = "選擇三：";
                        form[4].innerHTML = "選擇四：";
                        document.getElementById("t_submit").value = "提交";
                        document.getElementById("t_back").value = "返回";
                        localStorage.setItem("language", "中文");
                        break;
                }
            }
        </script>
    </body>
</html>