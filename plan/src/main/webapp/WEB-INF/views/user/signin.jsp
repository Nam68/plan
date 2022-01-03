<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign In</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link href="/plan/css/header.css" rel="stylesheet">
<link href="/plan/css/user.css" rel="stylesheet">
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>
<section class="container">
  <div class="px-4 py-5 my-5 text-center">
    <h1 class="display-5 fw-bold">Sign In</h1>
    <hr>
	<main class="form-signin">
	  <form>
	    <img class="mb-4" src="http://myyk.co.kr/img/title.png" alt="" width="152" height="57">
	    <h1 class="h3 mb-3 fw-normal">Please sign in</h1>
	
	    <div class="form-floating">
	      <input type="text" class="form-control" id="signinId" placeholder="ID">
	      <label for="floatingInput">ID</label>
	    </div>
	    <div class="form-floating">
	      <input type="password" class="form-control" id="signinPassword" placeholder="Password">
	      <label for="floatingPassword">Password</label>
	    </div>
	
	    <div class="checkbox mb-3">
	      <label>
	        <input type="checkbox" value="true" id="rememberInfo" data-bs-toggle="collapse" data-bs-target="#signin-collapse" aria-expanded="false" aria-controls="signin-collapse"> Remember me
	      </label>
	      <div class="collapse" id="signin-collapse">
		    <div class="card card-body">
		      保安の問題が発生するので公共場所の機器や他人の機器では使用しないでください
		    </div>
		  </div>
	    </div>
	    <button class="w-100 btn btn-lg btn-primary" type="button" id="signinButton">Sign in</button>
	    <p class="mt-5 mb-3 text-muted">&copy; 2021~</p>
	  </form>
	</main>
	<script>
        $(window).on('keydown', function(e) {
        	if(e.keyCode == 13) {
        		$('#signinButton').trigger('click');
        	}
        });
        
        $('#signinButton').on('click', function() {
        	$.ajax({
        		url: 'signin.do',
        		method: 'POST',
        		data: {
	        			id: $('#signinId').val(), 
	        			password: $('#signinPassword').val(),
	        			check: $('#rememberInfo').val()
        			},
        		success: function(data) {
        			if(data > 0) {
	  					$('#resultModalLabel').html('Sign in Success');
	  					$('#resultModalContent').html('Welcome!!');
	  					$('#resultModalButton').attr('href', 'index.do');
	  					$('#resultModalButton').removeAttr('data-bs-dismiss');
	  				
	  					// 사용자가 버튼을 누르지 않고 엔터키를 누를 경우 메인으로 이동
	  					$(window).on('keydown', function(e) {
	  		       			if(e.keyCode == 13) {
	  		       				location.href = 'index.do';
	  		       			}
	  		       		});
	  				} else {
	  					$('#resultModalLabel').html('Sign in failed');
	  					$('#resultModalContent').html('Please check you ID and Password');
	  					$('#resultModalButton').attr('data-bs-dismiss', 'modal');
	  					$('#resultModalButton').removeAttr('href');
	  				}
	  				$('#resultModalOn').trigger('click');
        		}
        	})
        	.fail(function(xhr, status) {
        	    window.alert('request failed : '+status);
        	});
        });
	</script>
  </div>
</section>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>