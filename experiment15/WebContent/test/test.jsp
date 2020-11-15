<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jstl标签库</title>
</head>
<body>
<c:set var="salary" scope="session" value="${2000*2}"/>
<p>你的工资为 : <c:out value="${salary}"/></p>
<c:choose>
    <c:when test="${salary <= 0}">
       太惨了。
    </c:when>
    <c:when test="${salary > 1000}">
       不错的薪水，还能生活。
    </c:when>
    <c:otherwise>
        什么都没有。
    </c:otherwise>
</c:choose>
<br>网址：https://www.runoob.com/jsp/jstl-core-choose-tag.html<br>
<c:set var="score" scope="page" value="${-4}"/>
<p>你的成绩为 : <c:out value="${score }"/></p>
<c:choose>
    <c:when test="${ score < 60 && 0<=score}">不及格。    </c:when>
    <c:when test="${ score >= 60}">及格了。    </c:when>
    <c:otherwise>错了！    </c:otherwise>
</c:choose>
</body>
</html>
<%--
<c:choose>标签与Java switch语句的功能一样，用于在众多选项中做出选择。
switch语句中有case，而<c:choose>标签中对应有<c:when>，switch语句中有default，而<c:choose>标签中有<c:otherwise>。

----------------
<c:forEach var="每个变量名字"   items="要迭代的list"   varStatus="每个对象的状态" begin="循环从哪儿开始"    end="循环到哪儿结束"    step="循环的步长">
        循环要输出的东西
</c:forEach>
--%>