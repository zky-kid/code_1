<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>登录</title>
<link href="${pageContext.request.contextPath}/css/myCSS.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/common.js"></script>
<script type="text/javascript">
function checkValid(theForm){	
	var theLoginNameO=theForm.loginName, theLoginNameV=theLoginNameO.value.trim();
	var theLoginPwdO=theForm.loginPwd, theLoginPwdV=theLoginPwdO.value.trim();
	var theCheckCodeO=theForm.checkCode, theCheckCodeV=theCheckCodeO.value.trim(), theLengthRequired=4;
	if(theLoginNameV==""){
		alert("账号不能为空！");
		theLoginNameO.select();
	} else if(theLoginPwdV==""){
		alert("密码不能为空！");
		theLoginPwdO.select();			
	} else if(theCheckCodeV=="" || theCheckCodeV.length < theLengthRequired){
		alert("验证码的位数必须是"+theLengthRequired);
		theCheckCodeO.select();			
	} else{
		return true;
	}		
	return false;
}	
</script>
<script type="text/javascript">
// 防止网页被嵌套 确保本页始终在顶部窗口打开
if(window.location.href != parent.window.location.href){
	top.location.href = window.location.href
}
</script>
</head>
<body>  
	<div style="text-align:center;">
		<div style="width:900px; display:block;margin:0px auto;">
			<div class="pageTitle">登录</div>  
				<form action="${pageContext.request.contextPath }/doLogin" method="post" onsubmit="return checkValid(this);">
		<table align="center">
			<tr>
				<td class="right"><span class="required">*</span>账号</td><td><input type="text" name="loginName"/></td>				
			</tr>
			<tr>
				<td class="right"><span class="required">*</span>密码</td><td><input type="password" name="loginPwd"/></td>				
			</tr>
			<tr>
				<td class="right">角色</td><td>【<input type="radio" name="loginRole" value="0">管理员】【<input type="radio" name="loginRole" value="1" checked="checked">会员】</td>
			</tr>					
			<tr>
				<td class="right"><span class="required">*</span>验证码</td>
				<td><input name="checkCode"  size="6" maxlength="4" class="checkCodeInput"><span class="required">*</span><img src="${pageContext.request.contextPath}/checkCode" title="点击刷新" alt="点击刷新"  class="passCode" style="height:26px;cursor:pointer;" onclick="this.src=this.src+'?'+Math.random();"></td>
			</tr>	
			<tr>
				<td colspan="2" class="center"><input type="submit" value="确定" class="btn"> <input type="reset" value="重填" class="btn"></td>
			</tr>						
		</table>
				</form>
	<br><a href="${pageContext.request.contextPath}/">返回首页</a>
	</div>
	</div>
	<br>
	${requestScope.theMessage}
</body>
</html>
