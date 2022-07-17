package servlet.java;

import bean.java.*;
import java.sql.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
@javax.servlet.annotation.WebServlet("/registerServlet")

public class Register_Servlet extends HttpServlet {
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }
    public void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        Connection con = null;
        PreparedStatement sql = null;
        Register_Bean userBean = new Register_Bean();
        request.setAttribute("userBean", userBean);         //生成一个userBean，用来反馈用户的注册状态
        //获得用户注册时的各个信息
        String waterName = request.getParameter("waterName").trim();
        String userName = request.getParameter("id").trim();
        String password = request.getParameter("password").trim();
        String again_password = request.getParameter("again_password").trim();
        String phone = request.getParameter("phone").trim();
        String address = request.getParameter("address").trim();
        String merchant = request.getParameter("merchant").trim();
        int userphone = 0 ;
        String backNews = "";
        //如果注册的信息有空，则重新注册
        if( userName=="" || waterName=="" || password=="" || again_password=="" || phone=="" || address=="") {
            userBean.setBackNews("请检查是否留空");
            RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
            dispatcher.forward(request, response);
        }
        try {
            boolean b = Register_Servlet.isNumeric(phone) ;
            if (b) {
                userphone = Integer.parseInt(phone);
            }else {                            //电话不是数字，注册失败
                userBean.setBackNews("电话不是数字");
                RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
                dispatcher.forward(request, response);
            }
            if(merchant.equals("是")){        //注册成商家的话，则数据库中客户的列为空
                merchant = userName;
                userName = null;
            }else{
                merchant = null;
            }
            if (!password.equals(again_password)) {         //注册时两次密码不一致
                userBean.setBackNews("两次密码不同，注册失败");
                RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
                dispatcher.forward(request, response);
                return;
            }
            boolean boo = waterName.length() > 0 && password.length() > 0 ;
            if (boo) {
                Context context = new InitialContext();
                Context contextNeeded = (Context) context.lookup("java:comp/env");
                DataSource ds = (DataSource) contextNeeded.lookup("shoppingConn");  //获得连接池
                con = ds.getConnection();         //使用连接池的对象
                String insertCondition = "insert into user values(?,?,?,?,?,?)";
                sql = con.prepareStatement(insertCondition);
                sql.setString(1, waterName);
                sql.setString(2, password);
                sql.setInt(3, userphone);
                sql.setString(4, address);
                sql.setString(5, userName);
                sql.setString(6,merchant);
                int m = sql.executeUpdate();
                //注册信息插入数据库成功，则填写用户Bean的信息
                if (m != 0) {
                    backNews = "注册成功";
                    if(userName==null){
                        userName = merchant;
                    }
                    userBean.setBackNews(backNews);
                    userBean.setPhone(userphone);
                    userBean.setAddress(address);
                    userBean.setUserName(userName);
                    userBean.setMerchant(merchant);
                }
            } else {
                backNews = "信息填写不正确";
                userBean.setBackNews(backNews);
            }
            con.close();
        } catch (SQLException exp) {
            backNews = "该流水编号已被使用，请您更换名字<br>" + exp;
            userBean.setBackNews(backNews);
        } catch (NamingException exp) {
            backNews = "没有设置连接池" + exp;
            userBean.setBackNews(backNews);
        } finally {
            try {
                con.close();
            } catch (Exception ee) {
            }
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
        dispatcher.forward(request, response);
    }
    public static boolean isNumeric(String str){            //判断输入的电话是不是数字
        for (int i = str.length();--i>=0;){
            if (!Character.isDigit(str.charAt(i))){
                return false;
            }
        }
        return true;
    }
}
