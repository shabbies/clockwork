<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>

<header class="main">
    <div class="header-content">
        <div class="header-content-inner">
            <h2 class="text-center">Hello!</h2>
            <h3 class="text-center">Finding a job that suits you has never been easier!</h3>

            <div class="row">
                <div class="col-md-6 col-md-offset-3">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <%@include file="_message.jsp"%>
                            <form class="form form-signup" action="/RegisterAccountServlet" method="POST" role="form">
                                <input class="hidden" id="referrer" value="<%=request.getParameter("rf")%>" name="referrer"/>
                                
                                <div class="form-group form-group-lg col-md-12 text-left"> 
                                    <label for="register-company" class="control-label">Name</label> 
                                    <div class="input-group"> 
                                        <div class="input-group-addon"><i class="fa fa-user fa-lg fa-fw"></i></div> 
                                        <input id="register-company" class="form-control" type="text" placeholder="Name" name="username" required> 
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
                                        <input id="new-password" class="form-control" type="password" placeholder="Password" name="password" required> 
                                    </div> 

                                    <div class="password_length_error" style="display:none;">  
                                        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                                        Password should contain at least 8 characters
                                    </div>

                                </div>

                                <input type="hidden" name="account_type" value="job_seeker">
                                <input class="btn btn-lg btn-primary btn-srad" type="submit" value="Create Account">
                            </form>
                                <button href="" class="btn btn-lg btn-facebook btn-srad" onclick="facebookLogin();">Facebook Login</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>
                            
<jsp:include page="_javascript_checker.jsp" />
<jsp:include page="_footer.jsp" />

<script>
function facebookLogin() {
  FB.login(function(response) {
    if (response.status === 'connected') {
      var accessToken = response.authResponse.accessToken;
      var userID = response.authResponse.userID;
      var referrer = $("#referrer").val();
      $.ajax({
        type: "POST",
        url: "/FacebookLoginServlet",
        data: { "access_token" : accessToken, "user_id" : userID, "referrer": referrer },
        success: function(){
          window.location.href ="/mydashboard.jsp";
        },
        error: function(jqXHR, textStatus, errorThrown) {
          console.log(textStatus, errorThrown);
          console.log(jqXHR);
        }
      });
    } else if (response.status === 'not_authorized') {
            //console.log(response);
    } 
  }, {scope: 'public_profile,email'});
}

window.fbAsyncInit = function() {
    if (window.location.href.toString().indexOf("staging") > -1){
        FB.init({
            appId      : '1657218827890648',
            xfbml      : true,
            version    : 'v2.4'
        });
    } else {
        FB.init({
            appId      : '879787135436221',
            cookie     : true,  // enable cookies to allow the server to access 
                                // the session
            xfbml      : true,  // parse social plugins on this page
            version    : 'v2.4' // use version 2.2
        });
    }
};

  // Load the SDK asynchronously
  (function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));
</script>