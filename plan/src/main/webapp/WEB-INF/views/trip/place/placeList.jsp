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
let marker;
let infoWindow;
function initMap() {
	// 맵 초기화 코드
  	map = new google.maps.Map(document.getElementById("map"), {
    	center: { lat: 38, lng: 133 },
    	zoom: 5,
    	mapTypeControl: false,
    	disableDefaultUI: true,
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
	  			method: 'POST',
	  			success: function(data) {
	  				/*
	  					마커 관련
	  				*/
	  				//마커에 사용될 좌표
	  				const latLng = { lat: data.geometry.lat, lng: data.geometry.lng };
	  				//마커가 있으면 삭제
	  				if(marker!=null) {
	  					infoWindow.close();
		  				marker.setVisible(false);
	  				}
	  				
	  				//마커 작성
	  				marker = new google.maps.Marker({
	  				    map,
	  				    position: latLng
	  				  });
	  				//마커 설명 작성
	  				infoWindow = new google.maps.InfoWindow({
		  			    content: data.title
	  				  });

	  				//마커 설명을 마커에 부착
	  				infoWindow.open({
	  			      anchor: marker,
	  			      map,
	  			      shouldFocus: false,
	  			    });
	  				//맵 이동
	  				map.panTo(latLng);
	  				map.setZoom(14);
	  				
	  				/*
  						모달창 관련
  					*/
	  				$('.modal-title').html(data.title);
	  				$('.modal-address').html(data.address);
	  				$('.modal-country').html(data.region.country_jpn);
	  				$('#modal-region-value').val(data.region.value);
	  				$('.modal-region').html(data.region.value_jpn);
	  				$('.modal-date').html(new Date(data.registerDate).toLocaleDateString());
	  				$('.modal-writer').html(data.member.name);
	  				$('.modal-memo').html(data.memo);
	  				$('#contentIndex').val(data.index);
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
<form id="contentForm" method="post">
<input id="contentIndex" name="index" type="hidden" value="#">
<div class="modal fade" id="contentModal" tabindex="-1" aria-labelledby="contentModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body container">
        <div class="row">
          <div class="col-sm modal-body-col">
	        <div id="map"></div>
	      </div>
	      <div class="col-sm-6 modal-body-col">
		    <div class="h4 text-bold">
		      <span class="modal-title">title</span>
		    </div>
		    <div>
		      <span class="h6 modal-address">address</span>
		    </div>
		    <hr>
		    <div class="row">
		      <div class="col-auto">
		        <span>Country :&nbsp;</span>
		        <span class="modal-country">country</span>
		      </div>
		      <div class="col-auto">
		        <span>City :&nbsp;</span>
		        <span class="modal-region">city</span>
		   		<input type="hidden" id="modal-region-value" value="REGION">
		      </div>
		    </div>
		    <div>
		      <span>Reporting Date :&nbsp;</span>
		      <span class="modal-date">date</span>
		    </div>
		    <div>
		      <span>Writer :&nbsp;</span>
		      <span class="modal-writer">writer</span>
		    </div>
		    <hr>
		    <div class="modal-memo">memo</div>
		    <hr>
	      </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <c:if test="${sessionScope.member.roleType == 'ADMIN' }">
        <button type="button" class="btn btn-danger">Delete</button>
        <button type="button" class="btn btn-outline-success">Change</button>
        <button type="button" class="btn btn-success d-none">Complete</button>
        <script>
        	$('.btn-danger').on('click', function() {
        		var form = $('#contentForm');
        		form.attr('action', 'placeDelete.do');
        		form.submit();
        	});        	
        	$('.btn-outline-success').on('click', function() {
        		//모달창에 인풋 입력
        		$('.modal-title').html('<input type="text" class="form-control" name="title" value="'+$('.modal-title').html()+'">');
  				$('.modal-region').html('<select name="region"><c:forEach items="${regions }" var="r"><option value=${r.value }>${r.value_jpn }</option></c:forEach></select>');
  				$('.modal-memo').html('<textarea name="memo" cols="45" rows="4">'+$('.modal-memo').html()+'</textarea>');
  				$('.modal-date').html(new Date(Date.now()).toLocaleDateString());
  				$('.modal-writer').html('${sessionScope.member.name}');
  				
  				//지역 셀렉트에 컨텐츠의 정보를 입력
  				var selectedRegion = $('#modal-region-value').val();
  				$('select[name="region"]').val(selectedRegion).prop('selected', true);
  				
  				//업데이트 확인 버튼 보임
  				$('.btn-success').removeClass('d-none');
  				//업데이트 전환 버튼 숨김
  				$(this).addClass('d-none');
        	});
        	$('.btn-success').on('click', function() {
        		var form = $('#contentForm');
        		form.attr('action', 'placeUpdate.do');
        		
        		//업데이트 구현
        		form.submit();
        	});
        	//모달창이 닫힐 때
        	$('.modal').on('hidden.bs.modal', function() {
        		//업데이트 전환 버튼 보임
        		$('.btn-success').addClass('d-none');
        		//업데이트 확인 버튼 숨김
        		$('.btn-outline-success').removeClass('d-none');
        	});
        </script>
        </c:if>
      </div>
    </div>
  </div>
</div>
</form>
<%@ include file="/WEB-INF/views/footer.jsp" %>
<script async src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBPg6sDuTdTWAWj17NeU9JkTVNEs3gJfIU&libraries=places&callback=initMap&v=weekly&region=kr"></script>
</body>
</html>