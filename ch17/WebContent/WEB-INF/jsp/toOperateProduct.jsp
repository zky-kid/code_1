<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="myUtils" class="com.javaee.ch17.utils.MyUtils"/>
<c:set var="theProduct" value="${requestScope.product }" scope="page"/> 
<c:set var="theListCategories" value="${requestScope.listCategories }" scope="page"/>  
<c:set var="theProductId" value="${theProduct.id}" scope="page"/> 
<c:if test="${theProductId==null }">
	<c:set var="theProductId" value="0" scope="page"/>
</c:if>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>添加或更新商品</title>
<link href="${pageContext.request.contextPath}/css/myCSS.css" rel="stylesheet">
	<%-- 
	<script src="${pageContext.request.contextPath}/plugins/ckeditor/ckeditor.js"></script>
	<script src="${pageContext.request.contextPath}/js/useCKEditor.js"></script>  
	--%>
	<script src="${pageContext.request.contextPath}/js/jquery-3.4.1.min.js"></script>
	<script src='${pageContext.request.contextPath}/plugins/My97DatePicker/WdatePicker.js'></script>
	<script>
		function prepare(theOId1, theOId2){// 主要是将未另设置时间的元素的value设置成当前时间。
			if($("#"+theOId1).val().trim()==""){
				//alert("是空！");
				//$("#"+theOId).val(new Date()); 经试验：JavaScript的Date格式，并不能直接被绑定到java.util.Date的属性上，这样也不安全、不合理。
				//因万一客户端的系统时间被随意改了，就导致默认空时并不是当前时间。所以，还是将这个元素不提交。
				$("#"+theOId1).attr("disabled", true);
			} else{
				$("#"+theOId1).attr("disabled", false);
			}
			$("#"+theOId2).attr("disabled", true);
		}
		function prepareUpdate(theOId1, theOId2){
			prepare(theOId1, theOId2);
		}
		function prepareInsert(theOId1, theOId2){
			prepare(theOId1, theOId2);
			$("#theId").val(0);			
		}	
		/*
		function init(){
			$("#theCategoryId").val(${theProductId });	
		}
		window.onload=init;
		*/
		$(function(){
			if($("#theId").val()!=0){
				//alert("!=0");  // OK
				//$("#theCategoryId").val(${theProduct.category.id});
				var theUpdatedCategoryId = ${theProduct.category.id+""}; // "" + ${theProduct.category.id} 在无类别号就是不对的。
				$("#theCategoryId").val(theUpdatedCategoryId);
			}
			
		});
	</script>
</head>
<body>
	<div style="width:900px; margin: 0px auto;">
		<h2 style="text-align:center;">添加或更新商品</h2>
		<form action="${pageContext.request.contextPath}/operateProduct" method="post" onsubmit="return checkValid(this);">
			<input type="hidden" value="${theProductId }" name="id" id="theId">			
			<table align="center">
				<tr>
					<th>名称</th><td><input type="text" name="name" value="${theProduct.name}" id="theName"></td>
				</tr>
				<tr>
					<th>价格</th><td><input type="text" name="price" value="${theProduct.price}" id="thePrice"></td>
				</tr>
				<tr>
					<th>类别</th>
					<td>
						<select id="theCategoryId" name="category.id">
						<c:forEach items="${theListCategories}" var="category">
							<option value="${category.id}">${category.name}</option>						
						</c:forEach>
						</select>
					</td>
				</tr>
			<c:if test="${theProductId==0}"> <%-- 添加，逻辑是：让用户有机会输入 “录入时间”，而“修改时间”则直接定为“无”  --%>
				<tr>
					<th>录入时间</th>						
					<td>
						<input type="text" readonly='readonly' name='entryTime' id="theEntryTime" class="Wdate" size="20" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd  HH:mm:ss', maxDate:'%y-%M-%d %H:%m:%s'})" /> 注：留空表示使用实时时间
					</td>
				</tr>
				<tr>
					<th>修改时间</th><td>无</td>
				</tr>								
			</c:if> 					
			<c:if test="${theProductId>0}">  <%-- 更新，逻辑是：让用户有机会修改“修改时间”， 而“录入时间”直接显示即可。  --%>
				<tr>
					<th>录入时间</th>						
					<td>
						原：${myUtils.getDateTimeString(product.entryTime, 1)}<br>
						新：<input type="text" readonly='readonly' name='entryTime' id="theEntryTime" value="" class="Wdate" size="20" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd  HH:mm:ss', maxDate:'%y-%M-%d %H:%m:%s'})" /> 注：留空表示使用实时时间
					</td>
				</tr>
				<tr>
					<th>修改时间</th>
					<td>
						原：${myUtils.getDateTimeString(product.modifyTime, 1)}<br>
						新：<input type="text" readonly='readonly' name='modifyTime' id="theModifyTime" class="Wdate" size="20" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd  HH:mm:ss', maxDate:'%y-%M-%d %H:%m:%s'})" /> 注：留空表示使用实时时间
					</td>
				</tr>								
			</c:if> 
				<%--
				// 暂时不用验证码
				<tr>
					<th>验证码</td>
					<td><input name="checkCode" class="checkCodeInput"  size="4" maxlength="4"><img src="${pageContext.request.contextPath}/checkCode" title="点击刷新" alt="点击刷新"  class="passCode" style="height:26px;cursor:pointer;" onclick="this.src=this.src+'?'+Math.random();"></td>
				</tr>				
				
				 --%>
	
				<tr>
					<td colspan="2" align="center" class="center">					
					<c:if test="${theProductId>0}">
						<button type="submit" onclick="prepareUpdate('theModifyTime', 'theEntryTime');">更新id为“<span class="strong">${theProductId }</span>”的商品信息</button> 
					</c:if>
						<button type="submit" onclick="prepareInsert('theEntryTime', 'theModifyTime');">添加新的商品信息</button>  <input type="reset" value="重填">
					</td>
				</tr>																														
			</table>
		</form>
		<hr>
		<div style="text-align:center;">
			<a href="${pageContext.request.contextPath}/findProducts">浏览商品信息</a> <a href="${pageContext.request.contextPath}/toFindProductById">查询商品信息</a>
			<br>${requestScope.theMessage }		
		</div>

	</div>
</body>
</html>
<script>
	
</script>