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
				<td>序号</td><td>编号</td><td>商品名<td>价格</td><td>查看</td><td>删除</td>
			</tr>
		<c:forEach items="${productsList }" var="product" varStatus="theStatus" >
			<c:set var="theId" value="${product.id}" scope="page"/> <%-- 为避免重复取从而提高效率，将常用的量设置成变量theId，--%>
			<tr>
				<td>${theStatus.index+1}</td>
				<td>${theId}</td>
				<td>${product.name}</td>
				<td>${product.price}</td>
				<td><a href="${pageContext.request.contextPath }/showAProductById?id=${theId}">详细</a></td>
				<td><a href="${pageContext.request.contextPath }/deleteAProductById?id=${theId}">删除</a></td>	
			</tr>        
	    </c:forEach>
		</table>    
    </c:otherwise>
</c:choose>
<div align="center"><a href="${pageContext.request.contextPath}/toFindProduct">查询商品</a> <a href="${pageContext.request.contextPath}/toAddProduct">添加商品</a></div>
</body>
</html>
<%-- 

<c:if test="${requestScope.customer.gender=='0' }">男</c:if><c:if test="${requestScope.customer.gender=='1' }">女</c:if> ${customer.gender eq '0' ? '男' : '女'} <br>

<c:if test="${productsList==null }">无商品信息</c:if>
<c:if test="${productsList!=null }">
....
</c:if>  这样写有点重复。
jstl标签库，没有c:else。此时可改用如下的c:choose标签

<c:choose>
　　<c:when test="${condition1}">
　　       condition1为true
　　</c:when>
　　<c:when test="${ condition2}">
    　　condition2为true
　　</c:when>
　　<c:otherwise>
　   　condition1和condition2都为false
　　</c:otherwise>
</c:choose> 



 --%>