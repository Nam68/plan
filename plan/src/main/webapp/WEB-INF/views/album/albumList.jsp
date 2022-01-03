<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Memory</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<link href="/plan/css/header.css" rel="stylesheet">
<link href="/plan/css/album.css" rel="stylesheet">
</head>
<script>
function initPage() { //페이지 초기화시 실행 (실행 코드는 헤더에 있음)
	var divs = $('.card');
	for(var i = 0; i < divs.length; ++i) {
		var div = divs[i];
	    var divAspect = div.offsetHeight / div.offsetWidth;
	    
	    var img = div.querySelector('img');
	    var imgAspect = img.height / img.width;

	    if (imgAspect <= divAspect) {
	      // 이미지가 div보다 납작한 경우 세로를 div에 맞추고 가로는 잘라낸다
	      var imgWidthActual = div.offsetHeight / imgAspect;
	      var imgWidthToBe = div.offsetHeight / divAspect;
	      var marginLeft = -Math.round((imgWidthActual - imgWidthToBe) / 2);
	      img.style.cssText = 'width: auto; height: 100%; margin-left: ' + marginLeft + 'px;';
	    } else {
	      	// 이미지가 div보다 길쭉한 경우 가로를 div에 맞추고 세로를 잘라낸다
			img.style.cssText = 'width: 100%; height: auto; margin-left: 0;';
	    }
	}
}


/* 
 * 컨텐츠 모달창을 출력하기 위한 메서드 
 */
function albumImgCode(img, count) { //모달창에 들어갈 이미지 추가 코드 (count는 이미지의 순서)
	var carouselClass = '';
	if(count==0) {
		carouselClass = 'carousel-item active'; //첫 번째 이미지에는 active 클래스를 부여해야 함
	} else {
		carouselClass = 'carousel-item';
	}
	var code = 
		'<div class="'+carouselClass+'">'+
			'<img src="'+img+'" class="d-block w-100" width="400" height="300" alt="...">'+
		'</div>';
	return code;
}
function albumEmptyImgCode() { //컨텐츠에 이미지가 없는 경우 빈 이미지를 출력하는 코드
	var code = 
		'<div class="carousel-item active">'+
			'<img src="http://myyk.co.kr/img/noimage.jpg" class="d-block w-100" width="400" height="300" alt="...">'+
		'</div>';
	return code;
}
function albumContentIdx(idx) { //모달창이 현재 어떤 idx로 컨텐츠를 띄우고 있는지 hidden으로 저장(컨텐츠 변경 시 사용)
	var code = '<input type="hidden" id="albumContentIdx" value="'+idx+'">';
	return code;
}
function albumContentFooter() { //컨텐츠를 띄울 때 버튼창
	var role = '${sessionScope.member.roleType}';
	var code = '';
	if(role == 'ADMIN') {
		code += '<button type="button" class="btn btn-outline-danger albumContentDelete">Delete</button>'+
		'<button type="button" class="btn btn-outline-success albumContentUpdate">Update</button>'+
		'<script>'+
			'$(\'.albumContentDelete\').on(\'click\', function() {'+
				'albumContentDelete();'+ //딜리트 버튼을 클릭하면 해당 메서드 수행
			'});'+
			'$(\'.albumContentUpdate\').on(\'click\', function() {'+
				'albumContentUpdate();'+ //업데이트 버튼을 클릭하면 해당 메서드 수행
			'});'+
		'<\/script>';
	}
		code += '<button type="button" class="btn btn-secondary albumContentModalClose" data-bs-dismiss="modal">Close</button>';
	return code+albumFooterScript();
}
function albumFooterScript() { //닫기 버튼을 클릭했을 때 모달창을 초기화해주는 코드
	var code = 
		'<script>'+
			'$(\'.albumContentModalClose\').on(\'click\', function() {'+
				'$(\'#albumContentModalLabel\').html(\'\');'+
				'$(\'#album-carousel-inner\').html(\'\');'+
			'});'+
		'<\/script>';
	return code;
}


/*
 * 컨텐츠 업데이트/삭제 관련 메서드
 */
function albumContentDelete() { //컨텐츠 삭제 스크립트(javascript로 버튼을 추가하기 때문에 따로 빼놓음)
	var idx = $('#albumContentIdx').val();
	if(window.confirm('削除すると復元できません！\n削除しますか？')) {
		$.ajax({
			url: 'albumDelete.do',
			data: {idx: idx},
			success: function(data) {
				if(data > 0) {
					window.alert('削除しました');
					location.href='albumList.do';
				} else {
					window.alert('削除に失敗しました\n管理者にお問い合わせください');
				}
			}
		})
		.fail(function() {
			window.alert('request failed!');
		});
	}
}
function albumContentUpdate() { //컨텐츠 업데이트 스크립트(javascript로 버튼을 추가하기 때문에 따로 빼놓음)
	var idx = $('#albumContentIdx').val();
	$.ajax({ //이미지 파일을 temp폴더에 올려놓기 위한 작업
		url: 'albumUpdate.do',
		method: 'GET',
		data: {idx: idx},
		success: function(data) {
			if(data > 0) { //성공적으로 temp파일에 복사가 된 경우 실행
				$('#albumUpdateModalLabel').val($('#albumContentModalLabel').html());
				$('#update-carousel-inner').html($('#album-carousel-inner').html());
				$('#update-carousel-inner').append(albumAddButton());
				$('#albumUpdateContentTextarea').html($('#albumContent').html());
				$('#albumUpdateModalOn').trigger('click');	
			} else { //temp파일에 복사가 되지 않은 경우 -1이 출력됨
				window.alert('request failed!');
			}
		}
	})
	.fail(function() {
    	window.alert('request failed!');
    });
}
</script>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>
<section class="container">
  <div class="px-4 py-5 my-5 text-center">
    <h1 class="display-5 fw-bold">Memory</h1>
    <hr>
    
    <!-- 관리자 계정인 경우 추가 버튼 생성 -->
    <c:if test="${sessionScope.member.roleType=='ADMIN' }">
    <div class="text-end mb-3">
  	  <a class="btn btn-outline-danger mb-1" role="button" data-bs-toggle="modal" data-bs-target="#albumAddModal">
	    Add New Memory
	  </a>
	</div>
	</c:if>
	
	<!-- 저장된 것이 없는 경우 출력 -->
	<c:if test="${empty list }"><h1>No Memory is saved.</h1></c:if>
    
    <!-- 앨범 영역 -->
    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
      <c:forEach items="${list }" var="m">
      <div class="col">
        <div class="card shadow-sm overflow-hidden position-relative" role="button" data-bs-toggle="modal" data-bs-target="#albumContentModal">
          <span><input type="hidden" value="${m.idx }"></span>
          <span class="w-100 text-center text-white fs-4 fw-bold title">${m.title }</span>
          <span class="w-100 text-center text-white fs-5 city">${m.placeName }</span>
          <span class="w-100 text-center text-white fs-6 startdate">${m.startdate }~${m.enddate }</span>
          <div class="scale">
          	<img class="bd-placeholder-img card-img-top" alt="" src="${empty m.img? 'http://myyk.co.kr/img/noimage.jpg':m.img }"/>    	  
          </div>
        </div>
      </div>
      </c:forEach>
      <script>
        var imgs;
      	$('.card').on('click', function() {
      		var idx = $(this).find('input').val();
      		$.ajax({
      			url: 'albumContent.do',
      			data: {idx: idx},
      			success: function(data) {
      				//각각 받아돈 정보들을 모달창에 입력하는 코드
      				$('#albumContentModalLabel').html(data.album.title);
      				$('#albumContent').html(data.album.content);
      				$('#albumContentModal').append(albumContentIdx(data.album.idx));
      				
      				imgs = data.imgs; //받아온 json데이터에서 img들을 저장하는 변수
      				
      				//imgs가 없는 경우 빈 이미지를 출력하고, 있으면 해당 이미지를 모두 출력함
      				if(imgs.length == 0) {
      					$('#album-carousel-inner').html(albumEmptyImgCode());
      				} else {
	      				for(var i = 0; i < imgs.length; i++) {
	      					$('#album-carousel-inner').append(albumImgCode(imgs[i].img, i));
	      				}
      				}
      				
      				//footer에 들어갈 버튼 코드
  					$('#albumContentModalFooter').html(albumContentFooter());
      			}
      		})
      		.fail(function() {
      			window.alert('request failed!');
      		});
      	});
	  	$('.card').mouseover(function(){
			$(this).find('.scale').trigger('mouseenter');
		});
		$('.card').mouseout(function(){
			$(this).find('.scale').trigger('mouseleave');
		});
		$('.scale').mouseover(function(){
			$(this).addClass('scale_hover');
		});
		$('.scale').mouseout(function(){
			$(this).removeClass('scale_hover');
		});
      </script>
    </div>
    
    <!-- 페이징 -->
    <div class="d-grid gap-2 d-sm-flex justify-content-sm-center mt-5">
      ${page }
    </div>
    
  </div>
</section>
<%@ include file="/WEB-INF/views/footer.jsp" %>

<!-- Content Modal -->
<input type="hidden" id="albumContentModalOn" role="button" data-bs-toggle="modal" data-bs-target="#albumContentModal">
<div class="modal fade" id="albumContentModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="albumContentModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title fs-4 fw-bold" id="albumContentModalLabel">Modal title</h5>
        <button type="button" class="btn-close albumContentModalClose" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body container" id="albumContentModalContent">
        <div class="row">
	      <div class="col-sm">
			<div id="carouselCaptions" class="carousel slide" data-bs-ride="carousel" data-bs-touch="false" data-bs-interval="false">
			  <div class="carousel-inner" id="album-carousel-inner">
			  	Image Code
			  </div>
			  <button class="carousel-control-prev" type="button" data-bs-target="#carouselCaptions" data-bs-slide="prev">
			    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
			    <span class="visually-hidden">Previous</span>
			  </button>
			  <button class="carousel-control-next" type="button" data-bs-target="#carouselCaptions" data-bs-slide="next">
			    <span class="carousel-control-next-icon" aria-hidden="true"></span>
			    <span class="visually-hidden">Next</span>
			  </button>
			</div>
	      </div>
	      <div class="col-sm" id="albumContent">
	        Column
	      </div>
	    </div>
      </div>
      <div class="modal-footer" id="albumContentModalFooter">
        Content Footer
      </div>
    </div>
  </div>
</div>

<!-- Content Update Modal -->
<input type="hidden" id="albumUpdateModalOn" role="button" data-bs-toggle="modal" data-bs-target="#albumUpdateModal">
<div class="modal fade" id="albumUpdateModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="albumUpdateModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title fs-4 fw-bold"><input type="text" class="form-control" id="albumUpdateModalLabel" placeholder="Example input placeholder"></h5>
        <button type="button" class="btn-close albumUpdateModalClose" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body container" id="albumUpdateModalContent">
        <div class="row">
	      <div class="col-sm">
			<div id="updateCarouselCaptions" class="carousel slide" data-bs-ride="carousel" data-bs-touch="false" data-bs-interval="false">
			  <div class="carousel-inner" id="update-carousel-inner">
			  	Image Code
			  </div>
			  <button class="carousel-control-prev" type="button" data-bs-target="#updateCarouselCaptions" data-bs-slide="prev">
			    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
			    <span class="visually-hidden">Previous</span>
			  </button>
			  <button class="carousel-control-next" type="button" data-bs-target="#updateCarouselCaptions" data-bs-slide="next">
			    <span class="carousel-control-next-icon" aria-hidden="true"></span>
			    <span class="visually-hidden">Next</span>
			  </button>
			</div>
	      </div>
	      <div class="col-sm" id="albumUpdateContent">
	        <textarea class="form-control" id="albumUpdateContentTextarea" rows="10"></textarea>
	      </div>
	    </div>
      </div>
      <div class="modal-footer" id="albumUpdateModalFooter">
        <button type="button" class="btn btn-success">Save changes</button>        
		<button type="button" class="btn btn-secondary albumUpdateModalClose" data-bs-dismiss="modal">Close</button>
		<script>
			$('.albumUpdateModalClose').on('click', function() {
				$('#albumContentModalOn').trigger('click');
				$('#albumUpdateModalLabel').val('');
				$('#update-carousel-inner').html('');
			});
		</script>
      </div>
    </div>
  </div>
</div>


<!-- Add Modal -->
<input type="hidden" id="albumAddModalOn" role="button" data-bs-toggle="modal" data-bs-target="#albumAddModal">
<div class="modal fade" id="albumAddModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="albumAddModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <div class="modal-title fs-4 fw-bold" id="albumAddModalLabel">
        
        
        <div class="row g-3 fs-5 fw-normal">
			<div class="col-auto">
				<input type="text" class="form-control" id="albumAddTitle" placeholder="Write Title...">
			</div>
			<div class="col-auto">
				<select id="albumAddPlace" class="form-select" aria-label="Default select example">			    	
					<option selected>Select City</option>
					<option value="1">One</option>
					<option value="2">Two</option>
					<option value="3">Three</option>
				</select>
			</div>
			<div class="col-auto">
				<input id="albumAddDate" class="flatpickr" type="text" placeholder="Select Date.." data-id="range">
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
							}				
						}
					);
				</script>
			</div>
		</div>
        
        
        </div>
        <button type="button" class="btn-close albumAddModalClose" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body container" id="albumAddModalContent">
        <div class="row">
	      <div class="col-sm">
			<div id="addCarouselCaptions" class="carousel carousel-dark slide" data-bs-ride="carousel" data-bs-touch="false" data-bs-interval="false">
			  <div class="carousel-inner" id="album-carousel-inner" style="border: solid red 1px;">
			  	
			  	
			  	
			  	<div class="carousel-item active" role="button" id="addAlbumButton" style="border: solid black 1px; height: 100%;">
				  <svg xmlns="http://www.w3.org/2000/svg" class="position-absolute top-50 start-50 translate-middle text-center" width="100" height="100" fill="currentColor" class="bi bi-plus-circle-fill" viewBox="0 0 16 16"><path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8.5 4.5a.5.5 0 0 0-1 0v3h-3a.5.5 0 0 0 0 1h3v3a.5.5 0 0 0 1 0v-3h3a.5.5 0 0 0 0-1h-3v-3z"/></svg>
				</div>
				<script>
					$('#addAlbumButton').on('click', function() {
						$('#addImageInput').trigger('click');
					});
				</script>
			  	
			  	<!-- 임시 이미지 -->
			  	  <div class="carousel-item">
			        <img src="http://myyk.co.kr/img/noimage.jpg" class="d-block w-100" alt="...">
			      </div>
			      <div class="carousel-item">
			        <img src="http://myyk.co.kr/img/memory/ss2%20(2).JPG" class="d-block w-100" alt="...">
			      </div>
			      <div class="carousel-item">
			        <img src="http://myyk.co.kr/img/memory/busan2.JPG" class="d-block w-100" alt="...">
			      </div>
			  	<!-- 임시 이미지 -->
			  	
			  </div>
			  <button class="carousel-control-prev" type="button" data-bs-target="#addCarouselCaptions" data-bs-slide="prev">
			    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
			    <span class="visually-hidden">Previous</span>
			  </button>
			  <button class="carousel-control-next" type="button" data-bs-target="#addCarouselCaptions" data-bs-slide="next">
			    <span class="carousel-control-next-icon" aria-hidden="true"></span>
			    <span class="visually-hidden">Next</span>
			  </button>
			  
			  
			</div>
	      </div>
	      <div class="col-sm" id="albumAddContent">
	        <textarea class="form-control" id="albumAddContent" rows="10"></textarea>
	      </div>
	    </div>
      </div>
      <div class="modal-footer" id="albumAddModalFooter">
        <button type="button" id="albumAddSubmitButton" class="btn btn-primary">Submit</button>
		<button type="button" class="btn btn-secondary albumAddModalClose" data-bs-dismiss="modal">Close</button>
		<script>
			$('#albumAddSubmitButton').on('click', function() {
				
				/*
				var title = $('#albumAddTitle').val();
				var content = $('#albumAddContent').val();
				var place = $('#albumAddPlace').val();
				var imgsLength = $('#album-carousel-inner').find('img').length;

				//입력이 전부 되어 있는지 확인
				if(title == '' || content == '' || startdate == null || place == 'Select City' || imgsLength == 0) {
					window.alert('全ての情報を入力してください');
					return;
				}
				
				var form = $('<form></form>');
				form.attr('action', 'index.do');
				
				form.append($('<input/>'), {type: 'hidden', name: 'title', value: title});
				form.append($('<input/>'), {type: 'hidden', name: 'content', value: content});
				form.append($('<input/>'), {type: 'hidden', name: 'place', value: place});
				form.append($('<input/>'), {type: 'hidden', name: 'stardate', value: startdate});
				form.append($('<input/>'), {type: 'hidden', name: 'enddate', value: enddate});
				
				form.appendTo('body');
				form.submit();
				*/
			});
		</script>
      </div>
    </div>
  </div>
</div>

<!-- 이미지를 추가하기 위한 코드 -->
<form id="albumImgAddForm" method="post" enctype="multipart/form-data">
  <input type="file" id="addImageInput" name="files" multiple="multiple" accept="image/*" style="display: none;">
</form>
<div class="spinner-placeholder" style="display: none; background-color: rgba(0,0,0,0.6); width: 100%; height: 100%; border: solid black 5px; z-index: 1150; position: fixed; top: 0; left: 0;">
  <div class="position-absolute top-50 start-50 translate-middle">
    <div class="spinner-border text-light" role="status">
      <span class="visually-hidden">Loading...</span>
    </div>
  </div>
</div>
<script>
/**
 * 이미지 관련 ajax에 실패했을 때 메서드
 */
function imageRequestFailed() {
	$('.spinner-placeholder').css('display', 'none');
	window.alert('request failed!');
}

$('#addImageInput').on('change', function() {
	var form = $('#albumImgAddForm')[0];
	var formData = new FormData(form);
	window.alert('add Image Check');
	
	$('.spinner-placeholder').css('display', 'block');
	
	$.ajax({
		url: 'tempAlbumImgAdd.do',
		type: 'POST',
		enctype: 'multipart/form-data',
		data: formData,
		processData: false,
		contentType: false,
		success: function(data) {
			if(data > 0) {
				$.ajax({
					url: 'tempAlbumImageList.do',
					type: 'POST',
					success: function(data) {
						
						$('.spinner-placeholder').css('display', 'none');
					}
				})
				.fail(function() {
					imageRequestFailed();	
				});
			} else {
				imageRequestFailed();	
			}
		}
	})
	.fail(function() {
		imageRequestFailed();
	});
	
});
</script>
</body>
</html>