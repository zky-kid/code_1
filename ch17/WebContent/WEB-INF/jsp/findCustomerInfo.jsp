<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>查询会员信息</title>
<link href="${pageContext.request.contextPath}/css/myCSS.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/common.js"></script>
<script type="text/javascript">
function checkValid(theForm){	
	var theId=theForm.id, theIdV=theId.value.trim();
	var theCheckCode=theForm.checkCode, theCheckCodeV=theCheckCode.value.trim(), theLengthRequired=4;
	if(theIdV==""){
		theId.value=0; // id的这个输入框对应customer.id，和串型值不同，为空时，是不能转为零而提示类型不匹配。解决：零值提交就避免报错。
		return true; // 为便于模糊查询，此处应改成可以提交
	} else if(isNaN(theIdV) || theIdV.indexOf(".")!=-1){		
		alert("会员编号必须是非空的非负整数！");
		theId.select();
	} else if(theCheckCodeV=="" || theCheckCodeV.length < theLengthRequired){
		alert("验证码的位数必须是"+theLengthRequired);
		theCheckCode.select();			
	} else{
		return true;
	}		
	//alert("OK");
	return false;
}
/*
function checkValid(theForm){	
	var theId=theForm.id, theIdV=theId.value.trim();
	var theCheckCode=theForm.checkCode, theCheckCodeV=theCheckCode.value.trim(), theLengthRequired=4;
	if(theIdV=="" || isNaN(theIdV) || theIdV.indexOf(".")!=-1){
		alert("会员编号必须是非空的非负整数！");
		theId.select();
	} else if(theCheckCodeV=="" || theCheckCodeV.length < theLengthRequired){
		alert("验证码的位数必须是"+theLengthRequired);
		theCheckCode.select();			
	} else{
		return true;
	}		
	alert("OK");
	return false;
}	
*/
</script>
</head>
<body>
	<div style="width:1000px; margin:0px auto;">		
		<div class="pageTitle">查询会员信息</div>
		<form action="${pageContext.request.contextPath}/findCustomerByIdOrSomeCustomers" method="post" onsubmit="return checkValid(this);">
		<table align="center">
			<tr>
				<td>编号</td><td><input name="id" size="5"  maxlength="6" style="font-size:24px;"></td>
			</tr>
			<tr>
				<td>用户名</td><td><input name="userName" style="font-size:24px;"></td>
			</tr>
			<tr>
				<td>真名</td><td><input name="userRealName" style="font-size:24px;"></td>
			</tr>
			<tr>
				<td>Email</td><td><input name="email" style="font-size:24px;"></td>
			</tr>
			<tr>
				<td>电话</td><td><input name="contactPhone" style="font-size:24px;"></td>
			</tr>
			<tr>
				<td>地址</td><td><input name="address" style="font-size:24px;"></td>
			</tr>									
			<tr>
				<td>验证码</td>
				<td><input name="checkCode" class="checkCodeInput"  size="4" maxlength="4"><img src="${pageContext.request.contextPath}/checkCode" title="点击刷新" alt="点击刷新"  class="passCode" style="height:26px;cursor:pointer;" onclick="this.src=this.src+'?'+Math.random();"></td>
			</tr>					
			<tr>
				<td colspan="2" align="center" class="center"><input type="submit" value="确定"> <input type="reset" value="重填"></td>
			</tr>																							
		</table>			
		</form>
		<br>
		<div align="center">
			<hr style="width:50%;">
			<a href="${pageContext.request.contextPath}/findCustomers">浏览会员信息</a> <a href="${pageContext.request.contextPath}/">首页</a>
			<hr style="width:50%;">
			${theMessage}
		</div>
	</div>	
</body>
</html>