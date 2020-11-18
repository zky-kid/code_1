<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="myUtils" class="com.javaee.ch17.utils.MyUtils"/>
<c:set var="theCustomer" value="${requestScope.customerX }" scope="page"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>客户信息</title>
<link href="${pageContext.request.contextPath}/css/myCSS.css" rel="stylesheet">
</head>
<body>
	<div style="width:1000px; margin:0px auto;">
		<h2 align="center">客户信息</h2>
	<c:if test="${theCustomer==null }"><div class="center">无此编号的会员信息</div></c:if>
	<c:if test="${theCustomer!=null }">		
		<table align="center">
			<tr>
				<th>编号</th><td>${theCustomer.id}</td>
			</tr>
			<tr>	
				<th>用户名</th><td>${theCustomer.userName}</td>
			</tr>
			<tr>
				<th>真名</th><td>${theCustomer.userRealName}</td>
			</tr>	
			<tr>
				<th>性别</th><td>${theCustomer.gender eq '0' ? '男' : '女'}</td>
			</tr>
			<tr>
				<th>证件</th>
				<td>
					<c:set var="theCard" value="${theCustomer.card}"/>
					<fieldset>
						<legend>证件</legend>
						类型：身份证<br>
						<%--
						号码：${theCustomer.card.cardNo}<br>
						有效期：${theCustomer.card.startDate}-${theCustomer.card.endDate}
						发证机关：${theCustomer.card.issuingAuthority}					
						 --%>
						号码：${theCard.cardNo}<br>
						有效期：${theCard.startDate}-${theCard.endDate}
						发证机关：${theCard.issuingAuthority}
					</fieldset>
				</td>
			</tr>		
			<tr>
				<th>邮箱</th><td>${theCustomer.email}</td>
			</tr>
			<tr>
				<th>电话</th><td>${theCustomer.contactPhone}</td>
			</tr>
			<tr>
				<th>地址</th><td>${theCustomer.address}</td>
			</tr>
			<tr>
				<th>备注</th><td>${theCustomer.memo}</td>
			</tr>
			<tr>
				<th>创建时间</th><td>${myUtils.getDateTimeString(theCustomer.creationTime, 2)}</td>
			</tr>		
		</table>
	</c:if>		
	</div>
<div align="center">
	<hr style="width:50%;">
	<a href="${pageContext.request.contextPath}/toFindCustomerByIdOrSomeCustomers">继续查询会员信息</a>
</div>
</body>
</html>
<!-- 
<c:if test="${requestScope.customer.gender=='0' }">男</c:if><c:if test="${requestScope.customer.gender=='1' }">女</c:if> ${customer.gender eq '0' ? '男' : '女'} <br>
 -->