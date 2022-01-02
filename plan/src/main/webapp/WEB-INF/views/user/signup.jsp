<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign Up</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link href="css/header.css" rel="stylesheet">
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp" %>
<section class="container">
  <div class="px-4 py-5 my-5 text-center">
    <h1 class="display-5 fw-bold">Sign Up</h1>
    <hr>
    <div class="col-lg-6 mx-auto">
      <div class="lead mb-4 text-start">
		<form>
		  <div class="row mb-3">
		    <div class="col-12">
		      <label for="inputId" class="form-label">ID <span class="badge bg-secondary ms-3" id="duplicateIdCheck" role="button" data-bs-toggle="modal" data-bs-target="#duplicateIdCheckModal">Duplicate ID check</span></label>
		      <input type="text" class="form-control" id="inputId" name="userid" placeholder="ID" disabled>
		    </div>
		  </div>
		  <div class="row mb-3">
		    <div class="col-12">
		      <label for="inputName" class="form-label">Name</label>
		      <input type="text" class="form-control" id="inputName" name="username" placeholder="Your Name">
		    </div>
		  </div>		  
		  <div class="row mb-3">
		    <div class="col-12">
		      <label for="inputPassword" class="form-label">Password</label>
		      <input type="password" class="form-control" name="userpwd" id="inputPassword">
		    </div>
		  </div>
		  <div class="row mb-3">
		    <div class="col-12">
		      <label for="inputPasswordCheck" class="form-label">Password Check</label>
		      <input type="password" class="form-control" id="inputPasswordCheck" placeholder="Please Repeat Password Once More">
		      <label class="form-label text-danger fw-bold" id="passwordCheckResult">Password does not match</label>
		    </div>
		  </div>
	      <div class="d-grid gap-2 d-sm-flex justify-content-sm-center mt-5">
	        <button type="button" class="btn btn-primary btn-lg px-4 gap-3" id="signupButton">Sign Up</button>
	        <a type="button" class="btn btn-outline-secondary btn-lg px-4" href="index.do" role="button">Return</a>
	      </div>		  
		</form>
		<script>
			var passwordCheck = false;
		  	$('#inputPasswordCheck').on('keyup', function(){
		  		passwordMatchCheck();
		  	});
		  	$('#inputPassword').on('keyup', function(){
		  		passwordMatchCheck();
		  	});
		  	function passwordMatchCheck() {
		  		let target = $('#inputPassword').val();
		  		let compare = $('#inputPasswordCheck').val();
		  		if(target == compare && target != '') {
		  			$('#passwordCheckResult').html('Password is matching!');
		  			$('#passwordCheckResult').addClass('text-primary');
		  			$('#passwordCheckResult').removeClass('text-danger');
		  			passwordCheck = true;
		  		} else {
		  			$('#passwordCheckResult').html('Password does not match');
		  			$('#passwordCheckResult').addClass('text-danger');
		  			$('#passwordCheckResult').removeClass('text-primary');
		  			passwordCheck = false;
		  		}
		  	}
		  	$('#signupButton').on('click', function() {
		  		let userid = $('#inputId').val();
		  		let username = $('#inputName').val();
		  		let userpwd = $('#inputPassword').val();
		  		
		  		if(userid == '') {
		  			window.alert('Please Write ID');
		  			$('#duplicateIdCheck').focus();
		  		} else if(username == '') {
		  			window.alert('please Write Your Name');
		  			$('#inputName').focus();
		  		} else if(passwordCheck == false) {
		  			window.alert('Please Check Password');
		  			$('#inputPassword').focus();
		  		} else {
		  			$.ajax({
		  				url: "signup.do",
		  				data: {
		  						userid: userid,
		  						username: username,
		  						userpwd: userpwd
		  					},
		  				method: 'POST',
		  				success: function(data, status) {
		  					if(data > 0) {
		  						$('#resultModalLabel').html('Welcome!!');
		  						$('#resultModalContent').html('Please wait for administrator\'s approval');
		  						$('#resultModalButton').attr('href', 'index.do');
		  					} else {
		  						$('#resultModalLabel').html('Fail');
		  						$('#resultModalContent').html('Sorry! We fail to sign up...');
		  						$('#resultModalButton').attr('data-bs-dismiss', 'modal');
		  					}
		  					$('#resultModalOn').trigger('click');
		  				}		  				
		  			})
		  			.fail(function(xhr, status) {
					    window.alert('request failed : '+status);
					});
		  			$('#resultModalOn').trigger('click');
		  		}
		  	});
		</script>
      </div>
    </div>
  </div>
</section>
<%@ include file="/WEB-INF/views/footer.jsp" %>

<!-- ID Check Modal -->
<div class="modal fade" id="duplicateIdCheckModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="duplicateIdCheckModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="duplicateIdCheckModalLabel">Duplicate ID Check</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
		<div class="row mb-3">
		  <div class="col-12">
		    <label for="inputPassword" class="form-label">ID</label>
		    <div class="input-group mb-3">
		    <input type="text" class="form-control" id="inputIdCheck" placeholder="Please write ID">
		    <button type="button" class="btn btn-outline-danger" id="inputIdCheckButton">Check ID</button>
		    </div>
	      </div>
	    </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" id="CancelIdCheckButton" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="useCheckedIdButton">User This ID</button>
      </div>
    </div>
  </div>
</div>
<script>
var idCheck = false;
$('#duplicateIdCheck').on('click', function() {
	idCheck = false;
});
$('#inputIdCheckButton').on('click', function() {
	var id = $('#inputIdCheck').val();
	$.ajax({
		url: "duplicateIdCheck.do",
		data: {id: id},
		success: function(data, status) {
			if(data <= 0) {
				window.alert('This ID is available');
				idCheck = true;
			} else {
				window.alert('This ID aleady exists');
				idCheck = false;
			}
		}
	})
	.fail(function(xhr, status) {
	    window.alert('request failed : '+status);
	});
});
$('#useCheckedIdButton').on('click', function() {
	if(idCheck == false) {
		window.alert('Please Click <Check ID> Button');
	} else {
		$('#inputId').val($('#inputIdCheck').val());
		$('#CancelIdCheckButton').trigger('click');
	}
});
</script>
</body>
</html>