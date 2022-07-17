package servlet.java;

import javax.servlet.annotation.WebServlet;
import bean.java.*;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

@WebServlet("/loginServlet")
public class loginServlet extends HttpServlet {
    public void init(ServletConfig config)throws ServletException{
        super.init(config);
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        Connection con = null;
        Statement sql;
        String id = request.getParameter("id").trim();
        String password = request.getParameter("password").trim();
        String user = request.getParameter("user");
        boolean boo = (id.length()>0)&&(password.length()>0);       //用来判断是否登录时用户和信息已填
        try{
            Context context = new InitialContext();
            Context contextNeeded = (Context)context.lookup("java:comp/env");
            DataSource ds = (DataSource)contextNeeded.lookup("shoppingConn");
            con = ds.getConnection();
            String condition = "";
            sql=con.createStatement();
            Login_Bean loginBean = null;
            HttpSession session = request.getSession(true);
            loginBean = (Login_Bean)session.getAttribute("loginBean");
            if(loginBean == null){
                loginBean = new Login_Bean();
                session.setAttribute("loginBean",loginBean);
                loginBean = (Login_Bean) session.getAttribute("loginBean");
            }
            if(user.contains("用户")){                      //获得不同登录类型的用户的密码，
                condition = "select * from user where username='"+id+"'and password ='"
                        +password+"'";
            }else {
                condition = "select * from user where merchant='"+id+"'and password ='"
                        +password+"'";
            }
            if(boo){
                ResultSet rs=sql.executeQuery(condition);
                boolean m = rs.next();
                if(m){
                    String username = loginBean.getUsername();
                    if(username.equals(id)){                         //如果登录Login_Bean中有用户名字，则已经登录了
                        loginBean.setNews(id+"已经登录了");
                    }
                    else{
                        loginBean.setNews(id+"登录成功");
                    }
                    //不同用户类型登录定位到不同的用户主页
                    if(user.contains("用户")){
                        loginBean.setUserClass("用户");
                        loginBean.setUsername(rs.getString(5));
                        RequestDispatcher dispatcher = request.getRequestDispatcher("userIndex.jsp");
                        dispatcher.forward(request,response);
                    }
                    else {
                        loginBean.setUserClass("商家");
                        loginBean.setUsername(rs.getString(6));
                        RequestDispatcher dispatcher = request.getRequestDispatcher("merChantIndex.jsp");
                        dispatcher.forward(request,response);
                    }
                }
                else{
                    String news = "您输入的用户不存在，或密码不匹配,请重新输入";
                    loginBean.setNews(news);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
                    dispatcher.forward(request,response);
                }
            }
            else {
                String news = "请输入用户名和密码";
                loginBean.setNews(news);
                RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
                dispatcher.forward(request,response);
            }
            con.close();
        }
        catch(SQLException exp){
            String news=""+exp;
            response.getWriter().println("<h1>"+news);
        }
        catch(NamingException exp){
            String news="没有设置连接池<br>"+exp;
            response.getWriter().println("<h1>"+news);
        }
        finally {
            try{
                con.close();
            }
            catch (Exception ee){}
        }
    }
}
