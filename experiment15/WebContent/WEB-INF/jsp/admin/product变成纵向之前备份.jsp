<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="myUtils" class="com.javaee.utils.MyUtils"/> 
<%-- 为了尽量在jsp中不出现Java代码而改成标签，用jsp:useBean标签(所指向的常是页面工具类)，以执行显示之前的格式转换等操作 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品信息</title>
<link href="${pageContext.request.contextPath}/css/myCSS.css" rel="stylesheet">
</head>
<body>
<c:if test="${product==null }">无此编号的商品信息</c:if>
<c:if test="${product!=null }">
	<h2 align="center">商品信息</h2>
	<table border=1 align="center">
		<tr>
			<td>编号</td><td>名称<td>价格</td><td>录入时间</td><td>更新时间</td>
		</tr>
		<tr>
			<td>${product.id}</td>
			<td>${product.name}</td>
			<td>${product.price}</td>	
			<td>${myUtils.getDateTimeString(product.entryTime, 1) }</td>
			<td>${myUtils.getDateTimeString(product.modifyTime, 1) }</td>
		</tr>
	</table>
</c:if>
<div align="center"><a href="${pageContext.request.contextPath}/toFindProduct">继续查询商品信息</a></div>
</body>
</html>
<!-- 
若直接用${product.entryTime}显示在jsp页面上的是： Sun Jan 05 15:47:07 GMT+08:00 2020 


 -->