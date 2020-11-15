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
function processChange(theO, theDisplayID, theHiddenID){
	if(theO.checked){
		/*
		document.getElementById(theDisplayID).style.visibility="visible";
		document.getElementById(theHiddenID).style.visibility="hidden";
		*/
		
		document.getElementById(theDisplayID).style.display="block";
		document.getElementById(theHiddenID).style.display="none";
	}
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
					<td>查询类型</td>
					<td>
						【<input type="radio" value="0" name="searchType" checked="checked" onchange="processChange(this, 'searchType0', 'searchType1')"/>精确】
						【<input type="radio" value="1" name="searchType" onchange="processChange(this, 'searchType1', 'searchType0')"/>模糊】
					</td>
				</tr>
				<tr id="searchType0">
					<td>精确</td><td>编号：<input name="id" style="font-size:24px;" size="5"><span class="required">*</span></td>
				</tr>				
				<tr id="searchType1" style="display:none;">
					<td>模糊</td>
					<td>
						名称：<input name="name" style="font-size:15px;"><br><br>
						价格范围：【最小值：<input name="priceMin" value="0" size="5"/>；最大值：<input name="priceMax" size="5"/>】
					</td>
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
			<a href="${pageContext.request.contextPath}/toAddProduct">添加商品信息</a> <a href="${pageContext.request.contextPath}/findAllProducts">浏览商品</a>
		</div>
	</div>
	${theMessage}
</body>
</html>