<%--
  Created by IntelliJ IDEA.
  User: a1254
  Date: 2021/6/16
  Time: 13:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"  %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="java.sql.*" %>
<jsp:useBean id="loginBean" class="bean.java.Login_Bean" scope="session"/>
<html>
<head>
    <title>已下的订单</title>
</head>
<style>
    #ok{
        font-family: 楷体;font-size: 30px;color: #550101;
    }
</style>
<body>
<%
    if(loginBean.getUserClass().equals("用户")){
%>
    <%@ include file="userHead.txt"%>
<%
    }
    else{
%>
    <%@ include file="merchantIndex.txt"%>
<%
    }
%>
<div align="center">
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
        out.print("<table border=1 >");
        out.print("<tr>");
        out.print("<th id=tom whith=100>"+"订单序号");
        out.print("<th id=tom whith=100>"+"用户昵称");
        out.print("<th id=tom whith=200>"+"用户电话.");
        out.print("<th id=tom whith=200>"+"用户地址");
        out.print("<th id=tom whith=200>"+"订单信息");
        out.print("<th id=tom whith=200>"+"订单状态");
        out.print("</tr>");
        try {
            String querySQL = "";
            if (classify.contains("商家")) {
                querySQL = "select * from orderForm where merchant='"+loginBean.getUsername()+"'";
            }else{
                querySQL = "select * from orderForm where userName='"+loginBean.getUsername()+"'";
            }
            rs = sql.executeQuery(querySQL);
            while (rs.next()) {
                out.print("<tr>");
                out.print("<td id=tom>"+rs.getInt(2)+"</td>");
                out.print("<td id=tom>"+rs.getString(1)+"</td>");
                out.print("<td id=tom>"+rs.getInt(8)+"</td>");
                out.print("<td id=tom>"+rs.getString(7)+"</td>");
                out.print("<td id=tom>商品编号："+rs.getString(3)+
                                "<br>商品名称："+rs.getString(4)+
                                "<br>商品数量："+rs.getInt(5)+
                                "<br>商品单价："+rs.getDouble(6)+
                                "<br>商品总价："+rs.getInt(5)*rs.getDouble(6)+
                        "</td>");
                out.print("<td id=ok>"+rs.getString(10)+"</td>");
                if (classify.contains("用户")) {
                    String output = "<form action=orderServlet method =post >" +
                            "<input type=hidden id=ok name=id value=" + rs.getString(1) + " />" +
                            "<input type=hidden id=ok name=goodsid value=" + rs.getString(2) + " />" +
                            "<input type=submit value=删除该订单信息 /></form>";
                    out.print("<td id=ok>" + output + "</td>");
                }else {
                    String output = "<form action=orderServlet method =post >" +
                            "<input type=hidden id=ok name=id value=" + rs.getString(1) + " />" +
                            "<input type=hidden id=ok name=goodsid value=" + rs.getString(2) + " />" +
                            "<input type=submit id=ok value=完成该订单 /></form>";
                    out.print("<td id=ok>" + output + "</td>");
                }
                out.print("</tr>");
            }
            out.print("</table>");
            con.close();
        }catch (SQLException e){
            out.print(e);
        }finally {
            try{
                con.close();
            }catch (Exception e){}
        }
    %>
</div>
</body>
</html>
