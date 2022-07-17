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
@WebServlet("/chattingServlet")

public class chattingServlet extends HttpServlet {
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }
    public void service(HttpServletRequest request,HttpServletResponse response)
            throws ServletException,IOException {
        request.setCharacterEncoding("utf-8");                   //改写一下当前编码，避免获得的数据有汉字或者其他非ASCII字符
        Connection con = null;                                   //创建连接数据库的对象
            PreparedStatement pre = null;                        //预处理对象
        ResultSet rs;                                            //结果集对象
        String name = request.getParameter("name").trim();           //获取当前的用户的名字
        String name_2 = "";                             //用来插入语句时，按照客户，商家的格式插入
        Login_Bean loginBean = null;
        HttpSession session = request.getSession(true);
        try{
            loginBean = (Login_Bean)session.getAttribute("loginBean");
            if(loginBean==null){
                loginBean.setNews("请登录");
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
        }
        catch (Exception exp){
            response.sendRedirect("index.jsp");
            return;
        }
        try{
            String message = request.getParameter("message");                       //获取用户的输入信息
            Context context = new InitialContext();                                   //
            Context contextNeeded = (Context) context.lookup("java:comp/env");  //寻找绑定在运行环境中的另一个Contecxt对象
            DataSource ds = (DataSource) contextNeeded.lookup("shoppingConn");  //获得连接池
            con = ds.getConnection();                                                  //使用连接池
            String classify = loginBean.getUserClass();

            if(message!="" && message.length()!=0 && name.length()!=0 && !name.contains("null"))  {
                        //如果输入的信息不为空和接受方不为空，则插入数据
                if(classify.contains("用户")){
                    message = loginBean.getUsername()+":"+message;
                    name_2 = name;
                    name = loginBean.getUsername();
                }else {
                    message = loginBean.getUsername()+":"+message;
                    name_2 = loginBean.getUsername();
                }
                String InsertSQL = "insert into message values(?,?,?,?)";
                pre = con.prepareStatement(InsertSQL);
                pre.setInt(1, 0);
                pre.setString(2, name);
                pre.setString(3, name_2);
                pre.setString(4, message);
                pre.execute();
            }
            con.close();
            RequestDispatcher dispatcher=request.getRequestDispatcher("Chatting.jsp");
            dispatcher.forward(request,response);
        }
        catch (NamingException e){
            response.getWriter().println("1<h1>"+e);
        }
        catch (SQLException exp){
            response.getWriter().println("2<h1>"+exp);
        }
        catch(Exception e){
            response.getWriter().println("3<h1>"+e);
        }
        finally {
            try{
                con.close();
            }catch (Exception e){}
        }
    }
}
