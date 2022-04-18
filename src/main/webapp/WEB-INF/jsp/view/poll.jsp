<!DOCTYPE html>
<html>
    <head>
        <title>Online Course Website</title>
    </head>
    <body>
        <c:url var="logoutUrl" value="/cslogout"/>
        <form action="${logoutUrl}" method="post">
            <input type="submit" value="Log out" />
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>

        <h2>Poll ${poll.id}: <c:out value="${poll.pollQuestion}" /></h2>
        <security:authorize access="hasRole('ADMIN')">
            [<a href="<c:url value="/poll/delete/${poll.id}" />">Delete</a>]<br/>
        </security:authorize>
        <form:form method="POST" modelAttribute="voteForm">
            <table>
                <tr>
                    <td><form:label path="voteTarget">Choose one:</form:label></td>
                    </tr>
                    <tr>
                        <td><form:radiobutton  path="voteTarget" value="${poll.pollMC1}" label="${poll.pollMC1}" onClick="openSubmit(this)" /></td>
                    <td>${totalVote1}</td>
                </tr>
                <c:if test="${!empty poll.pollMC2}">
                    <tr>
                        <td><form:radiobutton path="voteTarget" value="${poll.pollMC2}" label="${poll.pollMC2}" onClick="openSubmit(this)" /></td>
                        <td>${totalVote2}</td>
                    </tr>
                </c:if>
                <c:if test="${!empty poll.pollMC3}">
                    <tr>
                        <td><form:radiobutton path="voteTarget" value="${poll.pollMC3}" label="${poll.pollMC3}" onClick="openSubmit(this)" /></td>
                        <td>${totalVote3}</td>
                    </tr>
                </c:if>
                <c:if test="${!empty poll.pollMC4}">
                    <tr>
                        <td><form:radiobutton path="voteTarget" value="${poll.pollMC4}" label="${poll.pollMC4}" onClick="openSubmit(this)" /></td>
                        <td>${totalVote4}</td>
                    </tr>
                </c:if>
                <form:hidden path="pollId" value="${poll.id}" />
                <form:hidden path="username" value="${currentUser}" />
                <tr>
                    <td><input type="submit" value="Submit" id="sb"  disabled=true/></td>
                    <td>Total votes: ${totalVotes}</td>
                </tr>
            </table>
        </form:form>
        <span id="submitWarning" style="color:red" >You must choose one answer before submit!</span><br/>
        currentUser: ${currentUser}<br/>
        currentVote.username: ${currentVote.username}<br/>
        currentVote.voteTarget: ${currentVote.voteTarget}<br/>
        pageContext.request.remoteUser: ${pageContext.request.remoteUser}<br/>
        <!-- This area is for comments -->
        <br/><a href="<c:url value="/course" />">Return to Course List</a>
        <script>
            var currentUser = {
                username: `${currentUser}`,
                voteTarget: `${currentVote.voteTarget}`
            };
            var isLogined = (currentUser.username != ""? true : false);
            console.log(currentUser.username);
            console.log(isLogined);
            var mcLength = document.querySelectorAll("td input").length - 1;
            function openSubmit(radiobutton) {
                if (radiobutton.checked == true && isLogined) {
                    document.getElementById("sb").disabled = false;
                    document.getElementById("submitWarning").hidden = true;
                }
                else
                    document.getElementById("submitWarning").innerHTML = "You must login before voting!";
            }
            function checkVoted() {
                if (currentUser.voteTarget != null)
                    for (var i = 1; i <= mcLength; i++) {
                        if (document.getElementById("voteTarget" + i).value == currentUser.voteTarget) {
                            document.getElementById("voteTarget" + i).checked = true;
                            document.getElementById("sb").disabled = false;
                            document.getElementById("submitWarning").hidden = true;
                        }
                    }
            }
            window.onLoad = checkVoted();
        </script>
    </body>
</html>
