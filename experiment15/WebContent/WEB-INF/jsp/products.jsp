<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品信息</title>
<link href="${pageContext.request.contextPath}/css/myCSS.css" rel="stylesheet">
<style>

</style>
</head>
<body>
<c:choose>
    <c:when test="${productsList==null}">
        无商品信息
    </c:when>
    <c:otherwise>
		<div class="pageTitle">商品信息</div>
		<table border=1 align="center">
			<tr>
				<td>序号</td><td>编号</td><td>商品名<td>价格</td><td>查看</td>
			</tr>
		<c:forEach items="${productsList }" var="product" varStatus="theStatus" >
			<c:set var="theId" value="${product.id}" scope="page"/> <%-- 为避免重复取从而提高效率，将常用的量设置成变量theId，--%>
			<c:set var="theIndex" value="${theStatus.index}" scope="page"/>
			<tr onmouseover="changeStyle(this,'bgcMouseOver')" onmouseout="changeStyle(this, 'bgcMouseOut')">
				<td>${theIndex+1}</td>
				<td>${theId}</td>
				<td>${product.name}</td>
				<td>${product.price}</td>
				<td class="center"><a href="${pageContext.request.contextPath }/showAProductById?id=${theId}" class="forms-btn">详细</a></td>
			</tr>        
	    </c:forEach>  	
		</table>
    </c:otherwise>
</c:choose>
<div align="center">
	<a href="${pageContext.request.contextPath}/toFindProduct">查询商品</a>
	<hr width="50%">
	<a href="${pageContext.request.contextPath}/">系统首页</a>
</div>
</body>
</html>