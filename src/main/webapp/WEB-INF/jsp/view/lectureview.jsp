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

            <h2><span id="t_lecture">Lecture</span> ${lecture.id}: <c:out value="${lecture.lecturetitle}" /></h2>
        <security:authorize access="hasRole('ADMIN')">
            <a id="t_cmaterial" href="<c:url value="/material/${lecture.id}/create" />">Create a Material</a><br /><br />
        </security:authorize>
        <br /><br />
        <c:choose>
            <c:when test="${fn:length(lecture.materials) == 0}">
                <i>There are no lecture in the system.</i><br /><br />
            </c:when>
            <c:otherwise>
                <c:forEach items="${lecture.materials}" var="material" varStatus="status">
                    Material ${material.id}:
                    <a href="<c:url value="/material/view/${material.id}" />">
                        <c:out value="${material.materialname}" /></a>
                        <security:authorize access="hasRole('ADMIN')">
                        [<a href="<c:url value="/material/edit/${material.id}" />">Edit</a>]
                        [<a href="<c:url value="/material/delete/${material.id}" />">Delete</a>]
                    </security:authorize>
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
                        document.getElementById("t_lecture").innerHTML = "Lecture";
                        if (document.getElementById("t_cmaterial"))
                            document.getElementById("t_cmaterial").innerHTML = "Create a Material";
                        if (document.getElementById("t_edit"))
                            document.getElementById("t_edit").innerHTML = "Edit";
                        if (document.getElementById("t_delete"))
                            document.getElementById("t_delete").innerHTML = "Delete";
                        document.getElementById("t_back").value = "Back";
                        localStorage.setItem("language", "English");
                        console.log("localStorage: " + localStorage.getItem("language"));
                        break;
                    case "中文":
                        document.getElementById("t_logout").value = "登出";
                        document.getElementById("t_lecture").innerHTML = "講課";
                        if (document.getElementById("t_cmaterial"))
                            document.getElementById("t_cmaterial").innerHTML = "建立講課";
                        if (document.getElementById("t_edit"))
                            document.getElementById("t_edit").innerHTML = "編輯";
                        if (document.getElementById("t_delete"))
                            document.getElementById("t_delete").innerHTML = "刪除";
                        document.getElementById("t_back").value = "返回";
                        localStorage.setItem("language", "中文");
                        console.log("localStorage: " + localStorage.getItem("language"));
                        break;
                }
            }
        </script>
    </body>
</html>