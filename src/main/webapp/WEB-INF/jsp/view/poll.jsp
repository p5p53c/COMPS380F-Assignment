<!DOCTYPE html>
<html>
    <head>
        <title>Online Course Website</title>
        <style>
            table {
                width: 100%;
                border-collapse: collapse;
            }
            table th{
                float: left;
            }
            #voteRow1{
                padding: 1px;
                background: linear-gradient(to right, yellow var(--mc1Per), white 0%);
                border: 0.5px solid black;
            }
            #voteRow2{
                padding: 1px;
                background: linear-gradient(to right, yellow var(--mc2Per), white 0%);
                border: 0.5px solid black;
            }
            #voteRow3{
                padding: 1px;
                background: linear-gradient(to right, yellow var(--mc3Per), white 0%);
                border: 0.5px solid black;
            }
            #voteRow4{
                padding: 1px;
                background: linear-gradient(to right, yellow var(--mc4Per), white 0%);
                border: 0.5px solid black;
            }
            .voteNo{
                float: right;
            }
        </style>
    </head>
    <body onload="init()">
        <c:url var="logoutUrl" value="/cslogout"/>
        <form action="${logoutUrl}" method="post">
            <input class="translate" type="submit" value="Log out" />
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            [<a href="#" onclick="trans(this.innerHTML)">English</a>
            | <a href="#" onclick="trans(this.innerHTML)">中文</a>]
        </form>

        <h2><span class="translate">Poll</span> ${poll.id}: <c:out value="${poll.pollQuestion}" /></h2>
        <security:authorize access="hasRole('ADMIN')" var="hasRole">
            [<a id="t_delete" href="<c:url value="/poll/delete/${poll.id}" />">Delete</a>]<br/>
        </security:authorize>
        <form:form method="POST" modelAttribute="voteForm">
            <table>
                <tr>
                    <th><form:label class="translate" path="voteTarget" >Choose one:</form:label></th>
                    </tr>
                    <tr>
                        <td id="voteRow1"><form:radiobutton path="voteTarget" value="${poll.pollMC1}" label="${poll.pollMC1}" onClick="openSubmit(this)" />
                        <div class="voteNo"> ${totalVote1}</div>
                    </td>
                </tr>
                <c:if test="${!empty poll.pollMC2}">
                    <tr>
                        <td id="voteRow2"><form:radiobutton path="voteTarget" value="${poll.pollMC2}" label="${poll.pollMC2}" onClick="openSubmit(this)" />
                            <div class="voteNo"> ${totalVote2}</div>
                        </td>
                    </tr>
                </c:if>
                <c:if test="${!empty poll.pollMC3}">
                    <tr>
                        <td id="voteRow3"><form:radiobutton path="voteTarget" value="${poll.pollMC3}" label="${poll.pollMC3}" onClick="openSubmit(this)" />
                            <div class="voteNo"> ${totalVote3}</div>
                        </td>
                    </tr>
                </c:if>
                <c:if test="${!empty poll.pollMC4}">
                    <tr>
                        <td id="voteRow4"><form:radiobutton path="voteTarget" value="${poll.pollMC4}" label="${poll.pollMC4}" onClick="openSubmit(this)" />
                            <div class="voteNo"> ${totalVote4}</div>
                        </td>
                    </tr>
                </c:if>
                <form:hidden path="pollId" value="${poll.id}" />
                <form:hidden path="username" value="${currentUser}" />
                <tr>
                    <td><input id="Vote" class="translate" type="submit" value="Vote" disabled=true/>
                        <div class="voteNo"><span class="translate">Total votes:</span> ${totalVotes}</div></td>
                </tr>
            </table>
        </form:form>
        <span id="submitWarning" style="color:red" >You must choose one answer before submit!</span><br/>

        <!-- 
            This area is for comments 
        -->
        <%@ include file="commentlist.jsp" %>

        <a class="translate" href="<c:url value="/course" />">Return to Course List</a>

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
                        translate[1].innerHTML = "Poll";
                        translate[2].innerHTML = "Choose one:";
                        translate[3].value = "Vote";
                        translate[4].innerHTML = "Total votes:";
                        translate[5].innerHTML = "Return to Course List";
                        if (${hasRole})
                            document.getElementById("t_delete").innerHTML = "Delete";
                        document.getElementById("submitWarning").innerHTML = "You must choose one answer before submit!";
                        localStorage.setItem("language", "English");
                        break;
                    case "中文":
                        translate[0].value = "登出";
                        translate[1].innerHTML = "投票";
                        translate[2].innerHTML = "選擇一個：";
                        translate[3].value = "投票";
                        translate[4].innerHTML = "總投票數：";
                        translate[5].innerHTML = "返回到課程列表";
                        if (${hasRole})
                            document.getElementById("t_delete").innerHTML = "刪除";
                        document.getElementById("submitWarning").innerHTML = "你必須在投票前選擇一項！";
                        localStorage.setItem("language", "中文");
                        break;
                }
            }

            var currentUser = {
                username: `${currentUser}`,
                voteTarget: `${currentVote.voteTarget}`
            };
            var mcLength = document.querySelectorAll("td input").length - 1;
            function openSubmit(radiobutton) {
                if (radiobutton.checked == true) {
                    document.getElementById("Vote").disabled = false;
                    document.getElementById("submitWarning").hidden = true;
                }
            }
            function checkVoted() {
                if (currentUser.voteTarget != null)
                    for (var i = 1; i <= mcLength; i++) {
                        if (document.getElementById("voteTarget" + i).value == currentUser.voteTarget) {
                            document.getElementById("voteTarget" + i).checked = true;
                            document.getElementById("Vote").disabled = false;
                            document.getElementById("submitWarning").hidden = true;
                        }
                    }
            }
            window.onLoad = checkVoted();
            var votePer = {};
            for (var i = 1; i <= mcLength; i++) {
                switch (i) {
                    case 1:
                        var percent = (${totalVote1} / ${totalVotes}) * 100;
                        document.documentElement.style.setProperty("--mc1Per", percent + "%");
                        break;
                    case 2:
                        var percent = (${totalVote2} / ${totalVotes}) * 100;
                        document.documentElement.style.setProperty("--mc2Per", percent + "%");
                        break;
                    case 3:
                        var percent = (${totalVote3} / ${totalVotes}) * 100;
                        document.documentElement.style.setProperty("--mc3Per", percent + "%");
                        break;
                    case 4:
                        var percent = (${totalVote4} / ${totalVotes}) * 100;
                        document.documentElement.style.setProperty("--mc4Per", percent + "%");
                        break;
                }
            }
        </script>
    </body>
</html>
