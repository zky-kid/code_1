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
<c:set var="theProduct" value="${requestScope.product}" scope="page"/>
<c:if test="${theProduct==null }">无此编号的商品信息</c:if>
<c:if test="${theProduct!=null }">
	<h2 align="center">商品信息</h2>
	<table border=1 align="center">
		<tr>
			<td>编号</td><td>${theProduct.id}</td>
		</tr>
		<tr>
			<td>名称</td><td>${theProduct.name}</td>
		</tr>
		<tr>
			<td>价格</td><td>${theProduct.price}</td>
		</tr>
		<tr>
			<td>录入时间</td><td>${myUtils.getDateTimeString(theProduct.entryTime, 1) }</td>
		</tr>		
		<tr>
			<td>更新时间</td><td>${myUtils.getDateTimeString(theProduct.modifyTime, 1) }</td>
		</tr>		
	</table>
</c:if>
<div align="center"><a href="${pageContext.request.contextPath}/toFindProduct">继续查询商品信息</a> <a href="${pageContext.request.contextPath}/findAllProducts">浏览商品信息</a></div>
</body>
</html>
<!-- 
若直接用${product.entryTime}显示在jsp页面上的是： Sun Jan 05 15:47:07 GMT+08:00 2020 
 -->