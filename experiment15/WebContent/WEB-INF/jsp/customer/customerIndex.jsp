<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>会员首页</title>
<link href="${pageContext.request.contextPath}/css/myCSS.css" rel="stylesheet">
</head>
<body>
	<div style="text-align:center;">
		<div style="width:900px; display:block;margin:0px auto;">
			<div class="pageTitle">会员首页</div>
				<div style="height:100px;"></div>
				<a href="${pageContext.request.contextPath}/findAllProducts">浏览商品</a> <a href="${pageContext.request.contextPath}/findOrders">我的订单</a>
				<div style="height:20px;"></div>
				<hr>
				<a href="${pageContext.request.contextPath}/customer/showUpdateCustomerPwd">修改密码</a> <a href="${pageContext.request.contextPath}/customer/loginOut">安全退出</a>  <a href="${pageContext.request.contextPath}/">首页</a>
		</div>
	</div>
</body>
</html>