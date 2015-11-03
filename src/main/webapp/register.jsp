<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>

<header class="main">
  <div class="header-content">
    <div class="header-content-inner">
     <h1 class="text-center">Welcome to Clockwork!</h1>

     <div class="row row-centered register-div">
      <div class="col-md-4 col-centered">
        <div class="text-center">
         <a class="whitelink" href="register_job_seeker.jsp">
           <img src="img/register-js.png" alt="" class="register-icon register-icon-js img-responsive"/>
           <h3>I'm a Job Seeker</h3>
         </a> 
       </div>
     </div>
     <div class="col-md-1 col-centered">
       <div class="text-center">
         <h3>OR</h3>
       </div>
     </div>
     <div class="col-md-4 col-centered">
       <div class="text-center">
        <a class="whitelink" href="register_employer.jsp">
          <img src="img/register-emp.png" alt="" class="register-icon register-icon-emp img-responsive"/>
          <h3>I'm an Employer</h3>
        </a> 
      </div>
    </div>
  </div>
</div>
</div>
</header>

<jsp:include page="_anchor.jsp" />
<jsp:include page="_footer.jsp" />
