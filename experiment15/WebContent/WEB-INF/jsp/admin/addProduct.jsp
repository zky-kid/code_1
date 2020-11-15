<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>添加商品</title>
<link href="${pageContext.request.contextPath}/css/myCSS.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/common.js"></script>
<script type="text/javascript">
function checkValid(theForm){	
	var theName=theForm.name, theNameV=theName.value.trim();
	var thePrice=theForm.price, thePriceV=thePrice.value.trim();
	var theCheckCode=theForm.checkCode, theCheckCodeV=theCheckCode.value.trim(), theLengthRequired=4;
	if(theNameV==""){
		alert("商品名称不能为空！");
		theName.select();
	} else if(thePriceV=="" || isNaN(thePriceV) || thePriceV < 0){
		alert("价格必须是非负实数！");
		thePrice.select();		
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
		<div style="width:900px; display:block;margin:0px auto;">
			<div class="pageTitle">添加第<span class="strong">${requestScope.productsTotal+1 }</span>个商品</div>
			<form action="${pageContext.request.contextPath}/admin/addProduct" method="post" onsubmit="return checkValid(this);">
			<table align="center">
				<tr>
					<td class="right"><span class="required">*</span>名称</td><td><input name="name"></td>
				</tr>
				<tr>
					<td class="right"><span class="required">*</span>价格</td><td style="text-align:left;"><input name="price" size="5"></td>
				</tr>				
				<tr>
					<td class="right"><span class="required">*</span>验证码</td>
					<td><input name="checkCode"  size="6" maxlength="4" class="checkCodeInput"><span class="required">*</span><img src="${pageContext.request.contextPath}/checkCode" title="点击刷新" alt="点击刷新"  class="passCode" style="height:26px;cursor:pointer;" onclick="this.src=this.src+'?'+Math.random();"></td>
				</tr>					
				<tr>
					<td colspan="2" class="center"><input type="submit" value="确定"class="btn"> <input type="reset" value="重填" class="btn"></td>
				</tr>																							
			</table>			
			</form>
			<br>
			<a href="${pageContext.request.contextPath}/admin/adminMain">管理员首页</a> <a href="${pageContext.request.contextPath}/toFindProduct">查询商品</a> <a href="${pageContext.request.contextPath}/admin/findAllProducts" title="浏览、修改和删除商品">商品改删</a>
		</div>
	</div>
	${theMessage}
</body>
</html>