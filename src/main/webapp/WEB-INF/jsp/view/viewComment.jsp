<!DOCTYPE html>
<html>
<head>

</head>
<body>
<h2>Comments${commentIdId}: <c:out value="${comment.subject}" /></h2>
<i>Your Name <c:out value="${comment.name}" /></i><br /><br />
<c:out value="${comment.body}" /><br /><br />

<a href="<c:url value="/comment/" />">Return</a>
</body>
</html>