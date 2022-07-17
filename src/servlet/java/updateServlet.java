package servlet.java;

import bean.java.*;
import javax.servlet.annotation.WebServlet;
import javax.sql.DataSource;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import java.io.*;
import java.sql.*;
import java.util.function.DoubleToIntFunction;
import javax.servlet.*;
import javax.servlet.http.*;
@WebServlet("/updateServlet")

public class updateServlet extends HttpServlet {
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }
    public void service(HttpServletRequest request,HttpServletResponse response)
            throws ServletException,IOException{
        request.setCharacterEncoding("utf-8");
        String amount = request.getParameter("update");
        String goodsNumber = request.getParameter("goodsNumber");
        String classify = request.getParameter("classify");         //用来判断用户的操作是属于更新数量，还是删除商品
        if(amount==null)                        //如果更新的数量为空，则判断为用户粗心输入，重置为1,避免出现错误页面
            amount = "1";
        int newAmount = 0;
        try{
            newAmount = Integer.parseInt(amount);       //将数量字符转换为数字
            if(newAmount<0){
                newAmount = 1;
            }
        }
        catch (NumberFormatException exp){              //如果输入数量的数据不匹配，比如字符，则重置数量为1
            response.getWriter().println("exp");
            newAmount = 1;
        }
        Connection con = null;
        PreparedStatement pre = null;
        Login_Bean loginBean = null;
        HttpSession session = request.getSession(true);
        try{
            loginBean = (Login_Bean)session.getAttribute("loginBean");
            if(loginBean==null){
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
        try{
            Context context = new InitialContext();
            Context contextNeeded = (Context)context.lookup("java:comp/env");
            DataSource ds = (DataSource)contextNeeded.lookup("shoppingConn");
            con = ds.getConnection();
            String updateSQL = "";
            if(classify.equals("1")){               //判断与用户的请求是什么，是更新还是删除
                updateSQL = "update shoppingForm set goodsAmount=? where goodsNumber=?";
                pre = con.prepareStatement(updateSQL);
                pre.setInt(1,newAmount);
                pre.setString(2,goodsNumber);
                pre.executeUpdate();
            }
            else {
                updateSQL = "delete from shoppingForm where userName=? and goodsNumber=? ";
                pre = con.prepareStatement(updateSQL);
                pre.setString(1,loginBean.getUsername());
                pre.setString(2,goodsNumber);
                pre.executeUpdate();
            }

            con.close();
            response.sendRedirect("lookShopForm.jsp");
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
