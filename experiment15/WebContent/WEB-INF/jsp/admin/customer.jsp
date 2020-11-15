<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="myUtils" class="com.javaee.utils.MyUtils" scope="page"/>
<%-- 为了尽量在jsp中不出现Java代码而改成标签，用jsp:useBean标签(所指向的常是页面工具类)，以执行显示之前的格式转换等操作 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>会员信息</title>
<link href="${pageContext.request.contextPath}/css/myCSS.css" rel="stylesheet">
</head>
<body>
<c:set var="theCustomer" value="${requestScope.customer}" scope="page"/>
<c:if test="${theCustomer==null }">无此会员信息</c:if>
<c:if test="${theCustomer!=null }">
	<h2 align="center">会员信息</h2>
	<table border=1 align="center">
		<tr>
			<td class="right">账号</td><td>${customer.userName}</td>
		</tr>
		<tr>
			<td class="right">密码</td><td>${customer.password}</td>
		</tr>
		<tr>
			<td class="right">真名</td><td>${customer.userRealName}</td>
		</tr>
		<tr>
			<td class="right">性别</td><td>${myUtils.getGenderString(customer.gender)}</td>
		</tr>
		<tr>
			<td class="right">Email</td><td>${customer.email}</td>
		</tr>	
		<tr>
			<td class="right">联系电话</td><td>${customer.contactPhone}</td>
		</tr>	
		<tr>
			<td class="right">地址</td><td>${customer.address}</td>
		</tr>		
	</table>
</c:if>
<div align="center">
	<a href="${pageContext.request.contextPath}/admin/findCustomers">浏览会员</a> 
	<c:if test="${sessionScope.administrator!=null}">
		<a href="${pageContext.request.contextPath}/admin/adminMain">管理员首页</a> <a href="${pageContext.request.contextPath}/admin/toAddProduct">添加商品</a> <a href="${pageContext.request.contextPath}/admin/findAllProducts" title="浏览、修改和删除商品">商品改删</a>
	</c:if>
	<hr width="50%">
	<a href="${pageContext.request.contextPath}/">系统首页</a>
</div>
</body>
</html>
<!-- 
若直接用${product.entryTime}显示在jsp页面上的是： Sun Jan 05 15:47:07 GMT+08:00 2020 
 -->