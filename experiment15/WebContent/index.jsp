<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品管理系统_首页</title>
<link href="${pageContext.request.contextPath}/css/myCSS.css" rel="stylesheet">
</head>
<body>
	<div style="text-align:center;">
		<div style="width:900px; display:block; margin:0px auto;">
			<div class="pageTitle">系统_首页</div>
			<div style="height:200px;"></div>
			<a href="${pageContext.request.contextPath}/findAllProducts">浏览商品</a> 
<c:choose> <%-- 不考虑一个会话session同时登录了管理员和普通会员 --%>
	<c:when test="${sessionScope.administrator!=null}">
		<a href="${pageContext.request.contextPath}/admin/adminMain">管理员首页</a> <a href="${pageContext.request.contextPath}/admin/loginOut">安全退出</a>
	</c:when>	  
	<c:when test="${sessionScope.customer!=null}">
		<a href="${pageContext.request.contextPath}/customer/customerMain">会员首页</a> <a href="${pageContext.request.contextPath}/customer/loginOut">安全退出</a>
	</c:when>
	<c:otherwise><a href="${pageContext.request.contextPath}/login">登录</a> <a href="${pageContext.request.contextPath}/toRegisterCustomer">会员注册</a></c:otherwise>
</c:choose>
		</div>		
		
	</div>
</body>
</html>
<%--
el逻辑判断   https://www.iteye.com/blog/zccst-1006371
${result['user'].sex eq '1' ? '男' : '女'} 
jstl分支语句 
<c:choose> 
	<c:when test="${result['user'].country eq '1'}">A</c:when> 
	<c:when test="${result['user'].country eq '2'}">B</c:when> 
	<c:when test="${result['user'].country eq '3'}">C</c:when> 
</c:choose> 
-----------------
https://blog.csdn.net/lafengwnagzi/article/details/52694480
<c:when  test="${channelItem.itemTag =='channel_name'|| channelItem.itemTag =='mobile'}">
   <input type="text" name="itemPlaceholder" class="g-input iptTitle w-100p" value="${channelItem.itemPlaceholder}"  placeholder="可设置提示语">   <span class="sort"><a class="up" href="javascript:;"></a> <a class="down disabled" href="javascript:;"></a></span>
</c:when>
条件分支写成<c:when  test="${channelItem.itemTag =='channel_name'}|| ${channelItem.itemTag =='mobile'}">是错的。
----------------------------------
https://blog.csdn.net/fngang/article/details/78271105
jsp中jstl标签的条件判断语法
1. if

<c:if test="条件">结果
</c:if>

2. choose

<c:choose>
	<c:when test="条件1">  结果1      
	</c:when>   
	<c:when test="条件2">  结果2      
	</c:when>
	...  
	<c:otherwise>结果3</c:otherwise>
</c:choose>

注意:
1. 当多个 <c:when> 符合条件时,只执行第一个符合条件的 <c:when> 
2. 当所有 <c:when> 都不符合条件时,执行 <c:otherwise> 的内容(<c:otherwise>这个标签是可选的，若有则一定是<c:choose> 内的最后一个标签。如无则直接跳出到<c:choose>标签)
3. 如果所有 <c:when> 测试都为 false ，而且又没有给出 <c:otherwise> 操作，那么不会处理任何 <c:choose> 标记的主体内容。

和MyEclipse不同，在Eclipse中的Web项目发布的路径是 所在的工作空间\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps
D:\MyWorkSpace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps
--%>