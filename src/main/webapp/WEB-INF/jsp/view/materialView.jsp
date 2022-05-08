<!DOCTYPE html>
<html>
    <head>
        <title>Online Course Website</title>
    </head>
    <body  onLoad="init()">
        <c:url var="logoutUrl" value="/cslogout"/>
        <form action="${logoutUrl}" method="post">
            <input class="translate" type="submit" value="Log out" />
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            [<a href="#" onclick="trans(this.innerHTML)">English</a>
            | <a href="#" onclick="trans(this.innerHTML)">中文</a>]
        </form>
        <h2><span class="translate">Material</span> #${material.id}: <c:out value="${material.materialname}" /></h2>
        <security:authorize access="hasRole('ADMIN')" var="hasRole">
            [<a class="hasRole" href="<c:url value="/material/edit/${material.id}" />">Edit</a>]
            [<a class="hasRole" href="<c:url value="/material/delete/${material.id}" />">Delete</a>]
        </security:authorize>
        <br /><br />
        <c:out value="${material.materialbody}" /><br /><br />
        <c:if test="${fn:length(material.attachments) > 0}">
            <span id="t_attachments">Attachments:</span>
            <c:forEach items="${material.attachments}" var="attachment" varStatus="status">
                <c:if test="${!status.first}">, </c:if>
                <a href="<c:url value="/material/${material.id}/attachment/${attachment.name}" />">
                    <c:out value="${attachment.name}" /></a>
            </c:forEach><br /><br />
        </c:if>
        <jsp:include page="/comment/list" />
        <jsp:include page="/comment/create"/>
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
                switch (language) {
                    case "English":
                        translate[0].value = "Log out";
                        translate[1].innerHTML = "Material";
                        translate[2].value = "Back";
                        if (${hasRole}) {
                            hasRole[0].innerHTML = "Edit";
                            hasRole[1].innerHTML = "Delete";
                        }
                        if (${fn:length(material.attachments) > 0})
                            document.getElementById("t_attachments").innerHTML = "Attachments:";
                        localStorage.setItem("language", "English");
                        break;
                    case "中文":
                        translate[0].value = "登出";
                        translate[1].innerHTML = "講義";
                        translate[2].value = "返回";
                        if (${hasRole}) {
                            hasRole[0].innerHTML = "編輯";
                            hasRole[1].innerHTML = "刪除";
                        }
                        if (${fn:length(material.attachments) > 0})
                            document.getElementById("t_attachments").innerHTML = "附件：";
                        localStorage.setItem("language", "中文");
                        break;
                }
                transAdd(language);
                transComment(language);
            }
        </script>
    </body>
</html>