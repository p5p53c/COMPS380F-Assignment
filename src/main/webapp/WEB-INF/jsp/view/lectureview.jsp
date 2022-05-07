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

        <h2><span class="translate">Lecture</span> ${lecture.id}: <c:out value="${lecture.lecturetitle}" /></h2>
        <security:authorize access="hasRole('ADMIN')" var="hasRole">
            <a class="hasRole" href="<c:url value="/material/${lecture.id}/create" />">Create a Material</a><br />
        </security:authorize>
        <br />
        <c:choose>
            <c:when test="${fn:length(lecture.materials) == 0}">
                <i class="material">There are no materials in the system.</i><br /><br />
            </c:when>
            <c:otherwise>
                <c:forEach items="${lecture.materials}" var="material" varStatus="status">
                    <span class="material">Material</span> ${material.id}:
                    <a href="<c:url value="/material/view/${material.id}" />">
                        <c:out value="${material.materialname}" /></a>
                        <security:authorize access="hasRole('ADMIN')" var="hasRole">
                        [<a class="action" href="<c:url value="/material/edit/${material.id}" />">Edit</a>]
                        [<a class="action" href="<c:url value="/material/delete/${material.id}" />">Delete</a>]
                    </security:authorize>
                    <br /><br />
                </c:forEach>
            </c:otherwise>
        </c:choose>
        <%@ include file="commentlist.jsp" %>

        <input class="translate" type=button value="Back" onCLick="javascript:history.go(-1)">
        <script>
            const localStorage = window.localStorage;
            function init() {
                if (localStorage) {
                    trans(localStorage.getItem("language"));
                }
            }
            const trans = (language) => {
                var translate = document.getElementsByClassName("translate");
                var hasRole = document.getElementsByClassName("hasRole");
                var material = document.getElementsByClassName("material");
                var action = document.getElementsByClassName("action");
                switch (language) {
                    case "English":
                        translate[0].value = "Log out";
                        translate[1].innerHTML = "Lecture";
                        translate[2].value = "Back";
                        if (${hasRole}) {
                            hasRole[0].innerHTML = "Create a Material";
                            if (${fn:length(lecture.materials) > 0}) {
                                for (var i = 0; i < action.length; i += 2) {
                                    action[i].innerHTML = "Edit";
                                    action[i + 1].innerHTML = "Delete";
                                }
                            }
                        }
                        if (${fn:length(lecture.materials) == 0})
                            material[0].innerHTML = "There are no lecture in the system.";
                        else
                            for (var each in material)
                                material[each].innerHTML = "Material";
                        localStorage.setItem("language", "English");
                        break;
                    case "中文":
                        translate[0].value = "登出";
                        translate[1].innerHTML = "講課";
                        translate[2].value = "返回";
                        if (${hasRole}) {
                            hasRole[0].innerHTML = "建立講義";
                            if (${fn:length(lecture.materials) > 0}) {
                                for (var i = 0; i < action.length; i += 2) {
                                    action[i].innerHTML = "編輯";
                                    action[i + 1].innerHTML = "刪除";
                                }
                            }
                        }
                        if (${fn:length(lecture.materials) == 0})
                            material[0].innerHTML = "系統裡沒有任何講義";
                        else
                            for (var each in material)
                                material[each].innerHTML = "講義";
                        localStorage.setItem("language", "中文");
                        break;
                }
            }
        </script>
    </body>
</html>