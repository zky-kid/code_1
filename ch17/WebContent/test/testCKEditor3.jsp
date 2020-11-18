<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CKEditor</title>
	<script src="${pageContext.request.contextPath}/plugins/ckeditor/ckeditor.js"></script>	
</head>
<body>
	<div style="width:1000px; margin:0px auto;">
		<h2>CKEditor学习</h2>
		<form action="${pageContext.request.contextPath}/testSubmitWithCKEditor" >
			<textarea id="editor" name="editor"></textarea>	
			<input type="submit" value="确定"> <input type="reset" value="重填">	
		</form>
		
	</div>

</body>
</html>
<script>
	CKEDITOR.replace('editor'); // 用这句后，不再需要这个js了。< script src="${pageContext.request.contextPath}/js/useCKEditor.js">< /script> 
	CKEDITOR.config.height = 350;
	CKEDITOR.config.width = 'auto';
</script>