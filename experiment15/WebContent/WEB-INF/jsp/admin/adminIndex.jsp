<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>管理员首页</title>
<link href="${pageContext.request.contextPath}/css/myCSS.css" rel="stylesheet">
</head>
<body>
	<div style="text-align:center;">
		<div style="width:900px; display:block;margin:0px auto;">
			<div class="pageTitle">管理员首页</div>
				<div style="height:100px;"></div>
				<a href="${pageContext.request.contextPath}/admin/toAddProduct">添加商品</a> <a href="${pageContext.request.contextPath}/admin/findAllProducts" title="浏览、修改和删除商品">商品改删</a>
				<br><a href="${pageContext.request.contextPath}/admin/findCustomers">浏览会员</a>
				<div style="height:20px;"></div>
				<hr>
				<a href="${pageContext.request.contextPath}/admin/showUpdateAdministratorPwd">修改密码</a> <a href="${pageContext.request.contextPath}/admin/loginOut">安全退出</a>  <a href="${pageContext.request.contextPath}/">首页</a>
		</div>
	</div>
</body>
</html>