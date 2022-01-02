<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- ******* 부트스트랩 아이콘 모음 ******* -->
<svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
  <symbol id="bootstrap" viewBox="0 0 118 94">
    <title>Bootstrap</title>
    <path fill-rule="evenodd" clip-rule="evenodd" d="M24.509 0c-6.733 0-11.715 5.893-11.492 12.284.214 6.14-.064 14.092-2.066 20.577C8.943 39.365 5.547 43.485 0 44.014v5.972c5.547.529 8.943 4.649 10.951 11.153 2.002 6.485 2.28 14.437 2.066 20.577C12.794 88.106 17.776 94 24.51 94H93.5c6.733 0 11.714-5.893 11.491-12.284-.214-6.14.064-14.092 2.066-20.577 2.009-6.504 5.396-10.624 10.943-11.153v-5.972c-5.547-.529-8.934-4.649-10.943-11.153-2.002-6.484-2.28-14.437-2.066-20.577C105.214 5.894 100.233 0 93.5 0H24.508zM80 57.863C80 66.663 73.436 72 62.543 72H44a2 2 0 01-2-2V24a2 2 0 012-2h18.437c9.083 0 15.044 4.92 15.044 12.474 0 5.302-4.01 10.049-9.119 10.88v.277C75.317 46.394 80 51.21 80 57.863zM60.521 28.34H49.948v14.934h8.905c6.884 0 10.68-2.772 10.68-7.727 0-4.643-3.264-7.207-9.012-7.207zM49.948 49.2v16.458H60.91c7.167 0 10.964-2.876 10.964-8.281 0-5.406-3.903-8.178-11.425-8.178H49.948z"></path>
  </symbol>
  <symbol id="home" viewBox="0 0 16 16">
    <path d="M8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4.5a.5.5 0 0 0 .5-.5v-4h2v4a.5.5 0 0 0 .5.5H14a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.354 1.146zM2.5 14V7.707l5.5-5.5 5.5 5.5V14H10v-4a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5v4H2.5z"/>
  </symbol>
  <symbol id="speedometer2" viewBox="0 0 16 16">
    <path d="M8 4a.5.5 0 0 1 .5.5V6a.5.5 0 0 1-1 0V4.5A.5.5 0 0 1 8 4zM3.732 5.732a.5.5 0 0 1 .707 0l.915.914a.5.5 0 1 1-.708.708l-.914-.915a.5.5 0 0 1 0-.707zM2 10a.5.5 0 0 1 .5-.5h1.586a.5.5 0 0 1 0 1H2.5A.5.5 0 0 1 2 10zm9.5 0a.5.5 0 0 1 .5-.5h1.5a.5.5 0 0 1 0 1H12a.5.5 0 0 1-.5-.5zm.754-4.246a.389.389 0 0 0-.527-.02L7.547 9.31a.91.91 0 1 0 1.302 1.258l3.434-4.297a.389.389 0 0 0-.029-.518z"/>
    <path fill-rule="evenodd" d="M0 10a8 8 0 1 1 15.547 2.661c-.442 1.253-1.845 1.602-2.932 1.25C11.309 13.488 9.475 13 8 13c-1.474 0-3.31.488-4.615.911-1.087.352-2.49.003-2.932-1.25A7.988 7.988 0 0 1 0 10zm8-7a7 7 0 0 0-6.603 9.329c.203.575.923.876 1.68.63C4.397 12.533 6.358 12 8 12s3.604.532 4.923.96c.757.245 1.477-.056 1.68-.631A7 7 0 0 0 8 3z"/>
  </symbol>
  <symbol id="table" viewBox="0 0 16 16">
    <path d="M0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2zm15 2h-4v3h4V4zm0 4h-4v3h4V8zm0 4h-4v3h3a1 1 0 0 0 1-1v-2zm-5 3v-3H6v3h4zm-5 0v-3H1v2a1 1 0 0 0 1 1h3zm-4-4h4V8H1v3zm0-4h4V4H1v3zm5-3v3h4V4H6zm4 4H6v3h4V8z"/>
  </symbol>
  <symbol id="people-circle" viewBox="0 0 16 16">
    <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
    <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
  </symbol>
  <symbol id="memory" viewBox="0 0 16 16">
  	<path d="M5 0h8a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2 2 2 0 0 1-2 2H3a2 2 0 0 1-2-2h1a1 1 0 0 0 1 1h8a1 1 0 0 0 1-1V4a1 1 0 0 0-1-1H3a1 1 0 0 0-1 1H1a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v9a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H5a1 1 0 0 0-1 1H3a2 2 0 0 1 2-2z"/><path d="M1 6v-.5a.5.5 0 0 1 1 0V6h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0V9h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 2.5v.5H.5a.5.5 0 0 0 0 1h2a.5.5 0 0 0 0-1H2v-.5a.5.5 0 0 0-1 0z"/>
  </symbol>
  <symbol id="trip" viewBox="0 0 16 16">
  	<path fill-rule="evenodd" d="M3.1 11.2a.5.5 0 0 1 .4-.2H6a.5.5 0 0 1 0 1H3.75L1.5 15h13l-2.25-3H10a.5.5 0 0 1 0-1h2.5a.5.5 0 0 1 .4.2l3 4a.5.5 0 0 1-.4.8H.5a.5.5 0 0 1-.4-.8l3-4z"/><path fill-rule="evenodd" d="M8 1a3 3 0 1 0 0 6 3 3 0 0 0 0-6zM4 4a4 4 0 1 1 4.5 3.969V13.5a.5.5 0 0 1-1 0V7.97A4 4 0 0 1 4 3.999z"/>
  </symbol>
  <symbol id="request" viewBox="0 0 16 16">
    <path d="M7.001 11a1 1 0 1 1 2 0 1 1 0 0 1-2 0zM7.1 4.995a.905.905 0 1 1 1.8 0l-.35 3.507a.553.553 0 0 1-1.1 0L7.1 4.995z"/><path d="m10.273 2.513-.921-.944.715-.698.622.637.89-.011a2.89 2.89 0 0 1 2.924 2.924l-.01.89.636.622a2.89 2.89 0 0 1 0 4.134l-.637.622.011.89a2.89 2.89 0 0 1-2.924 2.924l-.89-.01-.622.636a2.89 2.89 0 0 1-4.134 0l-.622-.637-.89.011a2.89 2.89 0 0 1-2.924-2.924l.01-.89-.636-.622a2.89 2.89 0 0 1 0-4.134l.637-.622-.011-.89a2.89 2.89 0 0 1 2.924-2.924l.89.01.622-.636a2.89 2.89 0 0 1 4.134 0l-.715.698a1.89 1.89 0 0 0-2.704 0l-.92.944-1.32-.016a1.89 1.89 0 0 0-1.911 1.912l.016 1.318-.944.921a1.89 1.89 0 0 0 0 2.704l.944.92-.016 1.32a1.89 1.89 0 0 0 1.912 1.911l1.318-.016.921.944a1.89 1.89 0 0 0 2.704 0l.92-.944 1.32.016a1.89 1.89 0 0 0 1.911-1.912l-.016-1.318.944-.921a1.89 1.89 0 0 0 0-2.704l-.944-.92.016-1.32a1.89 1.89 0 0 0-1.912-1.911l-1.318.016z"/>
  </symbol>
</svg>

<!-- 헤더 시작위치 -->
<header>
  <div class="px-3 py-2 bg-dark text-white">
    <div class="container">
      <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
        <a href="index.do" class="d-flex align-items-center my-2 my-lg-0 me-lg-auto text-white text-decoration-none">
          <svg class="bi me-2" width="40" height="32" role="img" aria-label="Bootstrap"><use xlink:href="#bootstra2p"/></svg>
          <img alt="titleImg" src="http://epoche02.cafe24.com/img/title_light.png" class="bi me-2" width="150" height="60">
        </a>

        <ul class="nav col-12 col-md-auto mb-2 justify-content-center mb-md-0 text-small">
          <li>
            <a href="index.do" class="nav-link ${sessionScope.header == 'home'? 'text-primary':'text-white' }">
              <svg class="bi d-block mx-auto mb-1" width="24" height="24"><use xlink:href="#home"/></svg>
              Home
            </a>
          </li>
          <li>
            <a href="memoryList.do" class="nav-link ${sessionScope.header == 'memory'? 'text-primary':'text-white' }">
              <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-journals d-block mx-auto mb-1"><use xlink:href="#memory"/></svg>
              Memory
            </a>
          </li>
          <li class="dropdown">
            <a href="#" class="nav-link ${sessionScope.header == 'trip'? 'text-primary':'text-white' } dropdown-toggle" id="dropdownTripMenu" data-bs-toggle="dropdown" aria-expanded="false">
              <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-journals d-block mx-auto mb-1"><use xlink:href="#trip"/></svg>
              Trip
            </a>
            <ul class="dropdown-menu" aria-labelledby="dropdownTripMenu">
		      <li><a class="dropdown-item" href="registerPlace.do">Register Place</a></li>
		      <li><a class="dropdown-item" href="placeList.do">Place List</a></li>
		      <li><hr class="dropdown-divider"></li>
		      <li><a class="dropdown-item" href="#">Register Trip Plan</a></li>
		      <li><a class="dropdown-item" href="#">Trip Plan List</a></li>
		    </ul>
          </li>
          <li>
            <a href="#" class="nav-link ${sessionScope.header == 'request'? 'text-primary':'text-white' }">
              <svg class="bi d-block mx-auto mb-1" width="24" height="24"><use xlink:href="#request"/></svg>
              Request
            </a>
          </li>
          <li>
            <a href="#" class="nav-link ${sessionScope.header == 'user'? 'text-primary':'text-white' }">
              <svg class="bi d-block mx-auto mb-1" width="24" height="24"><use xlink:href="#people-circle"/></svg>
              User Menu
            </a>
          </li>
        </ul>
        
        <div class="col-md-3 text-end">
          <c:if test="${empty sessionScope.member }">
            <a href="signin.do" class="px-2 text-white text-decoration-none">Sign in</a>
            <a href="signup.do" class="px-2 text-white text-decoration-none">Sign up</a>
          </c:if>
          <c:if test="${!empty sessionScope.member }">
	        <a href="signin.do" class="px-2 text-white text-decoration-none">Hello, ${sessionScope.member.name }! </a>
	        <a role="button" class="px-2 text-white text-decoration-none" id="navSignout"> Sign out</a>
			<script>
	          	$('#navSignout').on('click', function() {
	          		$('#confirmModalLabel').html('Sign out');
	          		$('#confirmModalContent').html('Are you sure?');
	          		$('#confirmModalSubmitButton').on('click', function() {
	          			$.ajax({
	          				url: 'signout.do',
	          				success: function(data) {
	          					if(data > 0) {
	          						$('#resultModalLabel').html('Sign out success');
	          						$('#resultModalContent').html('See you later!');
	          						$('#resultModalButton').attr('href', 'index.do');
	          						$('#resultModalOn').trigger('click');
	          					} else {
	          						$('#resultModalLabel').html('Sing out failed');
	          						$('#resultModalContent').html('There is something wrong with our server...');
	          						$('#resultModalButton').attr('data-bs-dismiss', 'modal');
	          						$('#resultModalOn').trigger('click');
	          					}
	          				}
	          			})
	          			.fail(function(xhr, status) {
	          				window.alert('request fail:'+status);
	          			})
	          		});
	          		$('#confirmModalOn').trigger('click');
	          	});
			</script>
	      </c:if>
        </div>
      </div>
    </div>
  </div>
</header>
<!-- 헤더 끝 -->

<!-- 상단 공통이미지 -->
<section>
<div class="labelDiv">
	<label>今までの${sessionScope.period}日<br>これからもよろしく</label>
</div>
<div class="imgDiv">
	<img alt="mainImg" src="http://epoche02.cafe24.com/img/mainImg.JPG" class="mainImg">
</div>
</section>

<!-- 각 메뉴의 시작위치 지정(공통이미지 아래) -->
<a id="pageStartPoint"></a>
<script>
window.onload = function() {
	var portrait = ($(window).width() - $(window).height()) < 0;
	var scrollPosition;
	if(portrait) {
		scrollPosition = 0;
	} else {
		scrollPosition = $('#pageStartPoint').offset().top;
	}
	
	// Home인 경우 스크롤 취소
	<c:if test="${sessionScope.header=='home'}">return;</c:if>
	
	// 스크롤이 필요 없는 경우 스크롤 취소
	<c:if test="${!empty scroll_cancel}">return;</c:if>
	
	// 스크롤 트랜지션이 필요 없는 경우 애니메이션 취소
	<c:if test="${!empty scroll_animation_cancel}">$('html, body').scrollTop(scrollPosition); return;</c:if>
	
	setTimeout(function() {
		$('html, body').animate({scrollTop: scrollPosition}, 500);
	}, 200);
	
	initPage(); //혹시 onload가 필요할 땐 initPage() 메서드를 각 jsp 페이지에 만들어서 실행할 것
}
</script>