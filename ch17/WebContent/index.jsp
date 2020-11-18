<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>首页_ch17</title>
</head>
<body>
	<div style="width:1000px; margin: 0px auto; background:#CCC;">
		<div style="text-align:center">
			<h2>ch17 SSM整合</h2>
			<hr style="color:blue; width:50%;"/>
			<a href="${pageContext.request.contextPath}/findCustomers">浏览会员信息</a> <a href="${pageContext.request.contextPath}/toFindCustomerByIdOrSomeCustomers">查询会员信息</a> 
			<br><a href="${pageContext.request.contextPath}/findCategories">商品类别管理</a>	
			<br><a href="${pageContext.request.contextPath}/findProducts">商品管理</a>
		</div>
		<div style="background:url(images/footer.jpg) bottom left repeat-x; height:80px;"> </div>
	</div>
</body>
</html>