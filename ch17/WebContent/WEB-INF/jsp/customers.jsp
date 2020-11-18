<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="myUtils" class="com.javaee.ch17.utils.MyUtils"/>
<c:set var="thePageMsg" value="${requestScope.pageMsg}" scope="page"/>
<c:set var="theListCustomers" value="${thePageMsg.lists}" scope="page"/>
<c:set var="theCurrentPage" value="${thePageMsg.currPage}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>客户列表信息</title>
<link href="${pageContext.request.contextPath}/css/myCSS.css" rel="stylesheet">
</head>
<body>
	<div style="width:1200px; margin:0px auto;">
		<h2 style="text-align:center">客户会员列表信息</h2>
		<%--
		对于返回单个实体型的结果集：如有零行记录，则是null。但对于返回List<实体型>这样的结果集：
		当找到的结果集有零行记录时，theListCustomers不是null，是含0个元素的List，并不是不存在(null)。所以下面的判断达不到判断有无结果的效果。
		<c:if test="${theListCustomers==null }"><div style="text-align:center">无会员信息</div></c:if>
		<c:if test="${theListCustomers!=null }">
		而应通过如下这种方式(List类型的size()方法返回值是否为零来判断结果集的行数是否为零)：	
		<c:if test="${theListCustomers.size()==0}"><div style="text-align:center">无会员信息</div></c:if>
		<c:if test="${theListCustomers.size()>0}">			
		 --%>
		<c:set var="theResultSize" value="${theListCustomers.size()}" scope="page"/>
		<c:if test="${theResultSize==0}"><div style="text-align:center">无会员信息</div></c:if>
		<c:if test="${theResultSize>0}">
			<c:set var="thePageIndexStart" value="${(theCurrentPage-1)*thePageMsg.pageSize }"/>
			<table align="center">
				<tr>
					<th>总序号</th><th>页内序号</th><th>编号</th><th>用户名<th>真名</th><th>性别</th><th>证件信息</th><th>邮箱</th><th>电话</th><th>创建时间</th><th>详细</th><th>修改</th><th>删除</th>
				</tr>
			<c:forEach items="${theListCustomers }" var="customer" varStatus="theStatus" >
				<c:set var="theId" value="${customer.id}" scope="page"/> <%-- 为避免重复取从而提高效率，将常用的量设置成变量theId，--%>
				<c:set var="theIndex" value="${theStatus.index}" scope="page"/>
				<tr>
					<td>${thePageIndexStart+theIndex+1}</td>				
					<td>${theIndex+1}</td>	
					<td>${theId}</td>
					<td>${customer.userName}</td>
					<td>${customer.userRealName}</td>
					<td>${customer.gender eq '0' ? '男' : '女'}</td>
					<td>${customer.card.cardType} ${customer.card.cardNo}</td>
					<td>${customer.email}</td>
					<td>${customer.contactPhone}</td>
					<td>${myUtils.getDateTimeString(customer.creationTime, 2)}</td>
					<td class="operate"><a href="${pageContext.request.contextPath}/customerDetail?id=${theId}">详细</a></td>
					<td class="operate"><a href="${pageContext.request.contextPath}/toUpdateCustomer?id=${theId}">修改</a></td>
					<td class="operate"><a href="${pageContext.request.contextPath}/deleteCustomer?id=${theId}" onclick="return confirm('确定要删除？');">删除</a></td>
				</tr>
		    </c:forEach>
			</table>
			<div class="center">本页共有<span class="strong">${theResultSize}</span>条会员记录</div>
		<br>
		<table  border="0" cellspacing="0" cellpadding="0" align="center">
			<tr>
			<td class="td2">
			   <span>第${theCurrentPage }/ ${thePageMsg.totalPage}页</span>&nbsp;&nbsp;
			   <span>总记录数：${thePageMsg.totalCount }&nbsp;&nbsp;每页:${thePageMsg.pageSize}</span>&nbsp;&nbsp;
			   <span>
			       <c:if test="${theCurrentPage > 1}">
			           <a href="${pageContext.request.contextPath }/findCustomers?currentPage=1">[首页]</a>&nbsp;&nbsp;
			           <a href="${pageContext.request.contextPath }/findCustomers?currentPage=${theCurrentPage-1}">[上一页]</a>&nbsp;&nbsp;
			       </c:if>
			
			       <c:if test="${theCurrentPage < thePageMsg.totalPage}">
			           <a href="${pageContext.request.contextPath }/findCustomers?currentPage=${theCurrentPage+1}">[下一页]</a>&nbsp;&nbsp;
			           <a href="${pageContext.request.contextPath }/findCustomers?currentPage=${thePageMsg.totalPage}">[尾页]</a>&nbsp;&nbsp;
			       </c:if>
			   </span>
			</td>
			</tr>
		</table><br>			
		</c:if>
		<div style="text-align:center; margin-top:10px;">
			<hr style="width:50%;">
			<a href="${pageContext.request.contextPath}/">首页</a> <a href="${pageContext.request.contextPath}/toFindCustomerByIdOrSomeCustomers">继续查询会员信息</a> <a href="${pageContext.request.contextPath}/toInsertCustomer">添加会员</a>
		</div>
		${requestScope.theMessage }
	</div>
</body>
</html>
<!-- 
<c:if test="${requestScope.customer.gender=='0' }">男</c:if><c:if test="${requestScope.customer.gender=='1' }">女</c:if> ${customer.gender eq '0' ? '男' : '女'} <br>

<td class="center"><a href="${pageContext.request.contextPath }/showAProductById?id=${theId}" class="forms-btn">详细</a></td>
 -->