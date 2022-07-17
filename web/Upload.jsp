<%--
  Created by IntelliJ IDEA.
  User: a1254
  Date: 2021/6/15
  Time: 23:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="goodsBean" class="bean.java.Goods_Bean" scope="session"/>
<jsp:useBean id="loginBean" class="bean.java.Login_Bean" scope="session"/>

<html>
<head>
    <%@ include file="merchantIndex.txt"%>
    <title>商家主页</title>
</head>
<style>
    #ok{
        font-family: 宋体;font-size: 26px;color: darkblue;
    }
    colorred{
        color:red;
    }
</style>
登录的商家名：
<body>
<jsp:getProperty name="loginBean" property="username"/>
------------<colorred>请先提交商品的图片，等待上传成功后，再填写其他数据:</colorred>><br>
<form action=uploadServlet method=post ENCTYPE="multipart/form-data" >
    <input type=file name=file id=tom size=5 />
    <input type=submit name=submit id=tom value=提交  />
</form>
上传图片的名字：<jsp:getProperty name="goodsBean" property="goodsPicture"/><br>
上传状态：<colorred><jsp:getProperty name="goodsBean" property="mess" /></colorred>
<br>
<br>
<form action="goodsUploadServlet" method="post">
    商品名称：<input type="text" name="goodsName" id="ok"><br>
    商品编号：<input type="text" name="goodsNumber" id="ok">(商品编号为文字、字母、数字组成)<br>
    所属类别：<input type="radio" name="goodsClassify" id="ok" value="运动类" checked="true">运动类
    <input type="radio" name="goodsClassify" id="ok" value="零食类" >零食类
    <input type="radio" name="goodsClassify" id="ok" value="生活用品类">生活用品类<br>
    商品价格：<input type="text" name="goodsPrice" id="ok"><colorred>（必须为数字）</colorred><br>
    生产日期：<input type="text" name="goodsDate" id="ok"><br>
    商品介绍：<br><textarea  name="goodsIntroduce" id="ok" cols="30" rows="3"></textarea><br>
    生产方：<input type="text" name="goodsMade" id="ok">
    商品数量<input type="text" name="goodsAmount" id="ok"><colorred>（必须为整数）</colorred>：
    <input type="submit" id="tom" value="上传商品">
</form>
</body>
</html>
