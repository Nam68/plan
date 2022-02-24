<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Modify Memory</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<link href="/plan/css/header.css" rel="stylesheet">
<link href="/plan/css/album.css" rel="stylesheet">
<script>
var startdate = new Date('${album.startDate}');
var enddate = new Date('${album.endDate}');
function initPage() {
	$('#albumContentStartdate').val(new Date(startdate).toLocaleDateString());
	$('#albumContentEnddate').val(new Date(enddate).toLocaleDateString());
	
	var startDate_string = $('#albumContentStartdate').val();
	var endDate_string = $('#albumContentEnddate').val();
	$('.flatpickr').val(startDate_string + " ~ " + endDate_string);
}
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>
<section class="container">
  <div class="px-4 py-5 my-5 text-center">
    <h1 class="display-5 fw-bold">Modify Memory</h1>
    <hr>
    <div class="g-3">
	  <div>
	    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
	      <div class="modal-content shadow p-3 mb-5 bg-body rounded">
	        <!-- JPA에서는 식별자가 없으면 insert, 있으면 update를 자동으로 매칭하기에 같은 컨트롤러에 매킹해도 된다 -->
	        <form id="albumUpdateForm" action="albumAdd.do" method="post">
	        <div class="modal-header row">
	          <div class="modal-title col">
	            <input id="albumTitle" name="title" class="form-control" type="text" value="${album.title }">
	          </div>
	          <div class="col">
	            <input id="albumUpdateDate" class="flatpickr form-control btn btn-info" type="text" placeholder="Select Date.." data-id="range">
				<script>
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
    							$('#albumContentStartdate').val(new Date(startdate).toLocaleDateString());
    							$('#albumContentEnddate').val(new Date(enddate).toLocaleDateString());
							}				
						}
					);
					$('.flatpickr').on('change', function() {
						var startDate_string = $('#albumContentStartdate').val();
						var endDate_string = $('#albumContentEnddate').val();
						$('.flatpickr').val(startDate_string + " ~ " + endDate_string);
					});
				</script>
	          </div>
	        </div>
	        <div class="modal-body">
	          <div class="row">
		        <div class="col-sm">
				  <div id="carouselCaptions" class="carousel slide" data-bs-ride="carousel" data-bs-touch="false" data-bs-interval="false">
				    <div class="mb-2">
				      <button id="addAlbumButton" type="button" class="btn btn-outline-success">Add Photo</button>
				      <button id="deleteAlbumButton" type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteModal">Delete Photo</button>
				      <!-- 이미지 추가 스크립트는 하단에 -->
				    </div>
				    <div id="album-carousel-inner" class="carousel-inner">
				  	  <c:forEach items="${album.images }" var="img" varStatus="status">
				  	  <div class="carousel-item ${status.index==0? 'active':'' }">
						<img src="${img.path }" class="d-block w-100" alt="${img.index }">
					  </div>
				  	  </c:forEach>
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
		      	  <div id="albumInfo" class="row row-cols-2 pt-1 mb-1 text-start">
		      		<div>
		      		  <span>場所：</span>
		      		  <span>
		      		    <select id="albumContentRegion" name="region">
		      		  	  <c:forEach items="${regions }" var="r">
		      		  	    <option value="${r.value }" ${album.region.value == r.value? 'selected':'' }>${r.value_jpn }</option>
		      		  	  </c:forEach>
		      		  	</select>  
		      		  </span>
		      		</div>
		      		<div class="mb-2">
		      		  <span>出発日：</span>
		      		  <span><input id="albumContentStartdate" disabled type="text" role="button" style="width: 15vh;"></span>
		      		  <input name="startDate" type="hidden" value="${album.startDate }">
		      		</div>
		      		<div>
		      		  <span>修正者：</span>
		      		  <span id="albumContentWriter">${sessionScope.member.name }</span>
		      		</div>
		      		<div>
		      		  <span>到着日：</span>
		      		  <span><input id="albumContentEnddate" disabled type="text" role="button" style="width: 15vh;"></span>
		      		  <input name="endDate" type="hidden" value="${album.endDate }">
		      		</div>
		      	  </div>
		      	  <script>
					/**
					*	날짜를 잘못 클릭하면 flatpickr를 열리게 함
					*/
		      	  	$('#albumContentStartdate').on('click', function() {
		      	  		$(".flatpickr").focus();
		      	  		$(".flatpickr").trigger('click');
		      	  		$(this).blur();
		      	  	});
		      	  	$('#albumContentEnddate').on('click', function() {
		      	  		$(".flatpickr").focus();
		      	  		$(".flatpickr").trigger('click');
		      	  		$(this).blur();
		      	  	});
		      	  </script>
		      	  <hr>
		      	  <div id="albumContent" class="row mt-1 ms-1">
		      		<textarea id="albumTextarea" name="memo" class="form-control" rows="8">${album.memo }</textarea>
		      	  </div>
		        </div>
		      </div>
	        </div>
	        </form>
	        <div class="modal-footer">
	          <button type="button" class="btn btn-secondary">Return</button>
	          <button type="button" class="btn btn-success">Update</button>
	          <script>
	          	$('.btn-secondary').on('click', function() {
	          		history.back();
	          	});
	          	$('.btn-success').on('click', function() {
	          		
	          		var title = $('#albumTitle').val();
	          		var imgs = $('#album-carousel-inner').find('img');
	          		var memo = $('#albumTextarea').val();
	          		
	          		if(title == '' || startdate == null || enddate == null || imgs == 0 || memo == '') {
	          			window.alert('全ての情報を入力してください');
	          			return;
	          		}
	          		
	          		$('input[name="startDate"]').val(startdate);
	          		$('input[name="endDate"]').val(enddate);
	          		
	          		$('#albumUpdateForm').append($('<input/>', {name:'index', type:'hidden', value:'${album.index}'}));
	          		$('#albumUpdateForm').submit();
	          	});
	          </script>
	        </div>
	      </div>
	    </div>
	  </div>    
    </div>
  </div>
</section>

<!-- 
	이미지 추가 관련 코드
-->
<form id="albumImgAddForm" method="post" enctype="multipart/form-data">
  <input type="file" id="addImageInput" name="files" multiple="multiple" accept="image/*" style="display: none;">
</form>  
<script>
/**
 * 이미지 버튼을 누르면 input창을 띄움
 */
$('#addAlbumButton').on('click', function() {
	$('#addImageInput').trigger('click');
});
$('#addAlbumIcon').on('click', function() {
	$('#addImageInput').trigger('click');
});


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
						if(data != null && data != '') {
							//임시 이미지를 이어붙이는 코드
							var code = '';
							for(var i = 0; i < data.length; i++) {
								code +=
									'<div class="carousel-item">'+
							          '<img src="'+data[i]+'" class="d-block w-100" alt="'+data[i]+'">'+
							      	'</div>';
							}
							
							$('#album-carousel-inner').html(code);
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

<!-- 
	이미지 삭제 관련 코드
-->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="deleteModalLabel">Select Delete Photo</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div id="deleteAlbumImageGrid" class="modal-body row row-cols-3">
        Empty
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button id="deleteAlbumImage" type="button" class="btn btn-danger">Delete</button>
      </div>
    </div>
  </div>
</div>
<script>
	/**
	*	삭제 버튼을 눌러서 삭제 모달을 띄우는 코드
	*/
	$('#deleteAlbumButton').on('click', function() {
		$.ajax({
			url: 'tempAlbumImageList.do',
			type: 'GET',
			success: function(data) {				
				//temp 내의 이미지 루트를 가져온 경우
				if(data != null && data != '') {
					//임시 이미지를 이어붙이는 코드
					var code = '';
					for(var i = 0; i < data.length; i++) {
						code += //이미지 코드
							'<div class="col mb-3">'+
							'<label for="image-checker'+i+'">'+ //체크박스 클릭을 위한 label 생성
					          '<img src="'+data[i]+'" class="mx-auto d-block deleteImage" alt="..." role="button">'+
					          '<input id="image-checker'+i+'" type="checkbox" value="'+data[i]+'">'+ //선택된 항복 체크를 위한 체크박스 생상
					        '</label>'+
					      	'</div>';
					}
					
					code += '<script>'+ //이미지를 클릭했을 때 이미지의 모양을 바꿔주는 토글 코드
						'$(\'#deleteAlbumImageGrid\').find(\'img\').on(\'click\', function() {'+ 
							'if($(this).hasClass(\'clicked-image\')) {'+
								'$(this).removeClass(\'clicked-image\');'+
							'} else {'+
								'$(this).addClass(\'clicked-image\');'+
							'}'+
						' });'+
						'<\/script>';
					
					$('#deleteAlbumImageGrid').html(code);
					
				//temp 내의 이미지 루트가 없거나 로그인이 되어 있지 않은 경우
				} else {
					window.alert('Images are not loaded...\nPlease Check Login Status And Try Again');
				}
				
				loadingOff();	
			}
		})
		//temp폴더 내의 이미지를 불러오는 데에 실패한 경우
		.fail(function() { 
			loadingOff();
			window.alert('Images are not loaded...');
		});
	});

	
	/**
	*	실제 이미지를 골라서 삭제하는 코드
	*/
	$('#deleteAlbumImage').on('click', function() {
		var boxes = $('#deleteAlbumImageGrid').find('input');
		var checked = [];
		
		//모든 체크박스를 찾아서 체크되어있으면 http 경로를 배열에 저장
		for(var i = 0; i < boxes.length; i++) {
			if(boxes[i].checked) {
				checked.push(boxes[i].value);
			}
		}
		
		//체크된 체크박스가 없을 때
		if(checked.length == 0) {
			window.alert('選択されたイメージがありません！');
			return;
		}
		
		var data = {'urls': checked};
		window.alert(JSON.stringify(data));
		
		loadingOn();
		//저장된 배열을 ajax를 통해 서버로 전송해서 삭제
		$.ajaxSettings.traditional = true;//배열 형태로 서버쪽 전송을 위한 설정
		$.ajax({
			url: 'tempAlbumImageDelete.do',
			method: 'POST',
			data: data,
			success: function(data) {
				//삭제가 성공했을 때 코드
				window.alert(data);
				if(data == 'SUCCESS') {	
					$.ajax({
						url: 'tempAlbumImageList.do',
						type: 'GET',
						success: function(data) {				
							//temp 내의 이미지 루트를 가져온 경우
							if(data != null && data != '') {
								
								//임시 이미지를 이어붙이는 코드
								var code = '';
								for(var i = 0; i < data.length; i++) {
									code +=
										'<div class="carousel-item';
									if(i == 0) {
										code += ' active';
									}
									code += '">'+
								          '<img src="'+data[i]+'" class="d-block w-100" alt="...">'+
								      	'</div>';
								}
								
								$('#album-carousel-inner').html(code);
								
							//temp 내의 이미지 루트가 없거나 로그인이 되어 있지 않은 경우
							} else {								
								$('#album-carousel-inner').html(albumImageAddCode());
								
							}
							loadingOff();	
						}
					})
					//temp폴더 내의 이미지를 불러오는 데에 실패한 경우
					.fail(function() { 
						loadingOff();
						window.alert('Images are not loaded...');
					});
					
				} else {
					window.alert('We Can Not Delete Photo...');
				}
				loadingOff();
			}
		})
		.fail(function() { 
			loadingOff();
			window.alert('request failed!!');
		});
	});
	

	/* 
	 * 컨텐츠 모달창의 이미지+ 버튼 추가 (삭제 후 임시폴더에 아무 파일도 없을 때 사용됨)
	 */
	function albumImageAddCode() {
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
</script>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>