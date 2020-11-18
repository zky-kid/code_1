<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CKEditor</title>
	<script src="${pageContext.request.contextPath}/plugins/ckeditor/ckeditor.js"></script>
	<script src="${pageContext.request.contextPath}/js/useCKEditor.js"></script>
</head>
<body>
	<div style="width:1000px; margin:0px auto;">
		<h2>CKEditor学习</h2>
		<div id="editor">
			<h1>Hello world!</h1>
			<p>I'm an instance of <a href="https://ckeditor.com">CKEditor</a>.</p>
		</div>		
	</div>

</body>
</html>
<script>
	initSample();
</script>