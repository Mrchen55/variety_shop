<%--
  Created by IntelliJ IDEA.
  User: a1254
  Date: 2021/6/15
  Time: 11:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<jsp:useBean id="loginBean" class="bean.java.Login_Bean" scope="session"/>
<jsp:useBean id="goodsBean" class="bean.java.Goods_Bean" scope="session"/>
<jsp:useBean id="recordBean" class="bean.java.Record_Bean" scope="session"/>
<html>
  <head>
    <title>登录注册界面</title>
  </head>
  <style>
    #tom{
      font-family: 宋体;font-size: 26px;
    }
    #jerry{
      font-family:楷体;font-size:58px;color:black;
    }
    #ok{
      font-family:楷体;font-size:33px;color:blue;
    }
    body{
      background:url("image/back.jpg");
      background-size: 1190px 620px;
      background-position:50% 50%;
      background-repeat:no-repeat;
    }
    redColor{color: red}
  </style>
  <body id="tom">
  <div align="center">
    <p id=jerry>无忧杂货</p>
    <table cellSpacing="1" cellPadding="1" width="200" align="center" border="1">
      <tr valign="bottom">
        <td id="ok"><a href="register.jsp">注册</a></td>
        <td id="ok"><a href="index.jsp">登录</a></td>
      </tr>
    </table></div>
  <div align="center">
      <form action="loginServlet" method="post" >
      <table>
        <tr>
          <td id=tom >用户名：</td>
          <td><input type="text" id=tom name="id" size="10"><br/></td>
        </tr>
        <tr>
          <td id=tom >密码：</td>
          <td><input type="password" id=tom name="password" size="10"/><br/></td>
        </tr>
          <tr>
            <td><input type="radio" name="user" value="用户" checked="true">用户登录</td>
            <td><input type="radio" name="user" value="商家">商家登录</td>
          </tr>
      </table>
        <input type="submit" id=tom value="登录">
        </form>
    </div>
    <br>
    <div align="center">
      登录信息反馈:
      <redColor><jsp:getProperty name="loginBean" property="news"/></redColor>
    </div>
  </body>
</html>
