<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Plan List</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link href="/plan/css/header.css" rel="stylesheet">
<link href="/plan/css/place.css" rel="stylesheet">
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>
<section class="container mb-3">
  <div class="px-4 py-5 my-5 text-center">
    <h1 class="display-5 fw-bold mb-5">Plan List</h1>
    <hr> 
    <div class="mt-5 mx-auto row gap-5">
	  
	</div>
  </div>
</section>
<%@ include file="/WEB-INF/views/footer.jsp" %>
<script async src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBPg6sDuTdTWAWj17NeU9JkTVNEs3gJfIU&libraries=places&callback=initMap&v=weekly&region=kr"></script>
</body>
</html>