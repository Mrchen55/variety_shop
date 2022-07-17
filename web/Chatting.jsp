<%--
  Created by IntelliJ IDEA.
  User: a1254
  Date: 2021/6/16
  Time: 19:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="bean.java.Login_Bean" %>
<%@ page import="javax.sql.DataSource"%>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="java.sql.*" %>
<jsp:useBean id="loginBean" class="bean.java.Login_Bean" scope="session"/>
<html>
<head>
    <title>留言页面</title>
</head>
<style>
    ok{color: #1818de;}
    #ha{font-family:隶书;color: #9323e2;font-size: 15px}
</style>
<body>
<%
    if(loginBean.getUserClass().equals("用户")){
%>
<%@ include file="userHead.txt"%>当前用户名字:<ok><%=loginBean.getUsername()%></ok><br>查看商家聊天：
<%
    }
    else{
%>
<%@ include file="merchantIndex.txt"%>当前商家名字:<%=loginBean.getUsername()%><br>查看用户聊天：
<%
    }
%>
<%
    if (loginBean == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    else {
        boolean b = loginBean.getUsername()==null||loginBean.getUsername().length()==0;
        if (b) {
            response.sendRedirect("index.jsp");
            return;
        }
    }
    Context context = new InitialContext();
    Context contextNeeded = (Context)context.lookup("java:comp/env");
    DataSource ds = (DataSource)contextNeeded.lookup("shoppingConn");
    Connection con = null;
    con = ds.getConnection();
    Statement sql = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
    ResultSet rs;
    String classify = loginBean.getUserClass();
    try {
        String QuerySQL = "";
        String QuerySQL1 = "";
        if (classify.contains("用户")) {
            QuerySQL = "select distinct merchant from message where username='" + loginBean.getUsername() + "'";
            QuerySQL1 = "select mess from message where merchant='" + request.getParameter("name") + "' and userName='" + loginBean.getUsername() + "'";
        } else {
            QuerySQL = "select distinct username from message where merchant='" + loginBean.getUsername() + "'";
            QuerySQL1 = "select mess from message where username='" + request.getParameter("name") + "' and merchant='" + loginBean.getUsername() + "'";
        }
        rs = sql.executeQuery(QuerySQL);
        while (rs.next()) {
            out.print("<a href='Chatting.jsp?name=" + rs.getString(1) + "'>" + rs.getString(1) + "</a>&nbsp&nbsp&nbsp&nbsp&nbsp");
        }
        out.print("<br>");
        rs = sql.executeQuery(QuerySQL1);
        while (rs.next()) {             //聊天的信息
            out.print("<ok id=ha>"+rs.getString(1) +"</ok><br>");
            con.close();
        }
    }
        catch (SQLException e){
        out.print(e);
    }finally {
        try{
            con.close();
        }catch (Exception e){}
    }
%>
<br><br>
<form action="chattingServlet" method="post">
    输入信息：
    <textarea id="ha" name="message" rows="3" cols="50"></textarea>
    <input type="hidden" name="name" value="<%=request.getParameter("name")%>" >
    发送给：<ok><%=request.getParameter("name")%></ok>
    <input type="submit" value="提交">
</form>
</body>
</html>
