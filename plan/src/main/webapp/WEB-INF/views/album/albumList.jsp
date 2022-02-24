<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<c:if test="${sessionScope.member.roleType == 'ADMIN' }">
<c:set var="permit" value="true"/>
</c:if>
<c:if test="${sessionScope.member.roleType != 'ADMIN' }">
<c:set var="permit" value="false"/>
</c:if>
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
<style>
#albumInfo {font-size: 2vh;} 
</style>
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
 * 컨텐츠 모달창의 이미지 추가 메서드
 */
function albumImageAddCode() { //모달창에 들어갈 이미지 추가 코드 (count는 이미지의 순서)
	var code =
		'<div class="carousel-item active" role="button" id="addAlbumButton">'+
		  '<svg xmlns="http://www.w3.org/2000/svg" class="position-absolute top-50 start-50 translate-middle text-center" width="100" height="100" fill="currentColor" class="bi bi-plus-circle-fill" viewBox="0 0 16 16"><path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8.5 4.5a.5.5 0 0 0-1 0v3h-3a.5.5 0 0 0 0 1h3v3a.5.5 0 0 0 1 0v-3h3a.5.5 0 0 0 0-1h-3v-3z"/></svg>'+
		'</div>'+
		'<script>'+
			'$(\'#addAlbumButton\').on(\'click\', function() {'+
				'$(\'#addImageInput\').trigger(\'click\');'+
			'});'+
		'<\/script>';
	return code;
}
function albumEmptyImgCode() { //컨텐츠에 이미지가 없는 경우 빈 이미지를 출력하는 코드
	var code = 
		'<div class="carousel-item active">'+
			'<img src="http://myyk.co.kr/img/noimage.jpg" class="d-block w-100" width="400" height="300" alt="...">'+
		'</div>';
	return code;
}
</script>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>
<section class="container">
  <div class="px-4 py-5 my-5 text-center">
    <h1 class="display-5 fw-bold">Memory</h1>
    <hr>
    
    <!-- 관리자 계정인 경우 추가 버튼 생성 -->
    <c:if test="${permit }">
    <div class="text-end mb-3">
  	  <a id="albumAddButton" class="btn btn-outline-danger mb-1" role="button">
	    Add New Memory
	  </a>
	  <script>
	  	$('#albumAddButton').on('click', function() {
	  		location.href = 'albumAdd.do';
	  	});
	  </script>
	</div>
	</c:if>
	
	<!-- 
		저장된 것이 없는 경우 출력 
	-->
	<c:if test="${empty list }"><h1>No Memory is saved.</h1></c:if>
    
    <!-- 
    	앨범 영역 
    -->
    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
      <c:forEach items="${list }" var="list">
      <div class="col">
        <div class="card shadow-sm overflow-hidden position-relative" role="button" data-bs-toggle="modal" data-bs-target="#albumContentModal">
          <span><input type="hidden" value="${list.index }"></span>
          <span class="w-100 text-center text-white fs-4 fw-bold title">${list.title }</span>
          <span class="w-100 text-center text-white fs-5 city">${list.region.value_jpn }</span>
          <span class="w-100 text-center text-white fs-6 startdate">${list.startDate }~${list.endDate }</span>
          <div class="scale">
          	<img class="bd-placeholder-img card-img-top" alt="" src="${empty list.images? 'http://myyk.co.kr/img/noimage.jpg':list.images[0].path }"/>		
          </div>
        </div>
      </div>
      </c:forEach>
      <script>
      	$('.card').on('click', function() {
      		var index = $(this).find('input').val();
      		
      		$.ajax({
      			url: 'albumContent.do',
      			data: {index: index},
      			//성공한 경우 content modal에 정보를 전달해서 출력
      			success: function(data) {
      				/*
      				*	출력
      				*/
      				$('#albumContentModalLabel').html(data.title); //타이틀
      				$('#albumContentRegion').html(data.region.value_jpn); //장소
      				$('#albumContentWriter').html(data.member.name); //작성자
      				$('#albumContentStartdate').html(new Date(data.startDate).toLocaleDateString()); //출발일
      				$('#albumContentEnddate').html(new Date(data.endDate).toLocaleDateString()); //도착일
      				$('#albumContent').html(data.memo); //메모
      				$('#albumContentIdx').val(data.index); //인덱스
      				
      				/*
      				*	이미지를 이어붙이는 코드
      				*/
					var imageCode = '';
					for(var i = 0; i < data.images.length; i++) {
						imageCode +=
							'<div class="carousel-item';
						if(i == 0) {
							imageCode +=
								' active';
						}
						imageCode +=
							'">'+
					          '<img src="'+data.images[i].path+'" class="d-block w-100" alt="'+data.images[i].index+'">'+
					      	'</div>';
					}
					
					if(data.images.length <= 0) {
						imageCode = '<div class="carousel-item active"><img src="http://myyk.co.kr/img/noimage.jpg" class="d-block w-100" alt="Image Not Founded"></div>';
					}
				  
					$('#album-carousel-inner').html(imageCode);
      				
      			}
      		})
      		.fail(function() {
      			window.alert('request failed!');
      		});
      	});
      	
      	/*
      	*	마우스를 올리면 나타나는 이벤트
      	*/
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
	  ${pageCode }
    </div>
    
  </div>
</section>
<%@ include file="/WEB-INF/views/footer.jsp" %>

<!-- 
	Content Modal 
-->
<input type="hidden" id="albumContentIdx">
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
	      <div class="col-sm container">
	      	<div class="row row-cols-2 pt-1 mb-1 text-start" id="albumInfo">
	      		<div><span>場所：</span><span id="albumContentRegion"></span></div>
	      		<div><span>出発日：</span><span id="albumContentStartdate"></span></div>
	      		<div><span>作成者：</span><span id="albumContentWriter"></span></div>
	      		<div><span>到着日：</span><span id="albumContentEnddate"></span></div>
	      	</div>
	      	<hr>
	      	<div class="row mt-1" id="albumContent">
	      		Memo
	      	</div>
	      </div>
	    </div>
      </div>
      <div class="modal-footer" id="albumContentModalFooter">
		<button type="button" class="btn btn-outline-danger albumContentDelete">Delete</button>
		<c:if test="${permit }">
		<button type="button" class="btn btn-outline-success albumContentUpdate">Update</button>
		</c:if>
		<button type="button" class="btn btn-secondary albumContentModalClose" data-bs-dismiss="modal">Close</button>
		<script>
			/*
			*	컨텐츠 삭제 버튼 클릭
			*/
			$('.albumContentDelete').on('click', function() {
				var idx = $('#albumContentIdx').val();
				if(window.confirm('削除すると復元できません！\n削除しますか？')) {
					$.ajax({
						url: 'albumDelete.do',
						data: {idx: idx},
						success: function(data) {
							if(data == 'SUCCESS') {
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
			});
			
			/*
			*	컨텐츠 업데이트 버튼 클릭
			*/
			$('.albumContentUpdate').on('click', function() {
				var index = $('#albumContentIdx').val();
				
				$.ajax({ //이미지 파일을 temp폴더에 올려놓기 위한 작업
					url: 'albumUpdate.do',
					data: {index: index},
					success: function(data) {
						if(data == 'SUCCESS') { //성공적으로 temp파일에 복사가 된 경우 실행
							
							var form = $('<form></form>');
							form.attr('action', 'albumUpdate.do');
							form.attr('method', 'post');
							
							form.append($('<input/>', {type:'hidden', name:'index', value:index}));
							
							form.appendTo('body');
							form.submit();
							
						} else {
							window.alert('request failed!');
						}
					}
				})
				.fail(function() {
			    	window.alert('request failed!');
			    });
			});
			
			$('.albumContentModalClose').on('click', function() {
				$('#albumContentModalLabel').html('');
				$('#album-carousel-inner').html('');
			});
		</script>
      </div>
    </div>
  </div>
</div>

<!-- 
	Content Update Modal 
-->
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


<!-- 
	Add Modal
 -->
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
				<select id="albumAddRegion" class="form-select" aria-label="Default select example">			    	
					<option value="" selected>Select City...</option>
					<c:forEach items="${regions }" var="r">
					<option value="${r.value }">${r.value_jpn }</option>
					</c:forEach>
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
			  <div class="carousel-inner" id="album-add-carousel-inner">
			  	
			  	
			  	
			  	<div class="carousel-item active" role="button" id="addAlbumButton">
				  <svg xmlns="http://www.w3.org/2000/svg" class="position-absolute top-50 start-50 translate-middle text-center" width="100" height="100" fill="currentColor" class="bi bi-plus-circle-fill" viewBox="0 0 16 16"><path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8.5 4.5a.5.5 0 0 0-1 0v3h-3a.5.5 0 0 0 0 1h3v3a.5.5 0 0 0 1 0v-3h3a.5.5 0 0 0 0-1h-3v-3z"/></svg>
				</div>
				<script>
					$('#addAlbumButton').on('click', function() {
						$('#addImageInput').trigger('click');
					});
				</script>
				
				
			  	
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
	      <div class="col-sm">
	        <textarea class="form-control" id="albumAddMemo" rows="10"></textarea>
	      </div>
	    </div>
      </div>
      <div class="modal-footer" id="albumAddModalFooter">
        <button type="button" id="albumAddSubmitButton" class="btn btn-primary">Submit</button>
		<button type="button" class="btn btn-secondary albumAddModalClose" data-bs-dismiss="modal">Close</button>
		<script>
			$('#albumAddSubmitButton').on('click', function() {
				var title = $('#albumAddTitle').val();
				var memo = $('#albumAddMemo').val();
				var region = $('#albumAddRegion').val();
				var imgsLength = $('#album-add-carousel-inner').find('img').length;
								
				//입력이 전부 되어 있는지 확인
				if(title == '' || memo == '' || startdate == null || region == '' || imgsLength == 0) {
					window.alert('全ての情報を入力してください');
					return;
				}
				
				var form = $('<form></form>');
				form.attr('action', 'albumAdd.do');
				form.attr('method', 'POST');
				
				form.append($('<input/>', {type: 'hidden', name: 'title', value: title}));
				form.append($('<input/>', {type: 'hidden', name: 'memo', value: memo}));
				form.append($('<input/>', {type: 'hidden', name: 'region', value: region}));
				form.append($('<input/>', {type: 'hidden', name: 'startDate', value: startdate}));
				form.append($('<input/>', {type: 'hidden', name: 'endDate', value: enddate}));
				
				form.appendTo('body');
				form.submit();
			});
			
			/**
			*	메모리 추가 모달 닫기버튼 : temp 폴더 삭제
			*/
			$('.albumAddModalClose').on('click', function() {
				loadingOn();
				
				$.ajax({
					url: 'tempAlbumImageDelete.do',
					method: 'GET',
					success: function(data) {
						loadingOff();
					}
				})
				.fail(function() {
					loadingOff();
					window.alert('Images are not loaded...\nPlease Check Login Status And Try Again');
				});
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
<script>
/**
 * 이미지 input의 정보가 바뀌었을 때 메서드
 */
$('#addImageInput').on('change', function() {
	var form = $('#albumImgAddForm')[0];
	var formData = new FormData(form);
	
	//취소버튼을 누르면 아래를 진행하지 않음
	if($('#addImageInput').val() == '') {
		return;	
	}
	
	loadingOn();
	
	$.ajax({
		url: 'tempAlbumImgAdd.do',
		type: 'POST',
		enctype: 'multipart/form-data',
		data: formData,
		processData: false,
		contentType: false,
		success: function(data) {
			//이미지가 성공적으로 temp폴더에 들어간 경우
			if(data == 'SUCCESS') {
				//temp폴더 내의 모든 이미지 루트를 가져옴
				$.ajax({
					url: 'tempAlbumImageList.do',
					type: 'GET',
					success: function(data) {
						//temp 내의 이미지 루트를 가져온 경우
						if(data != null) {
							
							//이미지 추가 버튼을 위한 코드
							var addButtonCode = albumImageAddCode();
							
							//임시 이미지를 이어붙이는 코드
							var tempImageCode = '';
							for(var i = 0; i < data.length; i++) {
								tempImageCode +=
									'<div class="carousel-item">'+
							          '<img src="'+data[i]+'" class="d-block w-100" alt="'+data[i]+'">'+
							      	'</div>';
							}
							
							var code = addButtonCode + tempImageCode;
							$('#album-add-carousel-inner').html(code);
							
							loadingOff();
							
						//temp 내의 이미지 루트가 없거나 로그인이 되어 있지 않은 경우
						} else {
							loadingOff();	
							window.alert('Images are not loaded...\nPlease Check Login Status And Try Again');
						}
						
					}
				})
				//temp폴더 내의 이미지를 불러오는 데에 실패한 경우
				.fail(function() { 
					loadingOff();
					window.alert('Images are not loaded...');
				});
			//이미지를 temp폴더에 넣지 못한 경우
			} else {
				loadingOff();	
				window.alert('Images are not registered...');
			}
		}
	})
	.fail(function() {
		loadingOff();	
		window.alert('request failed!');
	});
	
});
</script>
</body>
</html>