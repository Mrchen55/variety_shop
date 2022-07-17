<%--
  Created by IntelliJ IDEA.
  User: a1254
  Date: 2021/6/15
  Time: 15:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"%>

<jsp:useBean id="userBean" class="bean.java.Register_Bean" scope="request"/>
<style>
    #jerry{
        font-family:楷体;font-size:58px;color:black;
    }
    #tom{
        font-family:楷体;font-size:33px;color:blue;
    }
    #ok{
        font-family:宋体;font-size:20px;color: black;
    }
    #ha{
        font-family:宋体;font-size:20px;color: #d55c5c;
    }
    colorRed{color: #3e3ee0
    }
</style>
<html>
<head>
    <title>注册页面</title>
</head>
<body background="image/back.jpg">
<div align="center">
    <p id=jerry>无忧杂货</p>
    <table cellSpacing="1" cellPadding="1" width="300" align="center" border="1">
        <tr valign="bottom">
            <td id="tom"><a href="register.jsp">注册</a></td>
            <td id="tom"><a href="index.jsp">登录</a></td>
        </tr>
    </table>
</div>
<div align="center">
    <form action="registerServlet" method="post">
        <table id="ok">
            <tr>
                <td id="ha">*用户名*：</td>
                <td><input type="text" id="ok" name="id"/></td>
                <td id="ha">*用户密码*：</td>
                <td><input type="password" id="ok" name="password"/></td>
            </tr>
            <tr>
                <td id="ha">*重复密码*</td>
                <td><input type="password" id="ok" name="again_password"/></td>
                <td>*联系电话*:</td>
                <td><input type="text" id="ok" name="phone"/></td>
            </tr>
            <tr>
                <td>*邮寄地址*：</td>
                <td><input type="text" id="ok" name="address"/></td>
                <td>*流水编号*：</td>
                <td><input type="text" id="ok" name="waterName"/></td>
            </tr>
        </table>
        *是否注册成商家*:
        <input type="radio" name="merchant" value="是">是
        <input type="radio" name="merchant" value="否" checked="true" >否
        <input type="submit" name="submit" id="ok" value="提交"/><br>
        <p id="ha">*注意事项：每一项都要填写，电话必须为数字,名字不能包含null。</p>
    </form>
</div>
<div align="center">
    注册反馈:
    <colorRed><jsp:getProperty name="userBean" property="backNews"></jsp:getProperty></colorRed>
    <table  border="3">
        <tr>
            <td>用户名：</td>
            <td><jsp:getProperty name="userBean" property="userName"/></td>
        </tr>
        <tr>
            <td>地址:</td>
            <td><jsp:getProperty name="userBean" property="address"/></td>
        </tr>
        <tr>
            <td>电话:</td>
            <td><jsp:getProperty name="userBean" property="phone"/></td>
        </tr>
        <tr>
            <td>是否成为商家:</td>
            <td>
                <jsp:getProperty name="userBean" property="merchant"/></td>
            </td>
        </tr>
    </table>
</div>
</body>
</html>
