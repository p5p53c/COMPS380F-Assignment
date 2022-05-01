<!DOCTYPE html>
<html>
    <head>
        <title>Online Course Website</title>
    </head>
    <body onLoad="init()">
        <security:authorize access="hasAnyRole('USER', 'ADMIN')">
            <c:url var="logoutUrl" value="/cslogout"/>
            <form action="${logoutUrl}" method="post">
                <input id="t_logout" type="submit" value="Log out" />
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                [<a href="#" onclick="trans(this.innerHTML)">English</a>
                |<a href="#" onclick="trans(this.innerHTML)">中文</a>]
            </form>
        </security:authorize>

        <security:authorize access="isAnonymous()">
            <c:url var="loginUrl" value="/cslogin"/>
            <c:url var="registerUrl" value="/user/create" />
            <form action="${loginUrl}" method="get">
                <input id="t_login" type="submit" value="Log in" />
            </form>
            <form action="${registerUrl}" method="get">
                <input id="t_signup" type="submit" value="Sign up" />
            </form>
        </security:authorize>

        <h2 id="t_course">Course</h2>
        <security:authorize access="hasRole('ADMIN')">
            <a id="t_mua" href="<c:url value="/user" />">Manage User Accounts</a><br /><br />
        </security:authorize>
        <c:choose>
            <c:when test="${fn:length(courseDatabase) == 0}">
                <i id="t_nocourse">There are no course in the system.</i>
            </c:when>
            <c:otherwise>
                <c:forEach items="${courseDatabase}" var="course">
                    <span id="t_course" onloadstart="changeText(this)">Course</span> ${course.id}:
                    <a href="<c:url value="/course/view/${course.id}" />">
                        <c:out value="${course.courseTitle}" /></a>
                    <br /><br />
                </c:forEach>
            </c:otherwise>
        </c:choose>

        <h2 id="t_poll" onbeforeunload="changeText(this)">Poll</h2>
        <security:authorize access="hasRole('ADMIN')">
            <a id="t_cpoll" href="<c:url value="/poll/create" />">Create a Poll</a><br/><br/>
        </security:authorize>
        <c:choose>
            <c:when test="${fn:length(pollDatabase) == 0}">
                <i id="t_nopoll">There are no poll in the system.</i>
            </c:when>
            <c:otherwise>
                <c:forEach items="${pollDatabase}" var="poll">
                    <span id="t_poll">Poll</span> ${poll.id}:
                    <a href="<c:url value="/poll/${poll.id}" />">
                        <c:out value="${poll.pollQuestion}" /></a>
                    <br /><br />
                </c:forEach>
            </c:otherwise>
        </c:choose>
        <script>
            const localStorage = window.localStorage;
            function changeText(id) {
                console.log("course: " + id.innerHTML);
                if (localStorage === "English")
                    id.innerHTML = "Course";
                else
                    id.innerHTML = "課程";
                //id.innerHTML = (localStorage == "English")? "Course" : "課程";
            }
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
                        document.getElementById("t_logout").value = "Log out";
                        document.getElementById("t_course").innerHTML = "Course";
                        if (document.getElementById("t_mua"))
                            document.getElementById("t_mua").innerHTML = "Manage User Accounts";
                        if (document.getElementById("t_nocourse"))
                            document.getElementById("t_nocourse").innerHTML = "There are no course in the system.";
                        document.getElementById("t_poll").innerHTML = "Poll";
                        if (document.getElementById("t_cpoll"))
                            document.getElementById("t_cpoll").innerHTML = "Create a Poll";
                        if (document.getElementById("t_nopoll"))
                            document.getElementById("t_nopoll").innerHTML = "There are no poll in the system.";
                        localStorage.setItem("language", "English");
                        console.log("localStorage: " + localStorage.getItem("language"));
                        break;
                    case "中文":
                        document.getElementById("t_logout").value = "登出";
                        document.getElementById("t_course").innerHTML = "課程";
                        if (document.getElementById("t_mua"))
                            document.getElementById("t_mua").innerHTML = "管理使用者帳戶";
                        if (document.getElementById("t_nocourse"))
                            document.getElementById("t_nocourse").innerHTML = "系統裡沒有任何課程。";
                        document.getElementById("t_poll").innerHTML = "投票";
                        if (document.getElementById("t_cpoll"))
                            document.getElementById("t_cpoll").innerHTML = "建立投票";
                        if (document.getElementById("t_nopoll"))
                            document.getElementById("t_nopoll").innerHTML = "系統裡沒有任何投票";
                        localStorage.setItem("language", "中文");
                        console.log("localStorage: " + localStorage.getItem("language"));
                        break;
                }
            }
        </script>
    </body>
</html>