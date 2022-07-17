<%--
  Created by IntelliJ IDEA.
  User: a1254
  Date: 2021/6/16
  Time: 0:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="recordBean" class="bean.java.Record_Bean" scope="session"/>
<html>
<head>
    <%@ include file="userHead.txt"%>
    <title>特定要求商品页面</title>
</head>
<style>
    #ok{
        font-family: 宋体;font-size: 26px;
    }
</style>
<body>
<a href="specialGoods.jsp?fenlei=运动">运动类</a>
<a href="specialGoods.jsp?fenlei=零食">零食类</a>
<a href="specialGoods.jsp?fenlei=生活">生活用品类</a>
<div align="center" >
    <jsp:setProperty name="recordBean" property="pageSize" param="pageSize"/>
    <jsp:setProperty name="recordBean" property="currentPage" param="currentPage"/>
    <table id="ok" border="1">
        <%
            String [][] table = recordBean.getTableRecord();
            if(table == null){
                out.print("没有记录");
                return;
            }
        %>
        <tr>
            <th>商家名</th>
            <th>商品名</th>
            <th>商品编号</th>
            <th>商品图片</th>
            <th>商品单价</th>
            <th>商品数量</th>
        </tr>
        <%
            int totalRecord = table.length;
            int pageSize = recordBean.getPageSize();      //每页显示的记录数
            int totalPages = recordBean.getTotalPages();
            if(totalRecord%pageSize==0)
                totalPages = totalRecord/pageSize;
            else
                totalPages = totalRecord/pageSize+1;
            recordBean.setPageSize(pageSize);
            recordBean.setTotalPages(totalPages);
            if(totalPages>=1){
                if(recordBean.getCurrentPage()<1)
                    recordBean.setCurrentPage(recordBean.getTotalPages());
                if(recordBean.getCurrentPage()>recordBean.getTotalPages())
                    recordBean.setCurrentPage(1);
                int index = (recordBean.getCurrentPage()-1)*pageSize;
                int start = index;
                String fenlei = request.getParameter("fenlei");
                if (fenlei == null ) {
                    response.getWriter().println("userGoods.jsp");
                }
                for (int i = index ; i < pageSize+index; i++) {
                    if (i == totalRecord)
                        break;
                    if (fenlei.equals("运动") && table[i][5].equals("运动类")) {
                        out.print("<tr>");
                        out.print("<td><a href='Chatting.jsp?name=" + table[i][0] + "'>" + table[i][0] + "</a></td>");
                        out.print("<td>" + table[i][1] + "</td>");
                        out.print("<td>" + table[i][2] + "</td>");
                        out.print("<td><img src=image/" + table[i][3] + " width=200 heigth=200 />" + "</td>");
                        out.print("<td>" + table[i][6] + "</td>");
                        out.print("<td>" + table[i][4] + "</td>");
                        out.print("<td><a href='putGoodsServlet?goodsNumber=" + table[i][2] + "'>加入购物车</a>");
                        out.print("</tr>");
                    }
                    if (fenlei.equals("零食") && table[i][5].equals("零食类")) {
                        out.print("<tr>");
                        out.print("<td><a href='Chatting.jsp?name=" + table[i][0] + "'>" + table[i][0] + "</a></td>");
                        out.print("<td>" + table[i][1] + "</td>");
                        out.print("<td>" + table[i][2] + "</td>");
                        out.print("<td><img src=image/" + table[i][3] + " width=200 heigth=200 />" + "</td>");
                        out.print("<td>" + table[i][6] + "</td>");
                        out.print("<td>" + table[i][4] + "</td>");
                        out.print("<td><a href='putGoodsServlet?goodsNumber=" + table[i][2] + "'>加入购物车</a>");
                        out.print("</tr>");
                    }
                    if (fenlei.equals("生活") && table[i][5].equals("生活用品类")) {
                        out.print("<tr>");
                        out.print("<td><a href='Chatting.jsp?name=" + table[i][0] + "'>" + table[i][0] + "</a></td>");
                        out.print("<td>" + table[i][1] + "</td>");
                        out.print("<td>" + table[i][2] + "</td>");
                        out.print("<td><img src=image/" + table[i][3] + " width=200 heigth=200 />" + "</td>");
                        out.print("<td>" + table[i][6] + "</td>");
                        out.print("<td>" + table[i][4] + "</td>");
                        out.print("<td><a href='putGoodsServlet?goodsNumber=" + table[i][2] + "'>加入购物车</a>");
                        out.print("</tr>");
                    }

                }
            }
        %>
    </table>
    <p it="ok">
        全部记录数:<jsp:getProperty name="recordBean" property="totalReCords"/>
        <br>每页最多显示<jsp:getProperty name="recordBean" property="pageSize"/>条记录
        <Br>当前显示第<jsp:getProperty name="recordBean" property="currentPage"/>页
        （共有<jsp:getProperty name="recordBean" property="totalPages"/>页）。
    </p>
    <table id="ok">
        <tr>
            <td>
                <form action="" method="post">
                    <input type="hidden" name="currentPage" value="<%=recordBean.getCurrentPage()-1%>"/>
                    <input type="submit" id="ok" value="上一页">
                </form>
            </td>
            <td>
                <form action="" method="post">
                    <input type="hidden" name="currentPage" value="<%=recordBean.getCurrentPage()+1%>"/>
                    <input type="submit" id="ok" value="下一页">
                </form>
            </td>
            <td>
                <form action="" id="ok" method="post">
                    输入页码:<input type="text" id="ok" name="currentPage" size="2"/>
                    <input type="submit" id="ok" value="提交"/>
                </form>
            </td>
        </tr>
        <tr>
            <td></td><td></td>
            <td>
                <form action="" id="ok" method="post">
                    每页显示<input type="text" id="ok" name="pageSize" value="<%=recordBean.getPageSize()%>" size="1">
                    条记录<input type="submit" id="ok" value="确定">
                </form>
            </td>
        </tr>
    </table>
</div>
</body>
</html>
