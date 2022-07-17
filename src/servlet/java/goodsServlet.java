package servlet.java;

import bean.java.*;
import javax.servlet.annotation.WebServlet;
import javax.sql.DataSource;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
@WebServlet("/goodsServlet")

public class goodsServlet extends HttpServlet {
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }
    public void service(HttpServletRequest request,HttpServletResponse response)
            throws ServletException,IOException{
        HttpSession session = request.getSession(true);
        Connection con = null;
        request.setCharacterEncoding("utf-8");
        Login_Bean loginBean = null;
        Record_Bean recordBean = null;
        try{
            loginBean = (Login_Bean)session.getAttribute("loginBean");
            recordBean = (Record_Bean)session.getAttribute("recordBean");
            if(loginBean == null){
                loginBean = new Login_Bean();
                session.setAttribute("loginBean",loginBean);
            }
        }
        catch (Exception exp){
            response.sendRedirect("index.jsp");
        }
        try{
            Context context = new InitialContext();
            Context contextNeeded = (Context)context.lookup("java:comp/env");
            DataSource ds = (DataSource)contextNeeded.lookup("shoppingConn");
            con = ds.getConnection();
            Statement sql = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
            String query= null;
            if (loginBean.getUserClass().contains("商家")) {
                 //如果是商家的商品页面，则只显示该商家上传的商品
                query = "select goodsName,goodsNumber,goodsPrice,goodsDate,goodsClassify,goodsPicture,goodsIntroduce,goodsMade,goodsAmount "+
                        "from goods where merchant='"+loginBean.getUsername()+"'";
            }else {
                //客户的商品页面，可以显示所有的商品信息
                query = "select merchant,goodsName,goodsNumber,goodsPicture,goodsAmount,goodsClassify,goodsprice from goods ";
            }
            ResultSet rs=sql.executeQuery(query);
            ResultSetMetaData metaData = rs.getMetaData();
            int columnCount = metaData.getColumnCount();                 //获得商品的信息属性的列数
            rs.last();
            int rows = rs.getRow();
            String [][] tableRecord = recordBean.getTableRecord();      //用来存取查到的商品信息
            tableRecord = new String[rows][columnCount];
            rs.beforeFirst();
            int i = 0;
            while(rs.next()){                                           //将商品信息存取到tableRecord的String二维数组
                for (int k = 0; k < columnCount; k++)
                    tableRecord[i][k] = rs.getString(k+1);
                i++;
            }
            recordBean.setTableRecord(tableRecord);                     //存到商品的session_Bean中
            con.close();
            if (loginBean.getUserClass().contains("用户")){           //根据登录用户的类别来重定向商品页面
                response.sendRedirect("userGoods.jsp");
            }else {
                response.sendRedirect("goods.jsp");
            }
        }
        catch (Exception e){
            response.getWriter().print("QueryA错误<br>"+e);
        }
        finally {
            try{
                con.close();
            }
            catch (Exception ee){}
        }
    }
}
