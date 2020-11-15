<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="myUtils" class="com.javaee.utils.MyUtils" scope="page"/> 
<%-- 为了尽量在jsp中不出现Java代码而改成标签，用jsp:useBean标签(所指向的常是页面工具类)，以执行显示之前的格式转换等操作 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>修改商品信息</title>
<link href="${pageContext.request.contextPath}/css/myCSS.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/common.js"></script>
<script>
	function checkValid(theForm){
		var theNameO = theForm.name, theNameV=theNameO.value.trim();
		var thePriceO = theForm.price, thePriceV=thePriceO.value.trim();
		if(theNameV==""){
			theNameO.select();
			alert("名称非空！");			
			return false;
		} else if(thePriceV=="" || isNaN(thePriceV) || thePriceV < 0){
			thePriceO.select();
			alert("价格是非负数");
			return false;
		}
		return true;
	}
</script>
</head>
<body>
<c:set var="theProduct" value="${requestScope.product}" scope="request"/>
<c:if test="${theProduct==null }">无此编号的商品信息</c:if>
<c:if test="${theProduct!=null }">
	<div style="text-align:center;">
		<div style="width:900px; display:block; margin:0px auto;">
	<h2 align="center">修改商品信息</h2>
	<form action="${pageContext.request.contextPath }/admin/updateAProductById" method="post" onsubmit="return checkValid(this)">
	
	<table border=1 align="center">
		<tr>
			<td>编号</td><td>${theProduct.id}<input type="hidden" name="id" value="${theProduct.id}"></td>
		</tr>
		<tr>
			<td>名称</td><td><input type="text" name="name" value="${theProduct.name}"></td>
		</tr>
		<tr>
			<td>价格</td><td><input type="text" name="price" value="${theProduct.price}"></td>
		</tr>
		<tr>
			<td>录入时间</td><td>${myUtils.getDateTimeString(theProduct.entryTime, 1)}</td>
		</tr>		
		<tr>
			<td>更新时间</td><td>${myUtils.getDateTimeString(theProduct.modifyTime, 1)}</td>
		</tr>
		<tr>
			<td colspan="2" class="center"><input type="submit" value="提交修改" class="btn"></td>
		</tr>		
	</table>
		</form>
		</div>
	</div>
</c:if>
<div align="center">
	${requestScope.theMessage }<br>
	<br><a href="${pageContext.request.contextPath}/toFindProduct">继续查询商品信息</a> <a href="${pageContext.request.contextPath}/findAllProducts">浏览商品信息</a>
</div>
</body>
</html>
<!-- 
若直接用${product.entryTime}显示在jsp页面上的是： Sun Jan 05 15:47:07 GMT+08:00 2020 
 -->