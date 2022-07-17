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
@WebServlet("/putGoodsServlet")

public class PutGoods extends HttpServlet{
    public void init(ServletConfig config) throws ServletException{
        super.init(config);
    }
    public void service(HttpServletRequest request,HttpServletResponse response)
                throws ServletException,IOException{
        request.setCharacterEncoding("UTF-8");
        Connection con = null;
        PreparedStatement pre = null;
        ResultSet rs;
        String goodsNumber = request.getParameter("goodsNumber");
        Login_Bean loginBean = null;
        HttpSession session = request.getSession(true);
        try{
            loginBean = (Login_Bean)session.getAttribute("loginBean");
            if(loginBean == null){
                loginBean.setNews("请登录");
                response.sendRedirect("index.jsp");
                return;
            }
            else {
                boolean b = loginBean.getUsername() == null || loginBean.getUsername().length()==0;
                if(b){
                    loginBean.setNews("未登录");
                    response.sendRedirect("index.jsp");
                    return;
                }
            }
        }
        catch (Exception exp){
            response.sendRedirect("index.jsp");
            return;
        }
        try{
            Context context = new InitialContext();
            Context contextNeeded = (Context)context.lookup("java:comp/env");
            DataSource ds = (DataSource)contextNeeded.lookup("shoppingConn");
            con =  ds.getConnection();
            String querygoods = "select * from goods where goodsNumber=? ";
            String queryShoppingForm = "select goodsAmount from shoppingform where goodsNumber=? and userName=? ";
            String updateSQL = "update shoppingForm set goodsAmount = ? where goodsNumber=?";
            String insertSQL = "insert into shoppingform values(?,?,?,?,?)";
            pre = con.prepareStatement(queryShoppingForm);
            pre.setString(1,goodsNumber);
            pre.setString(2,loginBean.getUsername());
            rs = pre.executeQuery();

            if(rs.next()){                  //已在购物车
                int amount = rs.getInt(1);
                amount++;
                pre = con.prepareStatement(updateSQL);
                pre.setInt(1,amount);
                pre.setString(2,goodsNumber);
                pre.executeUpdate();
            }
            else {                              //添加物品
                pre=con.prepareStatement(querygoods);
                pre.setString(1,goodsNumber);       //如果有该商品，则添加
                rs = pre.executeQuery();
                if(rs.next()) {
                    pre = con.prepareStatement(insertSQL);
                    pre.setString(1, loginBean.getUsername());
                    pre.setString(2, rs.getString("goodsNumber"));
                    pre.setString(3, rs.getString("goodsName"));
                    pre.setDouble(4, rs.getDouble("goodsPrice"));
                    pre.setInt(5, 1);
                    pre.executeUpdate();
                }
            }
            con.close();
            response.sendRedirect("userGoods.jsp");      //查看购物车
        }
        catch (SQLException exp){
            response.getWriter().println("SQL错误"+exp);
        }
        catch (NamingException exp){}
        catch (Exception ee){
            response.getWriter().println("EXC错误"+ee);
        }
        finally {
            try{
                con.close();
            }
            catch (Exception ee){}
        }
    }
}
