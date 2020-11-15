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
	var theCheckCode=theForm.checkCode, theCheckCodeV=theCheckCode.value.trim(), theLengthRequired=4;
	if(theCheckCodeV=="" || theCheckCodeV.length < theLengthRequired){
		alert("验证码的位数必须是"+theLengthRequired);
		theCheckCode.select();	
		return false;
	}
	if(document.getElementById("findById").checked==true){ // 根据id查商品    if(theForm.searchType.value=="0"){  这样写是错的。
		var theId=theForm.id, theIdV=theId.value.trim();
		if(theIdV=="" || isNaN(theIdV) || theIdV.indexOf(".")!=-1){
			alert("商品编号必须是非空的非负整数！");
			theId.select();
			return false;
		} else{
			return true;
		}
	} else{ // 模糊查询
		var priceMinO=theForm.priceMin, priceMinV = priceMinO.value.trim();
		var priceMaxO=theForm.priceMax, priceMaxV = priceMaxO.value.trim();
		
		if((priceMinV!="" && priceMaxV !="") && (isNaN(priceMinV) || isNaN(priceMaxV) || priceMinV > priceMaxV)){
			alert("价格的最小值、最大值非空时必须是非负数并且最小值小于等于最大值！");
			return false;
		} else {
			return true;
		}
	}
}	
function refreshCode(oStr){
	var theImgO = document.getElementById(oStr);
	theImgO.src = theImgO.src+'?'+Math.random();
}
function processChange(theO, theTypeShowID, theTypeInfo, theDisplayID, theHiddenID){
	if(theO.checked){
		/*
		document.getElementById(theDisplayID).style.visibility="visible";
		document.getElementById(theHiddenID).style.visibility="hidden";
		*/
		document.getElementById(theTypeShowID).innerHTML=theTypeInfo;
		document.getElementById(theDisplayID).style.display="block";
		document.getElementById(theHiddenID).style.display="none";
	}
}
</script>
<style>
	.passCode{
		cursor:pointer; 
	}
	#searchTypeInfo{
		font-weight:bold;
		color:#800000;
	}
</style>

</head>
<body>
	<div style="text-align:center;">
		<div style="width:900px; display:block; margin:0px auto;">
			<div class="pageTitle">查询商品信息</div>
			<form action="${pageContext.request.contextPath}/findProducts" method="post" onsubmit="return checkValid(this);">
			<table align="center">
				<tr>
					<td>查询类型</td>
					<td>
						【<input type="radio" value="0" name="searchType" id="findById" onchange="processChange(this, 'searchTypeInfo', '精确', 'searchType0', 'searchType1')"/>精确】
						【<input type="radio" value="1" name="searchType"  checked="checked" onchange="processChange(this, 'searchTypeInfo', '模糊', 'searchType1', 'searchType0')"/>模糊】
					</td>
				</tr>
				<tr>
					<td id="searchTypeInfo">精确</td>
					<td style="padding:2px 0px;">					
						<span id="searchType1">
							名称：<input name="name" style="font-size:15px;"><br>
							价格范围：【最小值：<input name="priceMin" value="0" size="5">；最大值：<input name="priceMax" size="5">】<br>						
							
						</span>
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