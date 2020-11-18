<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>添加会员</title>
<link href="${pageContext.request.contextPath}/css/myCSS.css" rel="stylesheet">
	<script src="${pageContext.request.contextPath}/js/jquery-3.4.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/plugins/ckeditor/ckeditor.js"></script>
	<%-- < script src="${pageContext.request.contextPath}/js/useCKEditor.js"></ script> --%>
	<script src='${pageContext.request.contextPath}/plugins/My97DatePicker/WdatePicker.js'></script>
<script type="text/javascript">
var existFlag=0;
function ajaxValidateCustomer(theFieldType) {
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
    //if(fieldValue=="")  return; //用户在对应输入框中未留内容，此时直接返回即可   但这会导致先前产生的提示“可以/不可以注册”不同步。所以，改进如下：
    if(fieldValue=="") {
    	$("#"+remindId).html(""); 
    	return;
    }
    $.ajax({
        type:"POST",
        url:"${pageContext.request.contextPath}/isExistSame",//提交地址
        data:JSON.stringify({"fieldValue":fieldValue, "fieldType":theFieldType}),//提交数据  
        //data:"fieldValue="+fieldValue,
        contentType : "application/json;charset=UTF-8",
        dataType:"json",//返回json格式        text 
        success:function(resultData){            
        	if (true == resultData) {//不能注册
                //alert("不能注册");
            	$("#"+remindId).html("<font color='red'>该" + fieldName + "已被注册！</font>"); 
            	existFlag=1;
            } else{
            	$("#"+remindId).html("<font color='blue'>可以注册<font>");//如果没有被注册，将提示语清空。
            	existFlag=0;            	
            }
        },
        error: function () { // 当data为空时，就跳出success变成error状态了。        	

        }
    });
}
function ajaxValidateCard() {
    var cardType, fieldValue, remindId, fieldName;
    var defaultCardTypeCardNoLength=18, theMessageInfo="";
    cardType = $("#cardType").val();
    fieldValue = $("#cardNo").val().trim();
	remindId="cardNoRemind";
	fieldName="类型的卡号";
	//if(fieldValue=="") return; // 证件号还未留内容，此时直接返回即可   但这会导致先前产生的提示“可以/不可以注册”不同步。所以，改进如下：
    if(fieldValue=="") {
    	$("#"+remindId).html(""); 
    	return;
    }	
	
    if(cardType=="0"){ // 是身份证 则必须是输入了满18位 否则直接提示位数不够
    	if(fieldValue.length!=defaultCardTypeCardNoLength){
    		theMessageInfo = "身份证号码必须是"+defaultCardTypeCardNoLength+"位！"
    		alert(theMessageInfo);
    		$("#"+remindId).html(theMessageInfo);
    		existFlag=0; 
    		return;
    	} 
    } 
    $.ajax({
        type:"POST",
        url:"${pageContext.request.contextPath}/isExistSameCard",//提交地址
        data:JSON.stringify({"fieldValue":fieldValue, "fieldType":cardType}),//提交数据  
        contentType : "application/json;charset=UTF-8",
        dataType:"json",//返回json格式        text 
        success:function(resultData){            
        	if (true == resultData) {//不能注册
                $("#"+remindId).html("<font color='red'>该" + fieldName + "已被注册！</font>"); 
            	existFlag=1;
            } else{
            	$("#"+remindId).html("<font color='blue'>可以注册<font>");//如果没有被注册，将提示语清空。
            	existFlag=0;            	
            }
        }
    });
}
function checkValid(theForm){
	if(existFlag==1){
		alert("新会员的账号、Email、电话、证件信息都不能重复注册！");
		return false;
	}
	var theUserName=theForm.userName, theUserNameV=theUserName.value.trim();
	var thePWD=theForm.password, thePWDV=thePWD.value.trim();
	//var thePWDRe=theForm.passwordRe, thePWDReV=thePWDRe.value.trim();
	var theUserRealName=theForm.userRealName, theUserRealNameV=theUserRealName.value.trim();
	var $theCardNo=$("#cardNo"), theCardNoV=$theCardNo.val().trim();
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
	} /*else if(thePWDReV !=thePWDV){
		alert("两次输入的密码必须一致！");
		thePWDRe.select();			
	} */else if(theUserRealNameV==""){
		alert("真名不能为空！");
		theUserRealName.select();			
	} else if(theCardNoV==""){
		alert("证件号码不能为空！");
		$theCardNo.select();			
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
function processInputStatus(theO){
	$("#showInputStatus").html("已输入<b class='strong'>"+theO.value.length+"</b>个字符"); // theO.value.trim().length 既然是实时统计已输个数，还是不要trim了。
}
</script>	
</head>
<body>
	<div style="width:900px; margin: 0px auto;">
		<h2 style="text-align:center;">添加会员</h2>
		<form action="${pageContext.request.contextPath}/doInsertCustomer" method="post" onsubmit="return checkValid(this);">
			<table align="center">
				<tr>
					<th>账号</th><td><input type="text" name="userName" id="userName" onblur="ajaxValidateCustomer('1')"><span id="userNameRemind"></span></td>
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
					<th>证件</th>
					<td>
						<fieldset>
							<legend>证件</legend>
							类型：<select name="card.cardType" id="cardType"><option value="0">身份证</option></select><br>
							号码：<input name="card.cardNo" id="cardNo" size="20" maxlength="30" onkeyup="processInputStatus(this);" onblur="ajaxValidateCard()"><span id="showInputStatus"></span> <span id="cardNoRemind"></span><br>
							有效期：<input type="text" readonly='readonly' name='card.startDate' id="startDateId" class="Wdate" size="10" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd', maxDate:'#F{$dp.$D(\'endDateId\')}'})" />-
                <input type="text" readonly='readonly' name='card.endDate' id="endDateId" class="Wdate" size="10" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd', minDate:'#F{$dp.$D(\'startDateId\')}'})" /><br>
							发证机关：<input name="card.issuingAuthority">
						</fieldset>
					</td>
				</tr>				
				<tr>
					<th>Email</th><td><input type="text" name="email" id="email" onblur="ajaxValidateCustomer('2')"><span id="emailRemind"></span></td>
				</tr>
				<tr>
					<th>电话</th><td><input type="text" name="contactPhone" id="contactPhone" onblur="ajaxValidateCustomer('3')" size="30" maxlength="50"><span id="contactPhoneRemind"></span></td>
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
			<a href="${pageContext.request.contextPath}/findCustomers">浏览会员信息</a> <a href="${pageContext.request.contextPath}/toFindCustomerByIdOrSomeCustomers">查询会员信息</a><br>${requestScope.theMessage }		
		</div>

	</div>
</body>
</html>
<script>
	//initSample();
	/* 
	// 这些都是可选
	CKEDITOR.config.height = 300; // 设置高度
	CKEDITOR.config.width = 'auto';	 // 设置宽度
	var editorElement = CKEDITOR.document.getById('editor');
	editorElement.setHtml("<b>你好</b>"); //设置初始内容 
	*/
	CKEDITOR.replace('editor');

</script>