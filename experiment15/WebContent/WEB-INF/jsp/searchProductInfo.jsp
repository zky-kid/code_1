<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>查询商品信息</title>
<link href="${pageContext.request.contextPath}/css/myCSS.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/common.js"></script>
<script src='${pageContext.request.contextPath}/plugin/My97DatePicker/WdatePicker.js'></script>
<script type="text/javascript">
var theMinId = ${requestScope.minAndMax.minIntV}, theMaxId=${requestScope.minAndMax.maxIntV };
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
			theIdVInt = parseInt(theIdV);
			if(theMinId> theIdVInt || theIdVInt > theMaxId){
				alert("已有商品编号的范围：["+theMinId+","+theMaxId+"]！");
				theId.select();
				return false;
			}
			return true;
		}
	} else{ // 模糊查询
		var priceMinO=theForm.priceMin, priceMinV = priceMinO.value.trim();
		var priceMaxO=theForm.priceMax, priceMaxV = priceMaxO.value.trim();
		priceMinO.disabled=(priceMinV=="");
		priceMaxO.disabled=(priceMaxV=="");
		
		var entryTimeBeginO=theForm.entryTimeBegin, entryTimeBeginV=entryTimeBeginO.value;
		var entryTimeEndO=theForm.entryTimeEnd, entryTimeEndV=entryTimeEndO.value;
		var modifyTimeBeginO=theForm.modifyTimeBegin, modifyTimeBeginV=modifyTimeBeginO.value;
		var modifyTimeEndO=theForm.modifyTimeEnd, modifyTimeEndV=modifyTimeEndO.value;		
		entryTimeBeginO.disabled=(entryTimeBeginV=="");
		entryTimeEndO.disabled=(entryTimeEndV=="");	
		modifyTimeBeginO.disabled=(modifyTimeBeginV=="");
		modifyTimeEndO.disabled=(modifyTimeEndV=="");			
		if(priceMinV=="" && priceMaxV==""){ // 价格的最小值、最大值都是空，表示查询时不限定价格。
			return true;
		}
		if(priceMinV!="" && isNaN(priceMinV)){
			alert("价格的最小值非空时，必须是非负数！");
			return false;
		} else if(priceMaxV!="" && isNaN(priceMaxV)){
			alert("价格的最小大值非空时，必须是非负数！");
			return false;
		} else if(priceMinV!="" && priceMaxV!="" && priceMinV > priceMaxV){
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
		document.getElementById(theTypeShowID).innerHTML=theTypeInfo;
		/*
		document.getElementById(theDisplayID).style.visibility="visible";
		document.getElementById(theHiddenID).style.visibility="hidden";
		*/		
		document.getElementById(theDisplayID).style.display="block";
		document.getElementById(theHiddenID).style.display="none";
		if(theO.value=="0"){
			document.getElementById("id").disabled=false;
			document.getElementById("priceMin").disabled=true;
			document.getElementById("priceMax").disabled=true;	
			document.getElementById("entryTimeBeginId").disabled=true;
			document.getElementById("entryTimeEndId").disabled=true;
			document.getElementById("modifyTimeBeginId").disabled=true;
			document.getElementById("modifyTimeEndId").disabled=true;
		} else{
			document.getElementById("id").disabled=true;
			document.getElementById("priceMin").disabled=false;
			document.getElementById("priceMax").disabled=false;	
			document.getElementById("entryTimeBeginId").disabled=false;
			document.getElementById("entryTimeEndId").disabled=false;
			document.getElementById("modifyTimeBeginId").disabled=false;
			document.getElementById("modifyTimeEndId").disabled=false;			
		}

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
						【<input type="radio" value="0" name="searchType" id="findById" checked="checked" onchange="processChange(this, 'searchTypeInfo', '精确', 'searchType0', 'searchType1')"/>精确】
						【<input type="radio" value="1" name="searchType" onchange="processChange(this, 'searchTypeInfo', '模糊', 'searchType1', 'searchType0')"/>模糊】
					</td>
				</tr>
				<tr>
					<td id="searchTypeInfo">精确</td>
					<td style="padding:2px 0px;">
						<span id="searchType0">编号：<input name="id" id="id" style="font-size:24px;" size="5"><span class="required">*</span> 范围：[${requestScope.minAndMax.minIntV}, ${requestScope.minAndMax.maxIntV}]
							<%--
							<input name="priceMin" type="hidden" value="0.0"> <input name="priceMax" type="hidden" value="0.0">
							 --%>
							
						</span>						
						<span id="searchType1" style="display:none;">
							名称：<input name="name" style="font-size:15px;"><br>
							价格范围：【最小值：<input name="priceMin" id="priceMin" value="0" size="5" disabled="disabled">；最大值：<input name="priceMax" id="priceMax" size="5"  disabled="disabled">】<br>
							录入时间：【最小值：<input type="text" readonly='readonly' name='entryTimeBegin' id="entryTimeBeginId" class="Wdate" size="22" disabled="disabled" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss', maxDate:'#F{$dp.$D(\'entryTimeEndId\')}'})" />；最大值：
                <input type="text" readonly='readonly' name='entryTimeEnd' id="entryTimeEndId" class="Wdate" size="22" disabled="disabled" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'entryTimeBeginId\')}', maxDate:'%y-%M-%d %H:%m:%s'})" />】<br>
							修改时间：【最小值：<input type="text" readonly='readonly' name='modifyTimeBegin' id="modifyTimeBeginId" class="Wdate" size="22" disabled="disabled" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss', maxDate:'#F{$dp.$D(\'modifyTimeEndId\')}'})" />；最大值：
                <input type="text" readonly='readonly' name='modifyTimeEnd' id="modifyTimeEndId" class="Wdate" size="22" disabled="disabled" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'modifyTimeBeginId\')}', maxDate:'%y-%M-%d %H:%m:%s'})" />】
						</span>
					</td>
				</tr>				
				<tr>
					<td>验证码</td>
					<td style="height:29px;"><input name="checkCode"  size="4" maxlength="4" class="checkCodeInput"  title="不分大小写"><span class="required">*</span><img src="${pageContext.request.contextPath}/checkCode" title="点击刷新" alt="点击刷新"  class="passCode" onclick="this.src=this.src+'?'+Math.random();" id="theImg"><a href="#" onclick="refreshCode('theImg');">看不清？点击刷新！</a></td>
				</tr>					
				<tr>
					<td colspan="2" class="center"><input type="submit" value="搜索" class="searchBtn"> <input type="reset" value="重填" class="btn"></td>
				</tr>																							
			</table>			
			</form>
			<br>
			<c:if test="${sessionScope.administrator!=null}">
				<a href="${pageContext.request.contextPath}/admin/adminMain">管理员首页</a> <a href="${pageContext.request.contextPath}/admin/toAddProduct">添加商品</a> <a href="${pageContext.request.contextPath}/admin/findAllProducts" title="浏览、修改和删除商品">商品改删</a>
			</c:if>
			<c:if test="${sessionScope.administrator==null}">
				<a href="${pageContext.request.contextPath}/findAllProducts">浏览商品</a>
			</c:if>
			<hr width="50%">
			<a href="${pageContext.request.contextPath}/">系统首页</a>
		</div>
	</div>
	${theMessage}
</body>
</html>
<%--
需注意的是：对于后台请求处理方法中有参数(如是pojo类就是指其属性)是数值型(整数、浮点数)时，提交时对应的这些表单元素的值不能是空或类型不匹配(即使被隐藏了也不行)。
另，如绑定的是pojo型，提交的表单中可以没有，但一旦出现，这些数值型的就一定要有匹配的值(pojo类中属性是字符串时，为空都行；是数值型时，要么表单中无此元素(或disabled为true)，但只要出现了这个同名的表单元素，其值就不能为空)
--%>