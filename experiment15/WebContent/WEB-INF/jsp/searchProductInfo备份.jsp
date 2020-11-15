<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>查询商品信息</title>
<link href="${pageContext.request.contextPath}/css/myCSS.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/common.js"></script>
<script type="text/javascript">
function checkValid(theForm){	
	var theId=theForm.id, theIdV=theId.value.trim();
	var theCheckCode=theForm.checkCode, theCheckCodeV=theCheckCode.value.trim(), theLengthRequired=4;
	if(theIdV=="" || isNaN(theIdV) || theIdV.indexOf(".")!=-1){
		alert("商品编号必须是非空的非负整数！");
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
function refreshCode(oStr){
	var theImgO = document.getElementById(oStr);
	theImgO.src = theImgO.src+'?'+Math.random();
}
</script>
<style>
	.passCode{
		cursor:pointer; height:30px;
	}
</style>

</head>
<body>
	<div style="text-align:center;">
		<div style="width:900px; display:block; margin:0px auto;">
			<div class="pageTitle">查询商品信息</div>
			<form action="${pageContext.request.contextPath}/findProductById" method="post" onsubmit="return checkValid(this);">
			<table align="center">
				<tr>
					<td>编号</td><td><input name="id" style="font-size:24px;"><span class="required">*</span></td>
				</tr>
				<tr>
					<td>验证码</td>
					<td style="height:29px;"><input name="checkCode"  size="4" maxlength="4" value="" style="font-size:24px;" title="不分大小写"><span class="required">*</span><img src="${pageContext.request.contextPath}/checkCode" title="点击刷新" alt="点击刷新"  class="passCode" onclick="this.src=this.src+'?'+Math.random();" id="theImg"><a href="#" onclick="refreshCode('theImg');">看不清？点击刷新！</a></td>
				</tr>					
				<tr>
					<td colspan="2" align="center" class="center"><input type="submit" value="确定"> <input type="reset" value="重填"></td>
				</tr>																							
			</table>			
			</form>
			<br>
			<a href="${pageContext.request.contextPath}/toAddProduct">添加商品信息</a>
		</div>
	</div>
	${theMessage}
</body>
</html>