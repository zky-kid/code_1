<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="thePageMsg" value="${requestScope.pageMsg}" scope="page"/>
<c:set var="theCustomersList" value="${thePageMsg.lists}" scope="page"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>会员信息</title>
<link href="${pageContext.request.contextPath}/css/myCSS.css" rel="stylesheet">
<style>

</style>
</head>
<body>
<c:choose>
    <c:when test="${theCustomersList==null}">
        无会员信息
    </c:when>
    <c:otherwise>
		<div class="pageTitle">管理员浏览会员信息</div>
		<c:set var="theCurrentPage" value="${thePageMsg.currPage}" scope="page"/>
		<c:set var="thePageIndexStart" value="${thePageMsg.pageSize*(theCurrentPage-1)}" scope="page"/>
		<form action="${pageContext.request.contextPath }/admin/editCustomers" method="post" id='editCustomersFormID' onsubmit="return checkValid(this)">
		<input name="currentPage" value="${theCurrentPage}" type="hidden">
		<table border=1 align="center">
			<tr>
				<td>选择</td><td>序号</td><td>编号</td><td>用户名<td>真名<td>联系电话</td><td>查看</td><td>单个删除</td>
			</tr>
		<c:forEach items="${theCustomersList }" var="customer" varStatus="theStatus" >
			<c:set var="theId" value="${customer.id}" scope="page"/> <%-- 为避免重复取从而提高效率，将常用的量设置成变量theId，--%>
			<c:set var="theIndex" value="${theStatus.index}" scope="page"/>
			<tr onmouseover="changeStyle(this,'bgcMouseOver')" onmouseout="changeStyle(this, 'bgcMouseOut')">
				<td class="center"><input name="ids" id="id_${theIndex}" value="${theId}" type="checkbox" onclick="processClick(this, ${theIndex})"></td>
				<td>${thePageIndexStart+theIndex+1}</td>
				<td>${theId}</td>
				<td>${customer.userName}</td>
				<td>${customer.userRealName}</td>
				<td>${customer.contactPhone}</td>
				<td class="center"><a href="${pageContext.request.contextPath }/admin/showACustomerById?id=${theId}&currentPage=${theCurrentPage}" class="forms-btn">详细</a></td>
				<td class="center"><a href="${pageContext.request.contextPath }/admin/deleteACustomerById?id=${theId}&currentPage=${theCurrentPage}">删除</a></td>	
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
	    			已选中<span class="dynamicNumber" id="showSelected">0</span>个会员
	    			<input type="hidden" id="pressButtonFlag" value="0">
	    			<input type="hidden" name="editType" id="editType" value="">
	    			<button type="button" id="btnDeletes" onclick="processBatchOper('editType','del');" disabled="disabled" class="btn">批量删除</button>
	    			 
	    		</td>
	    	</tr>	    	
		</table>
		
		
		</form> 
		<br>
		<table  border="0" cellspacing="0" cellpadding="0" align="center">
			<tr>
			<td class="td2">
			   <span>第${theCurrentPage }/ ${thePageMsg.totalPage}页</span>&nbsp;&nbsp;
			   <span>总记录数：${thePageMsg.totalCount }&nbsp;&nbsp;每页:${thePageMsg.pageSize}</span>&nbsp;&nbsp;
			   <span>
			       <c:if test="${theCurrentPage > 1}">
			           <a href="${pageContext.request.contextPath }/admin/findCustomers?currentPage=1">[首页]</a>&nbsp;&nbsp;
			           <a href="${pageContext.request.contextPath }/admin/findCustomers?currentPage=${theCurrentPage-1}">[上一页]</a>&nbsp;&nbsp;
			       </c:if>
			
			       <c:if test="${theCurrentPage < thePageMsg.totalPage}">
			           <a href="${pageContext.request.contextPath }/admin/findCustomers?currentPage=${theCurrentPage+1}">[下一页]</a>&nbsp;&nbsp;
			           <a href="${pageContext.request.contextPath }/admin/findCustomers?currentPage=${thePageMsg.totalPage}">[尾页]</a>&nbsp;&nbsp;
			       </c:if>
			   </span>
			</td>
			</tr>
		</table><br>
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
	var theButtonDeletes=document.getElementById("btnDeletes")
	var totalShownCheckBoxesForRepeatV=parseInt(document.getElementById("totalShownCheckBoxesForRepeat").value);
	var pressButtonFlagO = document.getElementById("pressButtonFlag");
	
	function processDynamicSelect(){
		theDynamicTextShowO.innerHTML=theSelectedCheckBoxes;
		if(theSelectedCheckBoxes>0){
			theButtonDeletes.disabled=false;
			
		} else {
			theButtonDeletes.disabled=true;			
			pressButtonFlagO.value="0";
		}
	}
	function changeStyle(theO, styleName){
		theO.className=styleName;
	}
	function processClick(theO, theIndex){
		if(theO.checked==true){
			theSelectedCheckBoxes++;
		} else{
			theSelectedCheckBoxes--;					
		}
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
	var myForm = document.getElementById("editCustomersFormID");
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

			}			
			return confirm("确定要批量"+operTypeInfo+"选中的" + theSelectedCheckBoxes + "个会员信息吗？");
		}
		
	}
</script>