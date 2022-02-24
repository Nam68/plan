<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register Place</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link href="/plan/css/header.css" rel="stylesheet">
<link href="/plan/css/place.css" rel="stylesheet">
<script>
let map;
let infowindow;
let infowindowContent;
let marker;
function initMap() {
	var lat = 38;
	var lng = 133;
	
	// 맵 초기화 코드
  	map = new google.maps.Map(document.getElementById("map"), {
    	center: { lat: lat, lng: lng },
    	zoom: 5,
    	mapTypeControl: false,
  	});
  	
	// 자동완성기능 초기화 코드
  	const input = document.getElementById("pac-input");
  	const options = {
		    	fields: ["formatted_address", "geometry", "name", "address_components"],
		    	strictBounds: false,
		  	};
  	const autocomplete = new google.maps.places.Autocomplete(input, options);
  	autocomplete.bindTo("bounds", map);
  
  	// 마커 초기화 코드
  	infowindow = new google.maps.InfoWindow(); // 마커에 정보를 보여주는 역할
  	infowindowContent = document.getElementById("infowindow-content");
  	infowindow.setContent(infowindowContent);
  	marker = new google.maps.Marker({ //실제 마커
	    	map,
	    	anchorPoint: new google.maps.Point(0, -29),
	  	});
  	// 자동완성기능과 마커를 미리 만들어두는 이유 : 이벤트 리스너에서 초기화를 시켜야 하는데, 뒤에서 만들면 초기화가 진행되지 않음
	
  	// 자동완성기능 이벤트리스너
	autocomplete.addListener("place_changed", () => {
		infowindow.close(); // 마커 정보창 초기화
		marker.setVisible(false); // 마커 초기화
		$('.btn-outline-danger').trigger('click'); // 입력사항 초기화
		$('.form-select').css('display', 'none'); // 셀렉트박스 초기화
		
	    const place = autocomplete.getPlace(); // 자동완성에서 장소를 가져오는 코드

	    if (!place.geometry || !place.geometry.location) { // 자동완성창에서 고르지 않고 엔터를 입력하면 넘어오는 메서드
	    	
	    	// input에 입력된 단어를 받아서 place id를 검색 요청
	    	const request = { 
	    			query: place.name,
	    		    fields: ["place_id"]
	    		};
	    	service = new google.maps.places.PlacesService(map); // place 검색을 위해 객체 생성
	    	service.findPlaceFromQuery(request, (results, status) => { // place id 검색 요청
	        	if (status === google.maps.places.PlacesServiceStatus.OK && results) {
	        		// place id 검색에 성공한 경우, getDetails() 메서드를 이용해서 상세정보 검색
	        		// 이렇게 두 번 검색하는 이유 : findPlaceFromQuery() 메서드로는 address_components 정보를 검색할 수 없음
	        		var request = {
	        			  	placeId: results[0].place_id,
	        			  	fields: ["formatted_address", "geometry", "name", "address_components"]
	        			};
	        		service.getDetails(request, (place, status) => { // 상세정보 검색 요청
	        			if (status == google.maps.places.PlacesServiceStatus.OK) {
	        				createMarker(place); //검색이 완료된 경우 마커 요청
	        				inputPlaceInfo(place); // 검색이 완료된 경우 입력칸에 장소정보 표시
	        			} else { // place id로 상세정보가 검색되지 않는 경우
	    	        		window.alert('場所が検索できません！\n正確な検索語を入力してください\nメニューにて選択すると正確な検索結果が現れます');
	    	        	}
					});
	        	} else { // place id가 검색되지 않는 경우
	        		window.alert('場所が検索できません！\n正確な検索語を入力してください\nメニューにて選択すると正確な検索結果が現れます');
	        	}
	      	});
	    }
	    
	    createMarker(place);
	    inputPlaceInfo(place);
	    
	});
}
// 마커와 장소정보를 보여주는 메서드
function createMarker(place) {
    // If the place has a geometry, then present it on a map.
    if (place.geometry.viewport) {
      map.fitBounds(place.geometry.viewport);
    } else {
      map.setCenter(place.geometry.location);
      map.setZoom(15);
    }
	
    // 지도에 이름과 간단한 정보를 출력하는 코드
    marker.setPosition(place.geometry.location);
    marker.setVisible(true);
    infowindowContent.children["place-name"].textContent = place.name;
    infowindowContent.children["place-address"].textContent = place.formatted_address;
    infowindow.open(map, marker);    
}
// 구글맵 정보를 form에 입력하는 메서드
function inputPlaceInfo(place) {
	$('#pac-input').val(place.name);
	$('#addr-input').val(place.formatted_address);
	$('#lat-input').val(place.geometry.location.lat());
	$('#lng-input').val(place.geometry.location.lng());
    
    var addr_json = place.address_components; //주소값이 분할되어 담겨 있는 JSON
    var region = ''; //지역명 저장 변수
    
    // 주소 JSON을 뒤에서부터 거꾸로 돌려서 지역명이 들어 있는 구간을 찾아내어 region에 저장하는 코드
    for(var i = addr_json.length-1; i >= 0; i--) {
    	if(addr_json[i].types[0] == 'administrative_area_level_1') {
    		region = addr_json[i].short_name;
    	}
    }
   
    // 만약 JSON에 지역명이 있는 구간이 없을 경우 직접입력을 요청하는 코드
    if(region == '') {
    	window.alert('地名が正確に検索されていない場合には\nボックスにて直接選んでください');
    	const select = $('.form-select');
    	select.css('display', 'block');
    	select.find('[value="201"]').attr('selected', 'selected'); // pnum 201 = 해외
    	$('#region-input').val($('select option:selected').text());
    }
    
    regionPicker(region);
}
// 맵 정보를 통해서 가져온 지역명을, DB에 맞는 형태로 가공하는 메서드
function regionPicker(region) {
	
	$.ajax({
		url: 'regionPick.do',
		data: {region: region},
		success: function(data) {
						
			$('#region-input').val(data.input);
			$('#region-value').val(data.value);
			
			if(data.value == 'OVERSEAS') {
				$('.form-select').css('display', 'block');
			} else {
				$('.form-select').css('display', 'none');
			}
			
		}
	})
	.fail(function() {
		window.alert('request failed!');
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
    <div class="mt-5 mx-auto row gap-5">
      <div id="map" class="rounded col-sm"></div>
      <div id="input-form" class="col-sm text-start">
      <form name="form">
		<div class="mb-3">
		  <label for="pac-input" class="form-label">Place Search</label>
		  <input id="pac-input" class="form-control" name="title" type="text" placeholder="Search...">
		    <div id="infowindow-content">
		      <span id="place-name" class="title"></span><br/>
		      <span id="place-address"></span>
		    </div>
		</div>
		<div class="mb-3">
		  <label for="region-input" class="form-label">Region</label>
		  <input id="region-input" class="form-control" type="text" placeholder="Please Write Place" readOnly>
		  <select class="form-select mt-2" name="place_select" aria-label="Region select">
			<c:forEach items="${regions }" var="r">
			<option value="${r.value }" ${r.value=='OVERSEAS'? 'selected':'' }>${r.value_jpn }</option>
			</c:forEach>
		  </select>
		  <input id="region-value" name="region" type="hidden">
		  <script>
		  	$('select').on('change', function() {
				$('#region-input').val($('select option:selected').text());
				$('#region-value').val($('select').val());
			});
		  
		  	$('#region-input').on('click', function() {
		  		$('#pac-input').focus();
		  	});
		  </script>
		</div>
		<div class="mb-3">
		  <label for="addr-input" class="form-label">Address</label>
		  <div class="position-relative">
		    <input id="addr-input" class="form-control" name="address" type="text" readOnly placeholder="Please Write Place">
		    <div class="position-absolute top-50 end-0 translate-middle-y p-3">
		      <svg id="addr-copy" role="button" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Copy" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-file-earmark-check" viewBox="0 0 16 16"><path d="M10.854 7.854a.5.5 0 0 0-.708-.708L7.5 9.793 6.354 8.646a.5.5 0 1 0-.708.708l1.5 1.5a.5.5 0 0 0 .708 0l3-3z"/><path d="M14 14V4.5L9.5 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2zM9.5 3A1.5 1.5 0 0 0 11 4.5h2V14a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h5.5v2z"/></svg>		      
		      <script>
			    $('#addr-input').on('click', function() {
					$('#pac-input').focus();
				});

			    // 복사 관련 코드
				$('#addr-copy').on('click', function() {
			    	const copy = $('#addr-input').select();
			    	document.execCommand('copy');

			    	// 복사할 내용의 유무에 따라 출력되는 토스트의 내용을 바꿈
					if($('#addr-input').val() != '') {
						$('.toast-body').html('コピーが完了されました');
					} else {
						$('.toast-body').html('一先ず場所を選んでください');
						$('#addr-input').trigger('click');
					}
				});
			      
			    // 툴팁 관련 코드
			    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
			    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
			    	return new bootstrap.Tooltip(tooltipTriggerEl);
			    });
		      </script>
		    </div>
		    <!-- 복사했을 때 뜨는 토스트 알림창 -->
			<div class="position-fixed bottom-0 start-50 translate-middle-x p-3" style="z-index: 11">
			  <div id="liveToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
				<div class="toast-header">
				  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-right-dots-fill" viewBox="0 0 16 16"><path d="M16 2a2 2 0 0 0-2-2H2a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h9.586a1 1 0 0 1 .707.293l2.853 2.853a.5.5 0 0 0 .854-.353V2zM5 6a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 1a1 1 0 1 1 0-2 1 1 0 0 1 0 2z"/></svg>
				  <strong class="me-auto ps-1">お知らせです</strong>
				  <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
				</div>
				<div class="toast-body">
				  Write toast's content
				</div>
			  </div>
			</div>
			<script>
		    	// 토스트 관련 코드
				var toastTrigger = document.getElementById('addr-copy');
				var toastLiveExample = document.getElementById('liveToast');
				if (toastTrigger) {
				  	toastTrigger.addEventListener('click', function () {
				    	var toast = new bootstrap.Toast(toastLiveExample);
				    	toast.show();
				  	});
				}
			</script>
		  </div>
		</div>
		<div>
		  <input id="lat-input" class="form-control" name="lat" type="hidden">
		  <input id="lng-input" class="form-control" name="lng" type="hidden">
		</div>
		<div class="mb-3">
		  <label for="memo-input" class="form-label">Memo</label>
		  <textarea id="memo-input" class="form-control" name="memo" rows="5"></textarea>
		</div>
		<div class="mb-3 text-center">
  		  <div class="d-grid gap-2 d-md-block">
		    <button id="form-submit" class="btn btn-primary" type="button">Save</button>
		    <button class="btn btn-outline-danger" type="reset">Reset</button>
		    <script>
		    	$('.btn-outline-danger').on('click', () => {
		    		map.setCenter({ lat: 38, lng: 133 });
		    		map.setZoom(5);
		    		infowindow.close(); // 마커 정보창 초기화
		    		marker.setVisible(false); // 마커 초기화
		    	});
		    	
		    	$('#form-submit').on('click', () => {
		    		
		    		if($('#pac-input').val() == '' || $('#region-value').val() == '' || $('#addr-input').val() == '') {
		    			window.alert('場所を入力してください');
		    			return;
		    		}
		    		var queryString = $('form[name="form"]').serialize();
		    		
		    		$.ajax({
		    			url: 'placeAdd.do',
		    			data: queryString,
		    			method: 'POST',
		    			success: function(data) {
		    				if(data == 'SUCCESS') {
			    				$('#resultModalLabel').html('Complete!!');
			    				$('#resultModalContent').html('新しい旅行プランが登録されました');
			    				$('#resultModalButton').on('click', () => {
			    					location.reload();
			    				});
			    				$('#resultModalOn').trigger('click');
		    				} else {
		    					$('#resultModalLabel').html('Failed');
			    				$('#resultModalContent').html('登録できません！<br>管理者にお問い合わせください');
			    				$('#resultModalButton').on('click', () => {
			    					$('.btn-close').trigger('click');	
			    				});
			    				$('#resultModalOn').trigger('click');
		    				}
		    			}
		    		})
		    		.fail(function() {
		    			$('#resultModalLabel').html('Failed');
	    				$('#resultModalContent').html('登録できません！<br>管理者にお問い合わせください');
	    				$('#resultModalButton').on('click', () => {
	    					$('.btn-close').trigger('click');	
	    				});
	    				$('#resultModalOn').trigger('click');
		    		});
		    	});
		    </script>
		  </div>
		</div>
	  </form>
      </div>
    </div>
  </div>
</section>
<%@ include file="/WEB-INF/views/footer.jsp" %>
<script async src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBPg6sDuTdTWAWj17NeU9JkTVNEs3gJfIU&libraries=places&callback=initMap&v=weekly&region=kr"></script>
</body>
</html>