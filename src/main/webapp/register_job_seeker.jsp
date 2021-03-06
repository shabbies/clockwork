<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>

<header class="main">
    <div class="header-content">
        <div class="header-content-inner">
            <h3 class="text-center">Register your job seeker account here!</h3>
            <div class="row">
                <div class="col-md-6">
                    <span class="expired-event">
                        <strong class="display-inline" style="color: red;">Sorry!</strong>
                        <small>you missed it</small>
                    </span>
                    <img src="/img/limited_event_banner.png" class="limited-event-banner"/>
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <h3 class="text-center" style="color: black;
                                text-transform: uppercase;
                                font-family: 'Raleway', sans-serif;
                                font-weight: 700;"><small style="font-weight: 500; color: black;"><strong>Register now and </strong><br/></small>Stand a chance to <br />win an iPad Mini 2!*</h3>
                            <div class="row" style="padding:20px;">
                                <img src="http://img.game.co.uk/ml2/2/8/1/0/281023_scr2_a.png" style="width:325px"/>
                            </div>
                            
                            <div class="row text-center" style="padding-top:10px">
                                <div class="col-centered" style="max-width:300px; ">
                                    
                                </div>
                            </div>
                            <small style="color: black;" class="text-left">
                                *You need to complete your profile in order to be eligible for the draw<br/>
                                <a href="contest_terms.jsp">Terms and Conditions apply </a>
                            </small>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
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
                                        <input id="register-email" class="form-control" type="email" placeholder="Email Address" name="email" required> 
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
                                
                                <div class="form-group form-group-lg col-md-12"> 
                                    <div class="input-group text-center" style="display: block;"> 
                                        <label id="terms_link"><input type="checkbox" name="tc-checkbox" required/> &nbsp; I agree to the <a href="/terms.jsp"> terms of use </a> and <a href="/privacy_policy.jsp"> privacy policy </a></label>
                                    </div> 
                                </div>

                                <input type="hidden" name="account_type" value="job_seeker">
                                <input class="btn btn-lg btn-primary btn-srad" type="submit" value="Create Account">
                                <button type="button" class="btn btn-lg btn-facebook btn-srad" onclick="facebookLogin();" style="cursor: pointer;">Facebook Login</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>
                            
<jsp:include page="_javascript_checker.jsp" />
<jsp:include page="_anchor.jsp" />
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
        success: function(responseString){
          window.location.href = responseString;
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
            appId      : '512331005624440',
            xfbml      : true,
            version    : 'v2.5'
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