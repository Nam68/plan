<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${title }</title>
</head>
<script>
window.onload = function() {
	window.alert('${msg}');
	location.href = '${href}';
}
</script>
</html>