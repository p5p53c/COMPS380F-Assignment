<!DOCTYPE html>
<html>
    <head>
        <title>Online Course Website</title>
    </head>
    <body onLoad="init()">
        <security:authorize access="hasAnyRole('USER', 'ADMIN')" var="hasAnyRole">
            <c:url var="logoutUrl" value="/cslogout"/>
            <form action="${logoutUrl}" method="post">
                <input class="hasAnyRole" type="submit" value="Log out" />
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            </form>
        </security:authorize>

        <security:authorize access="isAnonymous()">
            <c:url var="loginUrl" value="/cslogin"/>
            <c:url var="registerUrl" value="/user/create" />
            <form action="${loginUrl}" method="get">
                <input class="hasAnyRole" type="submit" value="Log in" />
            </form>
            <form action="${registerUrl}" method="get">
                <input class="hasAnyRole" type="submit" value="Sign up" />
            </form>
        </security:authorize>
        [<a href="#" onclick="trans(this.innerHTML)">English</a>
        | <a href="#" onclick="trans(this.innerHTML)">中文</a>]

        <h2 class="translate">Course</h2>
        <security:authorize access="hasRole('ADMIN')" var="hasRole">
            <a class="hasRole" href="<c:url value="/user" />">Manage User Accounts</a><br /><br />
        </security:authorize>
        <c:choose>
            <c:when test="${fn:length(courseDatabase) == 0}">
                <i class="course">There are no course in the system.</i>
            </c:when>
            <c:otherwise>
                <c:forEach items="${courseDatabase}" var="course">
                    <span class="course">Course</span> ${course.id}:
                    <a href="<c:url value="/course/view/${course.id}" />">
                        <c:out value="${course.courseTitle}" /></a>
                    <br /><br />
                </c:forEach>
            </c:otherwise>
        </c:choose>

        <h2 class="translate">Poll</h2>
        <security:authorize access="hasRole('ADMIN')" var="hasRole">
            <a class="hasRole" href="<c:url value="/poll/create" />">Create a Poll</a><br/><br/>
        </security:authorize>
        <c:choose>
            <c:when test="${fn:length(pollDatabase) == 0}">
                <i class="poll">There are no poll in the system.</i>
            </c:when>
            <c:otherwise>
                <c:forEach items="${pollDatabase}" var="poll">
                    <span class="poll">Poll</span> ${poll.id}:
                    <a href="<c:url value="/poll/${poll.id}" />">
                        <c:out value="${poll.pollQuestion}" /></a>
                    <br /><br />
                </c:forEach>
            </c:otherwise>
        </c:choose>
        <script>
            const localStorage = window.localStorage;
            function init() {
                if (localStorage) {
                    trans(localStorage.getItem("language"));
                }
            }
            const trans = (language) => {
                var translate = document.getElementsByClassName("translate");
                var hasAnyRole = document.getElementsByClassName("hasAnyRole");
                var hasRole = document.getElementsByClassName("hasRole");
                var course = document.getElementsByClassName("course");
                var poll = document.getElementsByClassName("poll");
                switch (language) {
                    case "English":
                        translate[0].innerHTML = "Course";
                        translate[1].innerHTML = "Poll";
                        if (${hasAnyRole})
                            hasAnyRole[0].value = "Log out";
                        else {
                            hasAnyRole[0].value = "Log in";
                            hasAnyRole[1].value = "Sign up";
                        }
                        if (${hasRole}) {
                            hasRole[0].innerHTML = "Manage User Accounts";
                            hasRole[1].innerHTML = "Create a Poll";
                        }
                        if (${fn:length(courseDatabase) == 0})
                            course[0].innerHTML = "There are no course in the system.";
                        else
                            for (var each in course)
                                course[each].innerHTML = "Course";
                        if (${fn:length(pollDatabase) == 0})
                            poll[0].innerHTML = "There are no poll in the system.";
                        else
                            for (var each in poll)
                                poll[each].innerHTML = "poll";
                        localStorage.setItem("language", "English");
                        break;
                    case "中文":
                        translate[0].innerHTML = "課程";
                        translate[1].innerHTML = "投票";
                        if (${hasAnyRole})
                            hasAnyRole[0].value = "登出";
                        else {
                            hasAnyRole[0].value = "登入";
                            hasAnyRole[1].value = "註冊";
                        }
                        if (${hasRole}) {
                            hasRole[0].innerHTML = "管理使用者帳戶";
                            hasRole[1].innerHTML = "建立投票";
                        }
                        if (${fn:length(courseDatabase) == 0})
                            course[0].innerHTML = "系統裡沒有任何課程。";
                        else
                            for (var each in course)
                                course[each].innerHTML = "課程";
                        if (${fn:length(pollDatabase) == 0})
                            poll[0].innerHTML = "系統裡沒有任何投票";
                        else
                            for (var each in poll)
                                poll[each].innerHTML = "投票";
                        localStorage.setItem("language", "中文");
                        break;
                }
            }
        </script>
    </body>
</html>