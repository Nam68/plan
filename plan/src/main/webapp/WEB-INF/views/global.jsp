<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Massage</title>
</head>
<script>
window.onload = function() {
	window.alert('${vo.massage}');
	location.href = '${vo.href}';
}
</script>

</html>