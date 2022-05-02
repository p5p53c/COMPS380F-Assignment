<!DOCTYPE html>
<html>
    <head>
        <title>Online Course Website</title>
    </head>
    <body onLoad="init()">
        <c:url var="logoutUrl" value="/cslogout"/>
        <form action="${logoutUrl}" method="post">
            <input class="translate" type="submit" value="Log out" />
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            [<a href="#" onclick="trans(this.innerHTML)">English</a>
            | <a href="#" onclick="trans(this.innerHTML)">中文</a>]
        </form>

        <h2><span class="translate">Course</span> ${course.id}: <c:out value="${course.courseTitle}" /></h2>
        <br /><br />
        <c:choose>
            <c:when test="${fn:length(course.lecture) == 0}">
                <i class="lecture">There are no lecture in the system.</i>
            </c:when>
            <c:otherwise>
                <c:forEach items="${course.lecture}" var="lecture" varStatus="status">
                    <span class="lecture">Lecture</span> ${lecture.lecturenumber}:
                    <a href="<c:url value="/lecture/view/${lecture.id}" />">
                        <c:out value="${lecture.lecturetitle}" /></a>
                    <br /><br />
                </c:forEach>
            </c:otherwise>
        </c:choose>

        <input class="translate" type=button value="Back" onCLick="javascript:history.go(-1)">
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
                var translate = document.getElementsByClassName("translate");
                var lecture = document.getElementsByClassName("lecture");
                switch (language) {
                    case "English":
                        translate[0].value = "Log out";
                        translate[1].innerHTML = "Course";
                        translate[2].value = "Back";
                        if (${fn:length(course.lecture) == 0})
                            lecture[0].innerHTML = "There are no lecture in the system.";
                        else
                            for (var each in lecture)
                                lecture[each].innerHTML = "Lecture";
                        localStorage.setItem("language", "English");
                        break;
                    case "中文":
                        translate[0].value = "登出";
                        translate[1].innerHTML = "課程";
                        translate[2].value = "返回";
                        if (${fn:length(course.lecture) == 0})
                            lecture[0].innerHTML = "系統裡沒有任何講課";
                        else
                            for (var each in lecture)
                                lecture[each].innerHTML = "講課";
                        localStorage.setItem("language", "中文");
                        break;
                }
            }
        </script>
    </body>
</html>