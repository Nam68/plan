<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register Plan</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link href="/plan/css/header.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://unpkg.com/@popperjs/core@2"></script> <!-- 툴팁을 위한 popper -->
<style>
.placeCheckbox {display: none; }
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>
<section class="container mb-3">
  <div class="px-4 py-5 my-5 text-center">
    <h1 class="display-5 fw-bold mb-5">Register Plan</h1>
    <hr> 
    <div class="px-5 mt-5 mx-auto row">
      <div class="container">
        <div class="row">
          <div class="col-sm-5 text-start">
            <label for="tripPlanDate" class="form-label fw-bold">Date of Travel</label>
            <input id="tripPlanDate" class="flatpickr form-control" type="text" placeholder="Select Date.." data-id="range">
            <script>
				var startdate;
				var enddate;
				$(".flatpickr").flatpickr(
					{
						mode: "range",
						dateFormat: "Y-m-d",
						onClose: function(selectedDates, dateStr, instance) {
    						startdate = selectedDates[0];
    						enddate = selectedDates[1];
    						
    						if(startdate == null || enddate == null) {
    							return;
    						}
    						
    						//일수 계산을 통해 코드 생성
    						var days = (enddate - startdate) / 1000 / 60 / 60 / 24 +1;
    						var dayCode = '';
    						for(var i = 1; i <= days; i++) {
    							var classCode = 'btn btn-outline-dark';
    							if(i == 1) classCode = 'btn btn-dark';
    							dayCode += '<li class="nav-item"><button class="'+ classCode +'">Day '+ i +'</button></li>';
    						}
    						$('#navbar-date').find('ul').html(dayCode);
    						
    						//날짜 및 장소 선택창 보이기
    						$('#placeContainer').show();
    						$('#navbar-date').show();
    						
    						//스크롤 이동
    						var targetPosition = $('#placeContainer').offset().top - $(window).height()/5;   						
    						setTimeout(function() {
    							$('html, body').animate({scrollTop: targetPosition}, 500);
    						}, 200);
    						
						}				
					}
				);
				$('.flatpickr').on('change', function() {
					
				});
				</script>
          </div>
        </div>
      </div>
      
      <div class="container mt-5">
      
<nav id="navbar-date" class="navbar navbar-light collapse">
  <ul class="nav nav-pills gap-1"></ul>
</nav>      
      
      </div>
      
      
      
      
      
	  <div id="placeContainer" class="container collapse2 form-control">
	    <div class="row mb-4">
	      <div class="col-sm text-start">
			<div class="form-check form-switch fs-5 fw-bold">
			  <input class="form-check-input" type="checkbox" role="switch" id="registeredPlaceCheck">
			  <label class="form-check-label" for="registeredPlaceCheck" role="button" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-html="true" title="チェックすると<br>他のプランに<br>登録されている場所も<br>検索されます">重複旅行先検索</label>
			</div>	        
	      </div>
	    </div>
	    <script>
		    /*
		     * tooltip을 사용하기 위한 초기화
		     */
		    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
		    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
		      	return new bootstrap.Tooltip(tooltipTriggerEl);
		    });
	    </script>
	    <div class="row text-start gap-5 mb-4">
	      <div class="col-sm">
		    <label for="countrySelect" class="form-label fw-bold">Country</label>
		    <select class="form-select" id="countrySelect">
		      <option>Choose...</option>
		      <option>...</option>
		    </select>
	      </div>
	      <div class="col-sm">
	        <label for="citySelect" class="form-label fw-bold">City</label>
		    <select class="form-select" id="citySelect" disabled="disabled">
		      <option>Choose the country</option>
		    </select>
		  </div>
	    </div>
	    <div class="row text-start">
	      <div class="col-sm">
		    <label for="placeSelect" class="form-label fw-bold">Place</label>
			<div class="form-control bg-secondary bg-opacity-10" id="placeSelect" style="height: 16vh; overflow: scroll;">
			  <div class="placeUnit2" role="button2">
				<label>Choose the country or city</label>
				<input class="placeCheckbox" type="checkbox" value="nothing">
			  </div>
			</div>
			<script>
			  	$('.placeUnit').on('click', function() {
			  		var checkbox = $(this).find('input');
			  		var checked = checkbox.attr('checked')=='checked';
			  		
			  		if(!checked) {
			  			$(this).css('background-color', 'skyblue');
			  			checkbox.attr('checked', 'checked');
			  		} else {
			  			$(this).css('background-color', 'rgba(0,0,0,0)');
			  			checkbox.removeAttr('checked');
			  		}
			  	});
			</script>     
	      </div>
	    </div>
	    <div class="row mt-4">
	      <div class="d-grid gap-2 d-md-block">
			<button class="btn btn-primary" type="button">Save</button>
			<button class="btn btn-outline-secondary" type="button">Reset</button>
		  </div>
		  <script>
		  	$('.btn-primary').on('click', function() {
		  		var checkboxes = $('#placeSelect').find('input[checked="checked"]');
		  		var places = [];
		  		
		  		for(var i = 0; i < checkboxes.length; i++) {
		  			var checkbox = checkboxes[i];
		  			places.push(checkbox.value);
		  		}
		  		
		  		window.alert(places);
		  	});
		  </script>
	    </div>
	  </div>
	</div>
  </div>
</section>
<%@ include file="/WEB-INF/views/footer.jsp" %>
<script async src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBPg6sDuTdTWAWj17NeU9JkTVNEs3gJfIU&libraries=places&callback=initMap&v=weekly&region=kr"></script>
</body>
</html>