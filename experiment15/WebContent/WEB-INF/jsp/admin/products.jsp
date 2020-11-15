<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品信息</title>
<link href="${pageContext.request.contextPath}/css/myCSS.css" rel="stylesheet">
<style>

</style>
</head>
<body>
<c:choose>
    <c:when test="${productsList==null}">
        无商品信息
    </c:when>
    <c:otherwise>
		<div class="pageTitle">管理员浏览商品信息</div>
		<form action="${pageContext.request.contextPath }/admin/editProducts" method="post" id='editProductsFormID' onsubmit="return checkValid(this)">
		<table border=1 align="center">
			<tr>
				<td>选择</td><td>序号</td><td>编号</td><td>商品名<td>价格</td><td>查看</td><td>单个修改</td><td>单个删除</td>
			</tr>
		<c:forEach items="${productsList }" var="product" varStatus="theStatus" >
			<c:set var="theId" value="${product.id}" scope="page"/> <%-- 为避免重复取从而提高效率，将常用的量设置成变量theId，--%>
			<c:set var="theIndex" value="${theStatus.index}" scope="page"/>
			<tr onmouseover="changeStyle(this,'bgcMouseOver')" onmouseout="changeStyle(this, 'bgcMouseOut')">
				<td class="center"><input name="products[${theIndex}].id" id="id_${theIndex}" value="${theId}" type="checkbox" onclick="processClick(this, ${theIndex})"></td>
				<td>${theIndex+1}</td>
				<td>${theId}</td>
				<td><input name="products[${theIndex}].name" id="name_${theIndex}" value="${product.name}" disabled="disabled"></td>
				<td><input name="products[${theIndex}].price" id="price_${theIndex}" value="${product.price}" disabled="disabled"></td>
				<td class="center"><a href="${pageContext.request.contextPath }/showAProductById?id=${theId}" class="forms-btn">详细</a></td>
				<td class="center"><a href="${pageContext.request.contextPath }/admin/showAProductByIdForEdit?id=${theId}">修改</a></td>
				<td class="center"><a href="${pageContext.request.contextPath }/admin/deleteAProductById?id=${theId}">删除</a></td>	
			</tr>        
	    </c:forEach>
			<tr>
				<td colspan="8" >
					<input type="hidden" id="totalShownCheckBoxesForRepeat" value="${theIndex}">
					<button type="button" onclick="selectAll('id_')" class="btn">全选</button> <button  type="button" onclick="selectReverse('id_')" class="btn">反选</button>
				</td>
			</tr>
	    	<tr>
	    		<td colspan="8">
	    			已选中<span class="dynamicNumber" id="showSelected">0</span>个商品
	    			<input type="hidden" id="pressButtonFlag" value="0">
	    			<input type="hidden" name="editType" id="editType" value="">
	    			<button type="button" id="btnDeletes" onclick="processBatchOper('editType','del');" disabled="disabled" class="btn">批量删除</button> <button type="button" id="btnUpdates" onclick="processBatchOper('editType','upd');" disabled="disabled" class="btn">批量更新</button>
	    			 
	    		</td>
	    	</tr>
	    	
		</table>
		</form>    
    </c:otherwise>
</c:choose>
<div align="center"><a href="${pageContext.request.contextPath}/admin/adminMain">管理员首页</a> <a href="${pageContext.request.contextPath}/toFindProduct">查询商品</a> <a href="${pageContext.request.contextPath}/admin/toAddProduct">添加商品</a></div>
</body>
</html>
<%-- 为了便于批量修改操作提交前能对列出的输入框元素格式验证，一步到位的方式就是将这些输入框的是否可编辑交由所在行的复选框点击事件来控制。
用这个方法后，复选框未选的所在行(对应一个实体)就不会被提交。这样后台得到的实体个数就是实际勾选的那些，而不会统统提交(后台还要过滤一遍)。
 --%>
 <%--
 经实验，
<button type="submit" id="btnUpdates" onclick="processBatchOper('editType','upd');" disabled="disabled">批量更新</button>
<button type="submit" id="btnDeletes" onclick="processBatchOper('editType','del');" disabled="disabled">批量删除</button> 
当焦点在表单中的某个元素时，不按这两个按钮(type="submit")即按回车时，哪个排在前面就默认激发这个提交按钮的点击事件。
  --%>
<script>
	var theSelectedCheckBoxes=0;
	var theDynamicTextShowO = document.getElementById("showSelected");
	var theButtonDeletes=document.getElementById("btnDeletes"), theButtonUpdates=document.getElementById("btnUpdates");
	var totalShownCheckBoxesForRepeatV=parseInt(document.getElementById("totalShownCheckBoxesForRepeat").value);
	var pressButtonFlagO = document.getElementById("pressButtonFlag");
	
	function processDynamicSelect(){
		theDynamicTextShowO.innerHTML=theSelectedCheckBoxes;
		if(theSelectedCheckBoxes>0){
			theButtonDeletes.disabled=false;
			theButtonUpdates.disabled=false;
		} else {
			theButtonDeletes.disabled=true;
			theButtonUpdates.disabled=true;	
			pressButtonFlagO.value="0";
		}
	}
	function changeStyle(theO, styleName){
		theO.className=styleName;
	}
	function processClick(theO, theIndex){
		if(theO.checked==true){
			theSelectedCheckBoxes++;
			document.getElementById("name_"+theIndex).disabled=false;
			document.getElementById("price_"+theIndex).disabled=false;
		} else{
			theSelectedCheckBoxes--;
			document.getElementById("name_"+theIndex).disabled=true;
			document.getElementById("price_"+theIndex).disabled=true;			
		}
		//theDynamicTextShowO.value="删除<span class='dynamicNumber'>" + theSelectedCheckBoxes + "</span>个会员"; // 经验证样式无法在提交按钮的value属性上起作用(被原样地显示了)
		//theDynamicTextShowO.innerHTML=theSelectedCheckBoxes;
		processDynamicSelect();
	}
	function selectAll(idPrefix){
        
        for(var i=0; i<= totalShownCheckBoxesForRepeatV;i++){
        	document.getElementById(idPrefix+i).checked=true;        	
        }
        theSelectedCheckBoxes=totalShownCheckBoxesForRepeatV+1;
        //theDynamicTextShowO.innerHTML=theSelectedCheckBoxes;
        processDynamicSelect();
        //return false;
	}
	function selectReverse(idPrefix){
		for(var i=0; i<= totalShownCheckBoxesForRepeatV;i++){
        	var theO = document.getElementById(idPrefix+i);
        	//theO.checked=!theO.checked;//这句虽可实现反选，但并未同步更新被选中的个数 所以要改
        	if(theO.checked){ // 先前已被选中 反选意味着 要变成 未选 状态 同时被选中的个数减去1
        		theSelectedCheckBoxes--;
        	} else{ // 先前未被选中，反选就意味着 要变成选中 状态，同时被选中的个数加1
        		theSelectedCheckBoxes++;
        	}
        	theO.checked=!theO.checked;       	
        }
        //theDynamicTextShowO.innerHTML=theSelectedCheckBoxes;
        processDynamicSelect();
        //return true;
	}
	var myForm = document.getElementById("editProductsFormID");
	function processBatchOper(editTypeId, operateFlag){
		pressButtonFlagO.value="1"; //表示按了“批量删除”、"批量修改"任一按钮。
		document.getElementById(editTypeId).value=operateFlag;
		if(checkValid(myForm))
			myForm.submit();// 注：这个submit()一旦执行，就绕过了onsubmit()事件。所以在submit()之前，先显式执行验证表单。
	}
	function checkValid(theForm){
		//alert("表单提交时："+pressButtonFlagO.value);
		if(pressButtonFlagO.value=="0"){
			alert("必须通过点击按钮提交！");
			return false;
		}
		if(theSelectedCheckBoxes==0){
			alert("提交前至少要选一个！");
			pressButtonFlagO.value="0";
			return false;
		} else{
			var operType=document.getElementById("editType").value, operTypeInfo;
			//var operTypeInfo = operType=="del"?"删除":"修改";
			if(operType=="del"){
				operTypeInfo="删除";
			} else{
				var theNameO, thePriceO;
				var theNameV, thePriceV;
				for(var i=0; i<= totalShownCheckBoxesForRepeatV;i++){
		        	if(document.getElementById("id_"+i).checked==true){
		        		theNameO=document.getElementById("name_"+i); theNameV=theNameO.value.trim();
		        		thePriceO=document.getElementById("price_"+i); thePriceV=thePriceO.value.trim();
		        		if(theNameV==""){
		        			alert("商品名称不能为空！");
		        			theNameO.select();
		        			pressButtonFlagO.value="0";
		        			return false;
		        		} else if(thePriceV=="" || isNaN(thePriceV) || thePriceV < 0){
		        			alert("价格必须是非负实数！");
		        			thePriceO.select();	
		        			pressButtonFlagO.value="0";
		        			return false;
		        		}		        		
		        	}        	
		        }				
				operTypeInfo="修改";
			}
			
			return confirm("确定要批量"+operTypeInfo+"选中的" + theSelectedCheckBoxes + "个商品信息吗？");
		}
		
	}
</script>
<%-- 

<c:if test="${requestScope.customer.gender=='0' }">男</c:if><c:if test="${requestScope.customer.gender=='1' }">女</c:if> ${customer.gender eq '0' ? '男' : '女'} <br>

<c:if test="${productsList==null }">无商品信息</c:if>
<c:if test="${productsList!=null }">
....
</c:if>  这样写有点重复。
jstl标签库，没有c:else。此时可改用如下的c:choose标签

<c:choose>
　　<c:when test="${condition1}">
　　       condition1为true
　　</c:when>
　　<c:when test="${ condition2}">
    　　condition2为true
　　</c:when>
　　<c:otherwise>
　   　condition1和condition2都为false
　　</c:otherwise>
</c:choose> 



 --%>