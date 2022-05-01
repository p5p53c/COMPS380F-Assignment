<!DOCTYPE html>
<html>
    <head>
        <title>Online Course Website</title>
    </head>
    <body>
        <c:url var="logoutUrl" value="/cslogout"/>
        <form action="${logoutUrl}" method="post">
            <input id="t_logout" type="submit" value="Log out" />
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            [<a href="#" onclick="trans(this.innerHTML)">English</a>
            |<a href="#" onclick="trans(this.innerHTML)">中文</a>]
        </form>

        <h2><span id="t_course">Course</span> ${course.id}: <c:out value="${course.courseTitle}" /></h2>
        <br /><br />
        <c:choose>
            <c:when test="${fn:length(course.lecture) == 0}">
                <i id="t_nolecutre">There are no lecture in the system.</i>
            </c:when>
            <c:otherwise>
                <c:forEach items="${course.lecture}" var="lecture" varStatus="status">
                    Lecture ${lecture.lecturenumber}:
                    <a href="<c:url value="/lecture/view/${lecture.id}" />">
                        <c:out value="${lecture.lecturetitle}" /></a>
                    <br /><br />
                </c:forEach>
            </c:otherwise>
        </c:choose>

        <input id="t_back" type=button value="Back" onCLick="javascript:history.go(-1)">
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
                        document.getElementById("t_logout").value = "Log out";
                        document.getElementById("t_course").innerHTML = "Course";
                        if (document.getElementById("t_nolecutre"))
                            document.getElementById("t_nolecutre").innerHTML = "There are no lecture in the system.";
                        document.getElementById("t_back").innerHTML = "Back";
                        localStorage.setItem("language", "English");
                        console.log("localStorage: " + localStorage.getItem("language"));
                        break;
                    case "中文":
                        document.getElementById("t_logout").value = "登出";
                        document.getElementById("t_course").innerHTML = "課程";
                        if (document.getElementById("t_nolecutre"))
                            document.getElementById("t_nolecutre").innerHTML = "系統裡沒有任何講課";
                        document.getElementById("t_back").innerHTML = "返回";
                        localStorage.setItem("language", "中文");
                        console.log("localStorage: " + localStorage.getItem("language"));
                        break;
                }
            }
        </script>
    </body>
</html>