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
            <input id="t_logout" type="submit" value="Log out" />
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            [<a href="#" onclick="trans(this.innerHTML)">English</a>
        |<a href="#" onclick="trans(this.innerHTML)">中文</a>]
        </form>

        <h2><span id="t_poll">Poll</span> ${poll.id}: <c:out value="${poll.pollQuestion}" /></h2>
        <security:authorize access="hasRole('ADMIN')">
            [<a id="t_delete" href="<c:url value="/poll/delete/${poll.id}" />">Delete</a>]<br/>
        </security:authorize>
        <form:form method="POST" modelAttribute="voteForm">
            <table>
                <tr>
                    <th><form:label id="t_choose" path="voteTarget" >Choose one:</form:label></th>
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
                    <td><input type="submit" value="Vote" id="Vote"  disabled=true/><div class="voteNo"><span id="t_votes">Total votes:</span> ${totalVotes}</div></td>
                </tr>
            </table>
        </form:form>
        <span id="submitWarning" style="color:red" >You must choose one answer before submit!</span><br/>

        <!-- 
            This area is for comments 
        -->

        <a id="t_return" href="<c:url value="/course" />">Return to Course List</a>

        <script>
            const localStorage = window.localStorage;
            function init() {
                if (localStorage) {
                    trans(localStorage.getItem("language"));
                }
            }
            const trans = (language) => {
                switch (language) {
                    case "English":
                        document.getElementById("t_logout").value = "Log out";
                        document.getElementById("t_poll").innerHTML = "Poll";
                        if (document.getElementById("t_delete"))
                            document.getElementById("t_delete").innerHTML = "Delete";
                        document.getElementById("t_choose").innerHTML = "Choose one:";
                        document.getElementById("Vote").value = "Vote";
                        document.getElementById("t_votes").innerHTML = "Total votes:";
                        document.getElementById("t_return").innerHTML = "Return to Course List";
                        document.getElementById("submitWarning").innerHTML = "You must choose one answer before submit!";
                        localStorage.setItem("language", "English");
                        break;
                    case "中文":
                        document.getElementById("t_logout").value = "登出";
                        document.getElementById("t_poll").innerHTML = "投票";
                        if (document.getElementById("t_delete"))
                            document.getElementById("t_delete").innerHTML = "刪除";
                        document.getElementById("t_choose").innerHTML = "選擇一個：";
                        document.getElementById("Vote").value = "投票";
                        document.getElementById("t_votes").innerHTML = "總投票數：";
                        document.getElementById("t_return").innerHTML = "返回到課程列表";
                        document.getElementById("submitWarning").innerHTML = "你必須在投票前作出選擇！";
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
