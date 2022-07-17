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
@WebServlet("/orderServlet")

public class OrderForm extends HttpServlet {
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }
    public void service(HttpServletRequest request,HttpServletResponse response)
            throws ServletException,IOException{
        request.setCharacterEncoding("utf-8");
        String userName = request.getParameter("id");
        String deletegoodsOrderId = request.getParameter("goodsid");
        Connection con = null;
        PreparedStatement pre = null;
        ResultSet rs;
        ResultSet rs1;
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
        }
        catch (Exception exp){
            loginBean.setNews("请登录");
            response.sendRedirect("index.jsp");
        }
        try {
            Context context = new InitialContext();
            Context contextNeeded = (Context)context.lookup("java:comp/env");
            DataSource ds = (DataSource)contextNeeded.lookup("shoppingConn");
            con = ds.getConnection();
            String querySQL = "select * from shoppingForm where userName=?";
            String querySQL2 = "select * from user where username=?";
            String querySQL3 = "select merchant,goodsAmount from goods where goodsNumber=?";
            String insertSQL = "insert into orderform values(?,?,?,?,?,?,?,?,?,?)";
            String updateSQL = "update goods set goodsAmount = ? where goodsNumber=?";  //更新货物的剩余数量
            String updateStatusSQL_2 = "update orderform set status = ? where userName=? and orderID=?";
            String deleteSQL = "delete from shoppingForm where userName=?";
            String deleteSQL_2 = "delete from orderform where userName=? and orderID=?";
            int goodsAmount = 0;
            int userphone = 0;
            double goodsPrice =0 ;
            String goodsNumber ="";
            String goodsName ="";
            String userAddress= "";
            String merchant = "";
            if(! (deletegoodsOrderId=="")) {                      //如果用户有点击删除该信息，则删除，不点击，则跳过删除订单功能
                if(loginBean.getUserClass().equals("用户")){       //如果是客户的请求，则删除订单
                    pre = con.prepareStatement(deleteSQL_2);
                    pre.setString(1,userName);
                    pre.setString(2,deletegoodsOrderId);
                    pre.executeUpdate();
                    response.sendRedirect("lookOrderForm.jsp");
                }else {                                         //商家的请求，则申请完成订单，商家只能联系客户来删除订单，不能自己删除
                    pre = con.prepareStatement(updateStatusSQL_2);
                    pre.setString(1,"已完成");
                    pre.setString(2,userName);
                    pre.setString(3,deletegoodsOrderId);
                    pre.executeUpdate();
                    response.sendRedirect("lookOrderForm.jsp");
                }
            }

            pre = con.prepareStatement(querySQL);           //先获得客户购物车中的预购商品的信息
            pre.setString(1,userName);
            rs = pre.executeQuery();

            while (rs.next()){                               //有商品信息，则赋值生成订单的一部分数据，一个商品数据生成一个订单
                userName = rs.getString(1);
                goodsNumber = rs.getString(2);
                goodsName = rs.getString(3);
                goodsPrice = rs.getDouble(4);
                goodsAmount = rs.getInt(5);

                pre = con.prepareStatement(querySQL2);          //查询客户的电话和地址
                pre.setString(1,userName);
                rs1 = pre.executeQuery();
                while (rs1.next()){
                    userphone = rs1.getInt(3);
                    userAddress = rs1.getString(4);
                }

                pre = con.prepareStatement(querySQL3);          //查询生成订单中商品的商家和商品的剩余数量
                pre.setString(1,goodsNumber);
                rs1 = pre.executeQuery();
                int goodsAmountResidue = 0;
                while(rs1.next()){                              //获得商品的商家和商品剩余数量信息
                    merchant = rs1.getString(1);
                    goodsAmountResidue = rs1.getInt(2);
                }
                goodsAmountResidue = goodsAmountResidue-goodsAmount;        //生成订单后，减少商品的剩余数量
                if(goodsAmountResidue<1){                       //如果生成订单后，剩余数量为0，或者数量不够
                    goodsAmountResidue = 0;                     //则将商品的剩余数量为0
                    goodsAmount = goodsAmountResidue;           //客户购买到的数量只能是商品的剩余数量
                }
                pre = con.prepareStatement(updateSQL);          //生成订单
                pre.setInt(1,goodsAmountResidue);
                pre.setString(2,goodsNumber);
                pre.execute();
                pre = con.prepareStatement(insertSQL);
                pre.setString(1,userName);
                pre.setInt(2,0);
                pre.setString(3,goodsNumber);
                pre.setString(4,goodsName);
                pre.setInt(5,goodsAmount);
                pre.setDouble(6,goodsPrice);
                pre.setString(7,userAddress);
                pre.setInt(8,userphone);
                pre.setString(9,merchant);
                pre.setString(10,"未完成");
                pre.executeUpdate();
            }

            pre = con.prepareStatement(deleteSQL);          //生成订单后，删除客户购物车的数据
            pre.setString(1,userName);
            pre.executeUpdate();

            con.close();
            response.sendRedirect("lookOrderForm.jsp");      //跳转到订单页面
        }
        catch (SQLException e){
            response.getWriter().println(""+e);
        }
        catch (NamingException exp){
            response.getWriter().println(""+exp);
        }
        catch (Exception e){
            response.getWriter().println(""+e);
        }
        finally {
            try{
                con.close();
            }
            catch (Exception a){}
        }
    }
}
