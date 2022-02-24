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
<div class="modal fade" id="albumContentModal" data-bs-keyboard="false" tabindex="-1" aria-labelledby="albumContentModalLabel" aria-hidden="true">
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
		</script>
      </div>
    </div>
  </div>
</div>
</body>
</html>