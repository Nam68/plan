<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Place List</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link href="/plan/css/header.css" rel="stylesheet">
<link href="/plan/css/place.css" rel="stylesheet">
<script>
let map;
function initMap() {
	// 맵 초기화 코드
  	map = new google.maps.Map(document.getElementById("map"), {
    	center: { lat: 38, lng: 133 },
    	zoom: 5,
    	mapTypeControl: false,
  	});
}
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>
<section class="container mb-3">
  <div class="px-4 py-5 my-5 text-center">
    <h1 class="display-5 fw-bold mb-5">Register Place</h1>
    <hr> 
    <div class="mt-5 mx-auto row table-responsive">
	  <table class="table table-striped table-hover">
	    <thead class="table-dark">
	  	  <tr>
		    <th scope="col">#</th>
		    <th scope="col">Name</th>
		    <th scope="col">City</th>
		    <th scope="col">Activity</th>
		  </tr>
	    </thead>
	    <tbody>
		  <c:if test="${placesave==null }">
		  <tr>
		    <td scope="row" colspan="4" class="p-5 no-data-cell" role="button">
		     <h3 class="text-bold">登録された情報がありません</h3>
  		    </td>
		  </tr>
		  </c:if>
		  <c:forEach items="${placesave }" var="ps">
		  <tr role="button" data-bs-toggle="modal" data-bs-target="#contentModal">
		    <th scope="row">${ps.index }</th>
		    <td>${ps.title }</td>
		    <td>${ps.region.value_jpn }</td>
		    <td>*</td>
		  </tr>
		  </c:forEach>
	    </tbody>
	  </table>
	  <script>
	  	$('tr[data-bs-target="#contentModal"]').on('click', function() {
	  		$.ajax({
	  			url: 'placeContentFind.do',
	  			data: {index: $(this).find('th').html()},
	  			success: function(data) {
	  				$('#contentModalLabel').html(data.title);
	  				window.alert(JSON.stringify(data));
	  				window.alert(JSON.stringify(data.geometry));
	  				window.alert(data.geometry.lat);
	  				//모달창 입력
	  			}
	  		})
	  		.fail(function() {
	  			window.alert('request failed!!');
	  		});
	  	});
	  </script>
	  <div>
	  	${page }
	  </div>
	  <div class="d-grid d-md-flex justify-content-md-end">
	    <button class="btn btn-outline-danger" type="button">Add</button>
	  </div>
	  <script>
	  	$('.no-data-cell').on('click', function() {
	  		$('.btn-outline-danger').trigger('click');
	  	});
	  	$('.btn-outline-danger').on('click', function() {
	  		var adminCheck = '${sessionScope.member.roleType=='ADMIN'? 'true':'false'}';
	  		if(adminCheck=='true') {
	  			location.href='registerPlace.do';
	  		} else {
	  			window.alert('管理者のみ利用できます');
	  		}
	  	});
	  </script>
	</div>
  </div>
</section>

<!-- Modal -->
<div class="modal fade" id="contentModal" tabindex="-1" aria-labelledby="contentModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="contentModalLabel">Modal title</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
<%@ include file="/WEB-INF/views/footer.jsp" %>
<script async src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBPg6sDuTdTWAWj17NeU9JkTVNEs3gJfIU&libraries=places&callback=initMap&v=weekly&region=kr"></script>
</body>
</html>