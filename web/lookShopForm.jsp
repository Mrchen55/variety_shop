<%--
  Created by IntelliJ IDEA.
  User: a1254
  Date: 2021/6/16
  Time: 2:20
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
    <%@ include file="userHead.txt"%>
    <title>查看购物车</title>
</head>
<style>
    #ok{
        font-family: 楷体;font-size: 26px;color: #0d71cb
    }
</style>
<body>
<div align="center">
    <%
        if(loginBean == null){
            response.sendRedirect("index.jsp");
            return;
        }
        else {
            boolean b = loginBean.getUsername()==null||loginBean.getUsername().length()==0;
            if(b){
                response.sendRedirect("index.jsp");
                return;
            }
        }
        Context context = new InitialContext();
        Context contextNeeded = (Context)context.lookup("java:comp/env");
        DataSource ds = (DataSource)contextNeeded.lookup("shoppingConn");
        Connection con = null;
        Statement sql;
        ResultSet rs;
        out.print("<table border=1 >");
        out.print("<tr>");
        out.print("<th id=ok width=120 >"+"用户名");
        out.print("<th id=ok width=120 >"+"商品编码");
        out.print("<th id=ok width=120 >"+"商品名字");
        out.print("<th id=ok width=120 >"+"商品单价");
        out.print("<th id=ok width=120 >"+"商品数量");
        out.print("<th id=ok width=120 >"+"修改数量");
        out.print("<th id=ok width=120 >"+"删除商品");
        out.print("</tr>");
        try{
            con = ds.getConnection();
            sql = con.createStatement();
            String SQL = "select userName,goodsNumber,goodsName,goodsPrice,goodsAmount from shoppingForm "
                    +"where userName='"+loginBean.getUsername()+"'";
            rs = sql.executeQuery(SQL);
            String orderForm = null;
            while(rs.next()) {
                out.print("<tr>");
                out.print("<td id=ok>" + rs.getString(1) + "</td>");
                out.print("<td id=ok>" + rs.getString(2) + "</td>");
                out.print("<td id=ok>" + rs.getString(3) + "</td>");
                out.print("<td id=ok>" + rs.getDouble(4) + "</td>");
                out.print("<td id=ok>" + rs.getInt(5) + "</td>");
                String update = "<form action=updateServlet method=post >" +
                        "<input type=text id=ok name=update size=3 value=" + rs.getInt(5) + " />" +
                        "<input type=hidden id=ok name=goodsNumber value=" + rs.getString(2) + " />" +
                        "<input type=hidden id=ok name=classify value=1 />"+
                        "<input type=submit id=ok value=更新数量 /></form>";

                String del = "<form action=updateServlet method =post >" +
                        "<input type=hidden id=ok name=goodsNumber value=" + rs.getString(2) + " />" +
                        "<input type = hidden id=ok name=classify value=2 />"+
                        "<input type=submit id=ok value=删除该商品 /></form>";

                out.print("<td id=ok>" + update + "</td>");
                out.print("<td id=ok>" + del + "</td>");
                out.print("</tr>");
            }
            out.print("</table>");
           // loginBean = ()session.getAttribute("loginBean");
            /*看看在jsp中是不是%在这个也可以直接用*/
            orderForm="<form action=orderServlet method =post >"+
                    "<input type=hidden id=ok name=id value="+loginBean.getUsername()+" />"+
                    "<input type=hidden id=ok name=goodsNumber value='@#dd#@>?<'>" +
                    "<input type=submit id=ok value=生成订单(同时清空购物车) /></form>";
            out.print(orderForm);
            con.close();
        }catch (SQLException e) {
            out.print("<h1>" + e + "</h1>");
        }
        finally {
            try{
                con.close();
            }catch (Exception e){}
        }
    %>
</div>
</body>
</html>
