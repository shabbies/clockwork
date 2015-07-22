<jsp:include page="_header.jsp" />
<jsp:include page="_nav.jsp" />

<header class="main">
  <div class="header-content">
    <div class="header-content-inner">


      <div class="row">
        <div class="col-md-6 col-md-offset-3">
          <div class="panel panel-default">
            <div class="panel-body">
                <h2 class="text-center primary">Login</h2>
                <form action="/" method="POST" role="form">

                    <div class="form-group form-group-lg col-md-12 text-left"> 
                        <div class="input-group"> 
                         <div class="input-group-addon"><i class="fa fa-envelope fa-lg fa-fw"></i></div> 
                         <input id="login-email" class="form-control" type="text" placeholder="Your email address" name="email" required> 
                     </div>
                 </div>

                 <div class="form-group form-group-lg col-md-12 text-left"> 
                    <div class="input-group"> 
                     <div class="input-group-addon"><i class="fa fa-lock fa-lg fa-fw"></i></div> 
                     <input id="login-password" class="form-control" type="password" placeholder="password" name="password" required>
                 </div>
             </div>

             <div class="form-group form-group-lg col-md-12 text-left"> 
                 <input type="submit" class="btn btn-lg btn-block btn-primary btn-srad" value="Login"/>
             </div>

         </form>

         <div class="form-group form-group-lg col-md-12 text-left"> 
          <a href="/register_employer.jsp" class="btn btn-lg btn-block btn-default btn-srad">New to Clockwork? Click Here</a>
      </div>


  </div>
</div>
</div>
</div>
</div>
</div>
</header>

<jsp:include page="_footer.jsp" />
