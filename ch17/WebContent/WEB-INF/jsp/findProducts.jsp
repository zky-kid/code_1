<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="myUtils" class="com.javaee.ch17.utils.MyUtils"/>
<c:set var="theListProducts" value="${requestScope.listProducts }" scope="page"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品列表信息</title>
<link href="${pageContext.request.contextPath}/css/myCSS.css" rel="stylesheet">
</head>
<body>
	<div style="width:1000px; margin:0px auto;">
		<h2 style="text-align:center">商品列表信息</h2>
		<c:set var="theResultSize" value="${theListProducts.size()}" scope="page"/>
		<c:if test="${theResultSize==0}"><div style="text-align:center">无商品信息</div></c:if>
		<c:if test="${theResultSize>0}">	
			<table align="center">
				<tr>
					<th>序号</th><th>编号</th><th>商品名称<th>价格</th><th>类别</th><th>录入时间</th><th>修改时间</th>
					<th>详细</th><th>修改</th><th>删除</th>
				</tr>
			<c:forEach items="${theListProducts }" var="product" varStatus="theStatus" >
				<c:set var="theId" value="${product.id}" scope="page"/> <%-- 为避免重复取从而提高效率，将常用的量设置成变量theId，--%>
				<c:set var="theIndex" value="${theStatus.index}" scope="page"/>
				<tr>
					<td>${theIndex+1}</td>				
					<td>${theId}</td>
					<td>${product.name}</td>
					<td>${product.price}</td>	
					<td>${product.category.name}</td>					
					<td>${myUtils.getDateTimeString(product.entryTime, 2)}</td>
					<td>${myUtils.getDateTimeString(product.modifyTime, 2)}</td>
					<td class="operate"><a href="${pageContext.request.contextPath}/productDetail?id=${theId}">详细</a></td>
					<td class="operate"><a href="${pageContext.request.contextPath}/toUpdateProduct?id=${theId}">修改</a></td>
					<td class="operate"><a href="${pageContext.request.contextPath}/deleteProduct?id=${theId}" onclick="return confirm('确定要删除？');">删除</a></td>
				</tr>
		    </c:forEach>
			</table>
			<div class="center">共有<span class="strong">${theResultSize}</span>条商品记录</div>
		</c:if>
		<div style="text-align:center; margin-top:10px;">
			<hr style="width:50%;">
			<a href="${pageContext.request.contextPath}/">首页</a> <a href="${pageContext.request.contextPath}/toFindProductByIdOrSomeProducts">查询商品信息</a> <a href="${pageContext.request.contextPath}/toOperateProduct?id=0">添加商品</a>
			<hr style="width:50%;">${requestScope.theMessage }
		</div>
		
	</div>
</body>
</html>