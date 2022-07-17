<%--
  Created by IntelliJ IDEA.
  User: a1254
  Date: 2021/6/15
  Time: 15:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<jsp:useBean id="loginBean" class="bean.java.Login_Bean" scope="session" />
<html>
<head>
    <%@ include file="userHead.txt"%>
    <title>用户主页</title>
</head>
<style>
    colorBlue{
        color: blue;
    }
</style>
<body>
    用户登录类别：
    <colorBlue><jsp:getProperty name="loginBean" property="userClass"/><br></colorBlue>
    用户登录名：
    <colorBlue><jsp:getProperty name="loginBean" property="username"/><br></colorBlue>
</body>
</html>