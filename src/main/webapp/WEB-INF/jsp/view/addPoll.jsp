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

        <h2>Create a Poll</h2>
        <form:form method="POST" modelAttribute="pollForm">
            <form:label class="translate" path="question">Question:</form:label><br />
            <form:input type="text" path="question" /><br /><br />
            <form:label class="translate" path="mc1">Choice 1:</form:label><br />
            <form:input type="text" path="mc1" /><br /><br />
            <form:label class="translate" path="mc2">Choice 2:</form:label><br />
            <form:input type="text" path="mc2" /><br /><br />
            <form:label class="translate" path="mc3">Choice 3:</form:label><br />
            <form:input type="text" path="mc3" /><br /><br />
            <form:label class="translate" path="mc4">Choice 4:</form:label><br />
            <form:input type="text" path="mc4" /><br /><br />
            <input class="translate" type="submit" value="Submit"/> 
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
                        translate[1].innerHTML = "Question:";
                        translate[2].innerHTML = "Choice 1:";
                        translate[3].innerHTML = "Choice 2:";
                        translate[4].innerHTML = "Choice 3:";
                        translate[5].innerHTML = "Choice 4:";
                        translate[6].value = "Submit";
                        translate[7].value = "Back";
                        document.getElementsByTagName("H2")[0].innerHTML = "Create a Poll";
                        localStorage.setItem("language", "English");
                        break;
                    case "中文":
                        translate[0].value = "登出";
                        translate[1].innerHTML = "問題：";
                        translate[2].innerHTML = "選擇一：";
                        translate[3].innerHTML = "選擇二：";
                        translate[4].innerHTML = "選擇三：";
                        translate[5].innerHTML = "選擇四：";
                        translate[6].value = "提交";
                        translate[7].value = "返回";
                        document.getElementsByTagName("H2")[0].innerHTML = "建立投票";
                        localStorage.setItem("language", "中文");
                        break;
                }
            }
        </script>
    </body>
</html>