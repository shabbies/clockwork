<jsp:include page="_header.jsp" />
<jsp:include page="_nav.jsp" />

<header class="main">
    <div class="header-content">
        <div class="header-content-inner">
            <h2 class="text-center">Hello!</h2>
            <h3 class="text-center">Hiring on Clockwork is simple & effective. Give it a go!</h3>

            <div class="row">
                <div class="col-md-6 col-md-offset-3">
                    <div class="panel panel-default">
                        <div class="panel-body">

                            <form class="form form-signup" action="/RegisterAccountServlet" method="POST" role="form">

                                <div class="form-group form-group-lg col-md-12 text-left"> 
                                    <label for="register-company" class="control-label">Company Name</label> 
                                    <div class="input-group"> 
                                        <div class="input-group-addon"><i class="fa fa-building fa-lg fa-fw"></i></div> 
                                        <input id="register-company" class="form-control" type="text" placeholder="Company Name..." name="username" required> 
                                    </div> 
                                </div>

                                <div class="form-group form-group-lg col-md-12 text-left"> 
                                    <label for="register-email" class="control-label">Email Address</label> 
                                    <div class="input-group"> 
                                        <div class="input-group-addon"><i class="fa fa-envelope fa-lg fa-fw"></i></div> 
                                        <input id="register-email" class="form-control" type="email" placeholder="Email address" name="email" required> 
                                    </div> 
                                </div>

                                <div class="form-group form-group-lg col-md-12 text-left"> 
                                    <label for="register-password" class="control-label">Password</label> 
                                    <div class="input-group"> 
                                        <div id="register-password-icon" class="input-group-addon"><i class="fa fa-lock fa-lg fa-fw"></i></div> 
                                        <input id="register-password" class="form-control" type="password" placeholder="Password" name="password" required> 
                                    </div> 

                                    <div class="password_length_error" style="display:none;">  
                                        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                                        Password should contain at least 8 characters
                                    </div>

                                </div>



                                <input type="hidden" name="account_type" value="employer">
                                <input class="btn btn-lg btn-primary btn-srad" type="submit" value="Create Account"/>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>
<jsp:include page="_javascript_checker.jsp" />
<jsp:include page="_footer.jsp" />