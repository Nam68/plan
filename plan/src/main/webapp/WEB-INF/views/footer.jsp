<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<br>
<br>
<br>
<div class="container">
  <footer class="row row-cols-5 py-5 my-5 border-top mt-6">
    <div class="col">
      <a href="/" class="d-flex align-items-center mb-3 link-dark text-decoration-none">
        <svg class="bi me-2" width="40" height="32"><use xlink:href="#bootstrap"/></svg>
      </a>
      <p class="text-muted">&copy; 2021</p>
    </div>

    <div class="col">

    </div>

    <div class="col">
      <h5>Section</h5>
      <ul class="nav flex-column">
        <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">Home</a></li>
        <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">Features</a></li>
        <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">Pricing</a></li>
        <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">FAQs</a></li>
        <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">About</a></li>
      </ul>
    </div>

    <div class="col">
      <h5>Section</h5>
      <ul class="nav flex-column">
        <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">Home</a></li>
        <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">Features</a></li>
        <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">Pricing</a></li>
        <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">FAQs</a></li>
        <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">About</a></li>
      </ul>
    </div>

    <div class="col">
      <h5>Section</h5>
      <ul class="nav flex-column">
        <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">Home</a></li>
        <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">Features</a></li>
        <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">Pricing</a></li>
        <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">FAQs</a></li>
        <li class="nav-item mb-2"><a href="#" class="nav-link p-0 text-muted">About</a></li>
      </ul>
    </div>
  </footer>
</div>

<!-- 
	Result Modal 
-->
<input type="hidden" id="resultModalOn" data-bs-toggle="modal" data-bs-target="#resultModal"/>
<div class="modal fade" id="resultModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="resultModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="resultModalLabel">
        
        </h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
		<div class="row mb-3">
		  <div class="col-12" id="resultModalContent">
		  
		  </div>
	    </div>
      </div>
      <div class="modal-footer">
        <a role="button" class="btn btn-primary" id="resultModalButton">OK</a>
      </div>
    </div>
  </div>
</div>

<!-- 
	Confirm Modal 
-->
<input type="hidden" id="confirmModalOn" data-bs-toggle="modal" data-bs-target="#confirmModal"/>
<div class="modal fade" id="confirmModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="confirmModalLabel">
        
        </h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
		<div class="row mb-3">
		  <div class="col-12" id="confirmModalContent">
		  
		  </div>
	    </div>
      </div>
      <div class="modal-footer">
        <a role="button" class="btn btn-primary" id="confirmModalSubmitButton">OK</a>
        <a role="button" class="btn btn-outline-secondary" id="confirmModalCancelButton"  data-bs-dismiss="modal">Cancel</a>
      </div>
    </div>
  </div>
</div>

<!-- 
	Loading Spinner
 -->
<div class="spinner-placeholder" style="display: none; background-color: rgba(0,0,0,0.6); width: 100%; height: 100%; border: solid black 5px; z-index: 1150; position: fixed; top: 0; left: 0;">
  <div class="position-absolute top-50 start-50 translate-middle">
    <div class="spinner-border text-light" role="status">
      <span class="visually-hidden">Loading...</span>
    </div>
  </div>
</div>
<script>
function loadingOn() {
	$('.spinner-placeholder').css('display', 'block');
}
function loadingOff() {
	$('.spinner-placeholder').css('display', 'none');
}
</script>