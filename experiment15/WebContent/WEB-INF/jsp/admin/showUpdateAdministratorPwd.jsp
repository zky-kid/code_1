<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>修改管理员密码</title>
<link href="${pageContext.request.contextPath}/css/myCSS.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/common.js"></script>
<script type="text/javascript">
function checkValid(theForm){	
	//alert("OK");
	/* // 经实验，当表单元素的name属性值含点号时，这样写是不行的。此时，只能改成用id属性值获取。
	var theAdminNameO=theForm.administrator.adminName, theAdminNameV=theAdminNameO.value.trim();
	alert(""+theAdminNameV);
	var theAdminPwdO=theForm.administrator.adminPwd, theAdminPwdV=theAdminPwdO.value.trim();
	*/
	var theAdminNameO = document.getElementById("adminName"), theAdminNameV=theAdminNameO.value.trim();
	var theAdminPwdO = document.getElementById("adminPwd"), theAdminPwdV=theAdminPwdO.value.trim();
	var theNewPwdO=theForm.newPwd, theNewPwdV=theNewPwdO.value.trim();
	var theNewPwdAgainO=theForm.newPwdAgain, theNewPwdAgainV=theNewPwdAgainO.value.trim();
	if(theAdminNameV==""){
		alert("账号不能为空！");
		theAdminNameO.select();
	} else if(theAdminPwdV==""){
		alert("旧密码不能为空！");
		theAdminPwdO.select();			
	} else if(theNewPwdV==""){
		alert("新密码不能为空！");
		theNewPwdO.select();			
	} else if(theNewPwdV!=theNewPwdAgainV){
		alert("输入的两次新密码必须一致！");
		theNewPwdO.select();			
	} else{
		return true;
	}		
	return false;
}	
</script>
</head>
<body>  
	<div style="text-align:center;">
		<div style="width:900px; display:block;margin:0px auto;">
			<div class="pageTitle">登录</div>  
				<form action="${pageContext.request.contextPath }/admin/updateAdministratorPwd" method="post" onsubmit="return checkValid(this);">
		<table align="center">
			<tr>
				<td>账号</td><td><input type="text" name="administrator.adminName" id="adminName"/><span class="required">*</span></td>				
			</tr>
			<tr>
				<td>旧密码</td><td><input type="password" name="administrator.adminPwd" id="adminPwd"/><span class="required">*</span></td>				
			</tr>
			<tr>
				<td>新密码</td><td><input type="password" name="newPwd"/><span class="required">*</span></td>				
			</tr>
			<tr>
				<td>重输新密码</td><td><input type="password" name="newPwdAgain"/><span class="required">*</span></td>				
			</tr>			
			<tr>
				<td colspan="2" class="center"><input type="submit" value="确定"> <input type="reset" value="重填"></td>
			</tr>						
		</table>
				</form>
	<br><a href="${pageContext.request.contextPath}/admin/adminMain">返回管理员首页</a><br><br>
	${requestScope.theMessage}
	</div>
	</div>
	
	
</body>
</html>
