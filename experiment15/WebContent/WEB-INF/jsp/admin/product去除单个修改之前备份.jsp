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
		<div class="pageTitle">商品信息</div>
		<form action="${pageContext.request.contextPath }/editProducts" method="post" id='editProductsFormID'>
		<table border=1 align="center">
			<tr>
				<td>选择</td><td>序号</td><td>编号</td><td>商品名<td>价格</td><td>查看</td><td>单个修改</td><td>单个删除</td>
			</tr>
		<c:forEach items="${productsList }" var="product" varStatus="theStatus" >
			<c:set var="theId" value="${product.id}" scope="page"/> <%-- 为避免重复取从而提高效率，将常用的量设置成变量theId，--%>
			<c:set var="theIndex" value="${theStatus.index}" scope="page"/>
			<tr onmouseover="changeStyle(this,'bgcMouseOver')" onmouseout="changeStyle(this, 'bgcMouseOut')">
				<td><input name="products[${theIndex}].id" id="product${theIndex}" value="${theId}" type="checkbox" onclick="processClick(this)"></td>
				<td>${theIndex+1}</td>
				<td>${theId}</td>
				<td><input name="products[${theIndex}].name" value="${product.name}"></td>
				<td><input name="products[${theIndex}].price" value="${product.price}"></td>
				<td class="center"><a href="${pageContext.request.contextPath }/showAProductById?id=${theId}">详细</a></td>
				<td class="center"><a href="${pageContext.request.contextPath }/updateAProductById?id=${theId}">修改</a></td>
				<td class="center"><a href="${pageContext.request.contextPath }/deleteAProductById?id=${theId}">删除</a></td>	
			</tr>        
	    </c:forEach>
			<tr>
				<td colspan="8" >
					<input type="hidden" id="totalShownCheckBoxesForRepeat" value="${theIndex}">
					<button type="button" onclick="selectAll('product')">全选</button> <button  type="button" onclick="selectReverse('product')">反选</button>
				</td>
			</tr>
	    	<tr>
	    		<td colspan="8">
	    			已选中<span class="dynamicNumber" id="showSelected">0</span>个商品<input type="hidden" name="editType" id="editType" value="">
	    			<button type="submit" id="btnDeletes" onclick="processBatchOper('editType','del');" disabled="disabled">批量删除</button> <button type="submit" id="btnUpdates" onclick="processBatchOper('editType','upd');" disabled="disabled">批量更新</button>
	    		</td>
	    	</tr>
	    	
		</table>
		</form>    
    </c:otherwise>
</c:choose>
<div align="center"><a href="${pageContext.request.contextPath}/toFindProduct">查询商品</a> <a href="${pageContext.request.contextPath}/toAddProduct">添加商品</a></div>
</body>
</html>
<script>
	var theSelectedCheckBoxes=0;
	var theDynamicTextShowO = document.getElementById("showSelected");
	var theButtonDeletes=document.getElementById("btnDeletes"), theButtonUpdates=document.getElementById("btnUpdates");
	var totalShownCheckBoxesForRepeatV=parseInt(document.getElementById("totalShownCheckBoxesForRepeat").value);
	function processDynamicSelect(){
		theDynamicTextShowO.innerHTML=theSelectedCheckBoxes;
		if(theSelectedCheckBoxes>0){
			theButtonDeletes.disabled=false;
			theButtonUpdates.disabled=false;
		} else {
			theButtonDeletes.disabled=true;
			theButtonUpdates.disabled=true;			
		}
	}
	function changeStyle(theO, styleName){
		theO.className=styleName;
	}
	function processClick(theO){
		if(theO.checked==true){
			theSelectedCheckBoxes++;
		} else{
			theSelectedCheckBoxes--;
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
	function processBatchOper(editTypeId, operateFlag){
		document.getElementById(editTypeId).value=operateFlag;
	}
	function checkValid(theForm){
		if(theSelectedCheckBoxes==0){
			alert("提交前至少要选一个！");
			return false;
		} else{
			var operType=document.getElementById("editType").value=="del"?"删除":"修改";
			return confirm("确定要批量"+operType+"选中的" + theSelectedCheckBoxes + "个商品信息吗？");
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