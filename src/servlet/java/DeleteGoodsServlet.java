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
@WebServlet("/deleteGoodsServlet")
public class DeleteGoodsServlet extends HttpServlet {
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }
    public void service(HttpServletRequest request,HttpServletResponse response)
            throws ServletException,IOException{
        request.setCharacterEncoding("utf-8");                             //改写一下当前编码，避免获得的数据有汉字或者其他非ASCII字符
        String goodsNumber = request.getParameter("goodsNumber");       //获取商品编码
        Connection con = null;                                             //创建连接数据库的对象
        PreparedStatement pre = null;                                      //预处理对象
        Login_Bean loginBean = null;
        HttpSession session = request.getSession(true);
        try{
            loginBean = (Login_Bean)session.getAttribute("loginBean");
            if(loginBean==null){                                           //如果用户没登录，跳转登录界面
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
        }catch (Exception exp){
            response.sendRedirect("index.jsp");
            return;
        }
        Context contextNeeded = null;
        try{
            Context context = new InitialContext();
            contextNeeded = (Context)context.lookup("java:comp/env");
            DataSource ds = (DataSource)contextNeeded.lookup("shoppingConn");
            con = ds.getConnection();
            String deleteSQL = "";
            deleteSQL = "delete from goods where merchant=? and goodsNumber=? ";        //从商品表中删除指定的商品编号
            pre = con.prepareStatement(deleteSQL);
            pre.setString(1,loginBean.getUsername());
            pre.setString(2,goodsNumber);
            pre.executeUpdate();
            con.close();
            response.sendRedirect("merChantIndex.jsp");
            return;
        }
        catch (SQLException e){
            response.getWriter().println(""+e);
        }
        catch (NamingException exp){
            response.getWriter().println(""+exp);
        }
        finally {
            try{
                con.close();
            }
            catch (Exception ee){}
        }
    }
}