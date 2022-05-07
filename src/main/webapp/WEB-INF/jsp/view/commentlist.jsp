<!DOCTYPE html>
<html>
<head>

</head>
<body>
<h2>Comment</h2>
<a href="<c:url value="/course/list" />">Return to Course List</a>
<a href="<c:url value="/comment/create" />">Leave a comment</a><br /><br />

<c:choose>
    <c:when test="${fn:length(commentDatabase) == 0}">
        <i>There are no comments now.</i>

    </c:when>
    <c:otherwise>
        <c:forEach items="${commentDatabase}" var="entry">
            Comment ${entry.key}:
            <a href="<c:url value="/comment/view/${entry.key}" />">
               <c:out value="${entry.value.subject}" /></a>
                <security:authorize access="hasRole('ADMIN')" var="hasRole">
                    [<a class="action" href="<c:url value="/comment/edit/${entry.key}" />">Edit</a>]
                    [<a class="action" href="<c:url value="/comment/delete/${entry.key}" />">Delete</a>]
                </security:authorize>
            (User: <c:out value="${entry.value.name}" />)<br />

        </c:forEach>
    </c:otherwise>
</c:choose>

</body>
