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

@WebServlet("/goodsUploadServlet")

public class goodsUploadServlet extends HttpServlet {
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        Connection con = null;
        PreparedStatement pre = null;
        ResultSet rs;
        Goods_Bean goodsBean = null;
        Login_Bean loginBean = null;
        HttpSession session = request.getSession(true);
        try{
            goodsBean = (Goods_Bean)session.getAttribute("goodsBean");
            loginBean = (Login_Bean) session.getAttribute("loginBean");
            if(loginBean == null || goodsBean == null){
                loginBean.setNews("用户未登录");
                response.sendRedirect("index.jsp");
                return;
            }
            else {
                boolean b = loginBean.getUsername()==null||loginBean.getUsername().length()==0;
                if(b){
                    loginBean.setNews("用户未登录");
                    response.sendRedirect("index.jsp");
                }
            }
        }
        catch (Exception exp){
            loginBean.setNews("用户未登录");
            response.sendRedirect("index.jsp");
            return;
        }
                                 //获得上传的货物信息
        String merchant = loginBean.getUsername();
        String goodsName = request.getParameter("goodsName").trim();
        String goodsNumber = request.getParameter("goodsNumber").trim();
        String Price = request.getParameter("goodsPrice").trim();
        String goodsDate = request.getParameter("goodsDate").trim();
        String goodsClassify = request.getParameter("goodsClassify").trim();
        String goodsPicture = goodsBean.getGoodsPicture();
        String goodsIntroduce = request.getParameter("goodsIntroduce").trim();
        String goodsMade = request.getParameter("goodsMade").trim();
        String Amount = request.getParameter("goodsAmount");
        double goodsPrice = 0;
        int goodsAmount = 0;
        boolean b = goodsUploadServlet.IsNumbers(Price,Amount);
                        //上传信息有空，则重新输入商品信息
        if( goodsName=="" || goodsNumber=="" || goodsDate=="" || goodsClassify=="" || goodsPicture=="" || goodsIntroduce=="" || goodsMade=="" || Price=="" ||Amount== "") {
            goodsBean.setMess("请检查信息是否留空或者图片是否已经上传");
            RequestDispatcher dispatcher = request.getRequestDispatcher("Upload.jsp");
            dispatcher.forward(request, response);
        }
        if(b){
            goodsPrice = Double.parseDouble(Price);
            goodsAmount = Integer.parseInt(Amount);
        }else {
            goodsBean.setMess("请检查信息填写的价格和数量是否为数字");
            RequestDispatcher dispatcher = request.getRequestDispatcher("Upload.jsp");
            dispatcher.forward(request, response);
        }
        try{
            Context context = new InitialContext();
            Context contextNeeded = (Context)context.lookup("java:comp/env");
            DataSource ds = (DataSource)contextNeeded.lookup("shoppingConn");
            con = ds.getConnection();
            String insertSQL = "insert into goods values(?,?,?,?,?,?,?,?,?,?)";       //插入到商品表中
            pre = con.prepareStatement(insertSQL);
            pre.setString(1,merchant);
            pre.setString(2,goodsName);
            pre.setString(3,goodsNumber);
            pre.setDouble(4,goodsPrice);
            pre.setString(5,goodsDate);
            pre.setString(6,goodsClassify);
            pre.setString(7,goodsPicture);
            pre.setString(8,goodsIntroduce);
            pre.setString(9,goodsMade);
            pre.setInt(10,goodsAmount);
            pre.executeUpdate();
            con.close();
            goodsBean.setMess("货物已上传成功,可以继续上传新货物图片");
            response.sendRedirect("Upload.jsp");
        }
        catch (SQLException e){
            goodsBean.setMess("商品编号已被使用，请换一个");
            RequestDispatcher dispatcher=request.getRequestDispatcher("Upload.jsp");
            dispatcher.forward(request,response);
            response.getWriter().println("SQLException:"+e);
        }
        catch (NamingException exp){
            response.getWriter().println("NamingException:"+exp);
        }
        catch (Exception e){
            response.getWriter().println("Exception:"+e);
        }
        finally {
            try{
                con.close();
            }
            catch (Exception a){}
        }
    }
    public static boolean IsNumbers(String num,String num2) {       //判断商家上传的商品信息价格和数量是否为数字
        try {
            Double.parseDouble(num);
            Integer.parseInt(num2);
        }
        catch (Exception ee){
            return false;
        }
        return true;
    }
}