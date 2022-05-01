<!DOCTYPE html>
<html>
    <head>
        <title>Online Course Website</title>
    </head>
    <body  onLoad="init()">
        <c:url var="logoutUrl" value="/cslogout"/>
        <form action="${logoutUrl}" method="post">
            <input id="t_logout" type="submit" value="Log out" />
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            [<a href="#" onclick="trans(this.innerHTML)">English</a>
            |<a href="#" onclick="trans(this.innerHTML)">中文</a>]
        </form>

            <h2><span id="t_material">Material</span> #${material.id}: <c:out value="${material.materialname}" /></h2>
        <security:authorize access="hasRole('ADMIN')">
            [<a id="t_edit" href="<c:url value="/material/edit/${material.id}" />">Edit</a>]
            [<a id="t_delete" href="<c:url value="/material/delete/${material.id}" />">Delete</a>]
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
                        if (document.getElementById("t_edit"))
                            document.getElementById("t_edit").innerHTML = "Edit";
                        if (document.getElementById("t_delete"))
                            document.getElementById("t_delete").innerHTML = "Delete";
                document.getElementById("t_back").innerHTML = "Back";
                        localStorage.setItem("language", "English");
                        console.log("localStorage: " + localStorage.getItem("language"));
                        break;
                    case "中文":
                        document.getElementById("t_logout").value = "登出";
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