<%--
  Created by IntelliJ IDEA.
  User: a1254
  Date: 2021/6/15
  Time: 23:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="recordBean" class="bean.java.Record_Bean" scope="session"/>
<html>
<head>
    <%@ include file="merchantIndex.txt"%>
    <title>商品信息</title>
</head>
<style>
    #ok{
        font-family: 宋体;font-size: 15px;color: rgba(61, 97, 67, 0.91);
    }
    #hh{
        font-family: 楷体;font-size: 26px;color: #796a61;
    }
    hi{}
</style>
<body>
<div align="center" >
    <jsp:setProperty name="recordBean" property="pageSize" param="pageSize"/>
    <jsp:setProperty name="recordBean" property="currentPage" param="currentPage"/>
    <table id="hh" border="1">
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
            <th>商品价格</th>
            <th>生产日期</th>
            <th>所属类别</th>
            <th>图片</th>
            <th>商品介绍</th>
            <th>生产方</th>
            <th>还剩数量</th>
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
                    for (int j = 0; j < table[0].length; j++) {
                        if(j==5)
                            out.print("<td>"+"<img src=image/"+table[i][5]+" width=150  />"+"</td>");
                        else
                            out.print("<td>"+table[i][j]+"</td>");
                    }
                    out.print("</tr>");
                }
            }
        %>
    </table>
    <br>
    <table id="ok">
        <tr>
            <td>
                <form action="" method="post">
                    全部商品数:<jsp:getProperty name="recordBean" property="totalReCords"/>
                    当前显示第<jsp:getProperty name="recordBean" property="currentPage"/>页
                    (共有<jsp:getProperty name="recordBean" property="totalPages"/>页)
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
