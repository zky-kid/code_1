<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>添加会员</title>
<link href="${pageContext.request.contextPath}/css/myCSS.css" rel="stylesheet">
	<script src="${pageContext.request.contextPath}/plugins/ckeditor/ckeditor.js"></script>
	<script src="${pageContext.request.contextPath}/js/useCKEditor.js"></script>
</head>
<body>
	<div style="width:900px; margin: 0px auto;">
		<h2 style="text-align:center;">添加会员</h2>
		<form action="${pageContext.request.contextPath}/doInsertCustomer" method="post" onsubmit="return checkValid(this);">
			<table align="center">
				<tr>
					<th>账号</th><td><input type="text" name="userName"></td>
				</tr>
				<tr>
					<th>密码</th><td><input type="password" name="password"></td>
				</tr>
				<tr>
					<th>真名</th><td><input type="text" name="userRealName"></td>
				</tr>	
				<tr>
					<th>性别</th><td><input type="radio" name="gender" value="0" checked="checked">男 <input type="radio" name="gender" value="1">女</td>
				</tr>
				<tr>
					<th>Email</th><td><input type="text" name="email"></td>
				</tr>
				<tr>
					<th>电话</th><td><input type="text" name="contactPhone"></td>
				</tr>
				<tr>
					<th>地址</th><td><input type="text" name="address"></td>
				</tr>
				<tr>
					<th>备注</th><td><textarea id="editor" name="memo"></textarea></td>
				</tr>				
				<tr>
					<th>验证码</td>
					<td><input name="checkCode" class="checkCodeInput"  size="4" maxlength="4"><img src="${pageContext.request.contextPath}/checkCode" title="点击刷新" alt="点击刷新"  class="passCode" style="height:26px;cursor:pointer;" onclick="this.src=this.src+'?'+Math.random();"></td>
				</tr>	
				<tr>
					<td colspan="2" align="center" class="center"><input type="submit" value="确定"> <input type="reset" value="重填"></td>
				</tr>																														
			</table>
		</form>
		<hr>
		<div style="text-align:center;">
			<a href="${pageContext.request.contextPath}/toFindCustomerById">查询会员信息</a>
			<br>${requestScope.theMessage }		
		</div>

	</div>
</body>
</html>
<script>
	initSample();
</script>