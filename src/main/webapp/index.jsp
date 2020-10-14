<%--
  Created by IntelliJ IDEA.
  User: 道科
  Date: 2020/10/13
  Time: 8:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + 	request.getServerPort() + request.getContextPath() + "/";
%>
<html>

<head>
    <title>Title</title>
    <base href="<%=basePath%>">
</head>
<body>
<script type="text/javascript">
    document.location.href = "login.jsp";
</script>
</body>
</html>
