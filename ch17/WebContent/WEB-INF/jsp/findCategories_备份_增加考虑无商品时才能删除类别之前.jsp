<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="myUtils" class="com.javaee.ch17.utils.MyUtils"/>
<c:set var="theListCategories" value="${requestScope.listCategories}" scope="page"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品类别信息</title>
<link href="${pageContext.request.contextPath}/css/myCSS.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/jquery-3.4.1.min.js"></script>
<script>
	function formUpdateContentInitial(theIndex, theId){ // 点击了 第(theIndex+1)行
		$("#theUpdatedId").val(theId);
		$("#theUpdatedName").val($("#theName"+theIndex).text());
		$("#theUpdatedIdShow").text(theId);
		$("#btnUpdate").css({"visibility":"visible"}); // 将有更新作用的按钮的visibility属性(页面载入后初始值是hidden) 改成visible。
	}
	function process(theOperateType){
		$("#operateType").val(theOperateType);
	}
	function checkValid(theForm){
		//alert($("#operateType").val());
		var $theUpdatedName=$("#theUpdatedName"); // 为与JavaScript的变量区分，用jQuery得到的变量加$以作区分。
		if($theUpdatedName.val().trim()==""){
			alert("类别名称非空！");
			$theUpdatedName.select();
			return false;
		}
		return true;
		//if($("#theUpdatedName"))
	}
	
</script>
</head>
<body>
	<div style="width:1000px; margin:0px auto;">
		<h2 style="text-align:center">商品类别信息</h2>
		<c:set var="theResultSize" value="${theListCategories.size()}" scope="page"/>
		<c:if test="${theResultSize==0}"><div style="text-align:center">无类别信息</div></c:if>
		<c:if test="${theResultSize>0}">
	
			<table align="center">
				<tr>
					<th>序号</th><th>编号</th><th>类别名</th><th>更新</th><th>删除</th>
				</tr>
			<c:forEach items="${theListCategories }" var="category" varStatus="theStatus" >
				<c:set var="theId" value="${category.id}" scope="page"/> <%-- 为避免重复取从而提高效率，将常用的量设置成变量theId，--%>
				<c:set var="theIndex" value="${theStatus.index}" scope="page"/>
				<tr>
					<td>${theIndex+1}</td>				
					<td>${theId}</td>
					<td id="theName${theIndex+1}">${category.name}</td>					
					<td><a href="#" onclick="formUpdateContentInitial(${theIndex+1}, ${theId})" >更新</a></td>
					<td><a href="${pageContext.request.contextPath}/deleteCategory?id=${theId}" onclick="return confirm('确定要删除？');">删除</a></td>
				</tr>
		    </c:forEach>
			</table>
			<div class="center">共找到<span class="strong">${theResultSize}</span>条类别记录</div>
		</c:if>
		<hr style="width:50%;">
		<form action="${pageContext.request.contextPath}/operateCategory" method="post" onsubmit="return checkValid(this);">
			<input type="hidden" value="0" id="theUpdatedId" name="id">
			<input type="hidden" value="i" id="operateType" name="operateType">
			<table align="center">
				<tr>
					<th>类别名称</th><td><input name="name" id="theUpdatedName"></td>
				</tr>
				<tr>
					<td colspan="2"><button type="submit" style="visibility:hidden" onclick="process('u');" id="btnUpdate">更新id是“<span id="theUpdatedIdShow"  class="strong"></span>”的类别信息</button> <button type="submit"  onclick="process('i');">添加新的类别信息</button></td>
				</tr>				
			</table>
		</form>
		<div style="text-align:center; margin-top:10px;">
			<hr style="width:50%;">
			<a href="${pageContext.request.contextPath}/">首页</a> <a href="${pageContext.request.contextPath}/toFindCustomerByIdOrSomeCustomers">查询会员信息</a>
			<hr style="width:50%;">
			${requestScope.theMessage }
		</div>
		
	</div>
</body>
</html>
<!-- 
<c:if test="${requestScope.customer.gender=='0' }">男</c:if><c:if test="${requestScope.customer.gender=='1' }">女</c:if> ${customer.gender eq '0' ? '男' : '女'} <br>

<td class="center"><a href="${pageContext.request.contextPath }/showAProductById?id=${theId}" class="forms-btn">详细</a></td>
 -->