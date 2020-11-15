<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>会员注册</title>
<link href="${pageContext.request.contextPath}/css/myCSS.css" rel="stylesheet">
<script src="${pageContext.request.contextPath }/js/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/common.js"></script>
<script type="text/javascript">
var existFlag=0;
function ajaxValidate(theFieldType) {
    var fieldValue, remindId, fieldName;
    if(theFieldType=="1"){
    	fieldValue = $("#userName").val().trim();
    	remindId="userNameRemind";
    	fieldName="账号";
    } else if(theFieldType=="2"){
    	fieldValue = $("#email").val().trim();
    	remindId="emailRemind";
    	fieldName="Email";
    } else {
    	fieldValue = $("#contactPhone").val().trim();
    	remindId="contactPhoneRemind";
    	fieldName="联系电话";
    }
    //alert(fieldValue+"、"+theFieldType); // OK
    if(fieldValue=="") return;
    $.ajax({
        type:"POST",
        url:"${pageContext.request.contextPath}/isExistSame",//提交地址
        data:JSON.stringify({"fieldValue":fieldValue, "fieldType":theFieldType}),//提交数据  
        //data:"fieldValue="+fieldValue,
        contentType : "application/json;charset=UTF-8",
        dataType:"json",//返回json格式        text 
        success:function(data){            
        	if (null != data) {//后端传来的customer的值不是空,不能注册。 null != data.customer
                //alert("不能注册");
            	$("#"+remindId).html("<font color='red'>该" + fieldName + "已被注册！</font>"); 
            	existFlag=1;
            }
        },
        error: function () { // 当data为空时，就跳出success变成error状态了。
        	//alert("可以注册");
        	$("#"+remindId).html("<font color='blue'>可以注册<font>");//如果没有被注册，将提示语清空。
        	existFlag=0;
        }
    });
}
function checkValid(theForm){
	if(existFlag==1){
		alert("会员的账号、Email、电话字段不能重复！");
		return false;
	}
	var theUserName=theForm.userName, theUserNameV=theUserName.value.trim();
	var thePWD=theForm.password, thePWDV=thePWD.value.trim();
	var thePWDRe=theForm.passwordRe, thePWDReV=thePWDRe.value.trim();
	var theUserRealName=theForm.userRealName, theUserRealNameV=theUserRealName.value.trim();
	var theEmail=theForm.email, theEmailV=theEmail.value.trim();
	var theContactPhone=theForm.contactPhone, theContactPhoneV=theContactPhone.value.trim();	
	var theAddress=theForm.address, theAddressV=theAddress.value.trim();	
	var theCheckCode=theForm.checkCode, theCheckCodeV=theCheckCode.value.trim(), theLengthRequired=4;
	if(theUserNameV==""){
		alert("账号不能为空！");
		theUserName.select();
	} else if(thePWDV==""){
		alert("密码不能为空！");
		thePWD.select();			
	} else if(thePWDReV !=thePWDV){
		alert("两次输入的密码必须一致！");
		thePWDRe.select();			
	} else if(theUserRealNameV==""){
		alert("真名不能为空！");
		theUserRealName.select();			
	} else if(theEmailV==""){
		alert("邮箱不能为空！");
		theEmail.select();			
	} else if(theAddressV==""){
		alert("地址不能为空！");
		theAddress.select();			
	} else if(theCheckCodeV=="" || theCheckCodeV.length < theLengthRequired){
		alert("验证码的位数必须是"+theLengthRequired);
		theCheckCode.select();			
	} else{
		return true;
	}		
	//alert("OK");
	return false;
}	
</script>
</head>
<body>
	<div style="text-align:center;">
		<div style="width:900px; display:block; margin:0px auto;">
			<div class="pageTitle">会员注册</div>
			<form action="${pageContext.request.contextPath}/doRegisterCustomer" method="post" onsubmit="return checkValid(this);">
			<table align="center">
				<tr>
					<td class="right"><span class="required">*</span>账号</td><td><input name="userName" id="userName" onblur="ajaxValidate('1')"><span id="userNameRemind"></span></td>
				</tr>
				<tr>
					<td class="right"><span class="required">*</span>密码</td><td><input name="password" type="password"></td>
				</tr>	
				<tr>
					<td class="right"><span class="required">*</span>重输密码</td><td><input name="passwordRe" type="password"></td>
				</tr>	
				<tr>
					<td class="right"><span class="required">*</span>真名</td><td><input name="userRealName" size=5 maxlength="4"></td>
				</tr>
				<tr>
					<td class="right">性别</td><td>【<input name="gender" type="radio" value="0" checked="checked">男】【<input name="gender" type="radio" value="1">女】</td>
				</tr>
				<tr>
					<td class="right"><span class="required">*</span>Email</td><td><input name="email" id="email" onblur="ajaxValidate('2')"><span id="emailRemind"></span></td>
				</tr>	
				<tr>
					<td class="right"><span class="required">*</span>联系电话</td><td><input name="contactPhone" id="contactPhone" onblur="ajaxValidate('3')" size="30" maxlength="50"><span id="contactPhoneRemind"></span></td>
				</tr>	
				<tr>
					<td class="right"><span class="required">*</span>地址</td><td><input name="address" size="40" maxlength="50"></td>
				</tr>
				<tr>
					<td class="right"><span class="required">*</span>验证码</td>
					<td><input name="checkCode"  size="6" maxlength="4" class="checkCodeInput"><img src="${pageContext.request.contextPath}/checkCode" title="点击刷新" alt="点击刷新"  class="passCode" style="height:26px;cursor:pointer;" onclick="this.src=this.src+'?'+Math.random();"></td>
				</tr>					
				<tr>
					<td colspan="2" align="center" class="center"><input type="submit" value="确定" class="btn"> <input type="reset" value="重填" class="btn"></td>
				</tr>																							
			</table>			
			</form>
			<br>
			<a href="${pageContext.request.contextPath}/login">登录</a>
			<br>
			${requestScope.theMessage}
		</div>
	</div>
	
</body>
</html>