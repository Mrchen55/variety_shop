<%--
  Created by IntelliJ IDEA.
  User: a1254
  Date: 2021/6/17
  Time: 2:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="recordBean" class="bean.java.Record_Bean" scope="session"/>
<html>
<head>
    <%@ include file="merchantIndex.txt"%>
    <title>删除商品</title>
</head>
<style>
    #ok{
        font-family: 宋体;font-size: 26px;color: black;
    }
    #hi{
        font-family: 宋体;font-size: 15px;color: black;
    }
</style>
删除商品后，自动跳转到商家的功能主页
<body>
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
        <th>商品名</th>
        <th>商品编号</th>
        <th>剩余数量</th>
        <th>图</th>
        <th>下架商品</th>
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
            for (int i = index ; i < pageSize+index; i++) {
                if(i==totalRecord)
                    break;
                out.print("<tr>");
                out.print("<td>"+table[i][0]+"</td>");
                out.print("<td>"+table[i][1]+"</td>");
                out.print("<td>"+table[i][8]+"</td>");
                out.print("<td><img src=image/"+table[i][5]+" width=150 />"+"</td>");
                out.print("<td><a href='deleteGoodsServlet?goodsNumber="+table[i][1]+"'>下架</a>");
                out.print("</tr>");
            }
        }
    %>
</table>
    <table id="hi">
        <tr>
            <td>
                <form action="" method="post">
                    全部商品数:<jsp:getProperty name="recordBean" property="totalReCords"/>
                    当前显示第<jsp:getProperty name="recordBean" property="currentPage"/>页
                    (共有<jsp:getProperty name="recordBean" property="totalPages"/>页)
                    <input type="hidden" name="currentPage" value="<%=recordBean.getCurrentPage()-1%>"/>
                    <input type="submit" id="hi" value="上一页">
                </form>
            </td>
            <td>
                <form action="" method="post">
                    <input type="hidden" name="currentPage" value="<%=recordBean.getCurrentPage()+1%>"/>
                    <input type="submit" id="hi" value="下一页">
                </form>
            </td>
            <td>
                <form action="" id="hi" method="post">
                    输入页码:<input type="text" id="hi" name="currentPage" size="2"/>
                    <input type="submit" id="hi" value="提交"/>
                </form>
            </td>
        </tr>
        <tr>
            <td></td><td></td>
            <td>
                <form action="" id="hi" method="post">
                    每页显示<input type="text" id="hi" name="pageSize" value="<%=recordBean.getPageSize()%>" size="1">
                    条记录<input type="submit" id="hi" value="确定">
                </form>
            </td>
        </tr>
    </table>
</div>
</div>
</body>
</html>
