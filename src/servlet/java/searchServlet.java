package servlet.java;

import bean.java.*;
import javax.sql.*;
import javax.sql.DataSource;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/searchServlet")
public class searchServlet extends HttpServlet{
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }
    public void service(HttpServletRequest request,HttpServletResponse response)
            throws ServletException,IOException{
        request.setCharacterEncoding("utf-8");
        String searchMess = request.getParameter("mess").trim();
        if (searchMess == null || searchMess.length() == 0) {       //搜索时输入为空，重定向
            response.sendRedirect("userGoods.jsp");
            return;
        }
        Connection con = null;
        String queryCondition = "";
        queryCondition = "select merchant,goodsName,goodsNumber,goodsPicture,goodsAmount,goodsClassify,goodsprice"+
                " from goods where goodsName like '%"+searchMess+"%'";          //使用字符模糊匹配
        Record_Bean recordBean = null;
        HttpSession session = request.getSession(true);
        try{
            recordBean = (Record_Bean)session.getAttribute("recordBean");
            if (recordBean==null){
                recordBean = new Record_Bean();
                session.setAttribute("recordBean",recordBean);
            }
        }
        catch (Exception exp){}
        try{
            Context context = new InitialContext();
            Context contextNeeded = (Context)context.lookup("java:comp/env");
            DataSource ds = (DataSource)contextNeeded.lookup("shoppingConn");
            con = ds.getConnection();
            Statement sql = con.createStatement();
            ResultSet rs = sql.executeQuery(queryCondition);
            ResultSetMetaData metaData = rs.getMetaData();
            int columnCount = metaData.getColumnCount();
            rs.last();
            int rows = rs.getRow();
            String [][] tableRecord ;
            tableRecord = new String[rows][columnCount];          //将客户的特殊查看商品查到的记录放到新的数据列表中，
            rs.beforeFirst();
            int i=0;
            while(rs.next()){
                for (int k = 0; k < columnCount; k++) {
                    tableRecord[i][k] = rs.getString(k+1);
                }
                i++;
            }
            //更新显示的商品信息
            recordBean.setTableRecord(tableRecord);
            con.close();
            response.sendRedirect("userGoods.jsp");

        }catch (Exception e){
            response.getWriter().println(""+e);
        }
        finally {
            try{
                con.close();
            }
            catch (Exception ee){}
        }
    }
}