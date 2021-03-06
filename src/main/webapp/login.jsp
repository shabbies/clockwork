<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>

<header class="main">
<div class="header-content">
<div class="header-content-inner">
<div class="row">
<div class="col-md-6 col-md-offset-3">
    
<div class="panel panel-default">
    <div class="panel-body">

        <%@include file="_message.jsp"%>

        <div class="text-center login-logo">
            <img src="img/workiki_logo_v1.png" alt="" class="img-responsive" style="width: 200px; margin-left: auto; margin-right: auto;"/>
        </div>


        <form action="/LoginServlet" method="POST" role="form">
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

            <div class="form-group form-group-lg col-md-6 text-left"> 
                <input type="submit" class="btn btn-lg btn-block btn-primary btn-srad" value="Login"/>
            </div>
        </form>
        <div class="form-group form-group-lg col-md-6 text-left"> 
            <button href="" class="btn btn-lg btn-block btn-facebook btn-srad" onclick="facebookLogin();">Facebook Login</button>
        </div>
        <div class="form-group form-group-lg col-md-12 text-left"> 
            <a href="/register.jsp" class="btn btn-lg btn-block btn-warning btn-srad">Register Now!</a>
        </div>
    </div>
</div>
            
</div>
</div>
</div>
</div>                  
</header>                     

<script>
function facebookLogin() {
  FB.login(function(response) {
    if (response.status === 'connected') {
      var accessToken = response.authResponse.accessToken;
      var userID = response.authResponse.userID;
      $.ajax({
        type: "POST",
        url: "/FacebookLoginServlet",
        data: { "access_token" : accessToken, "user_id" : userID },
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
<jsp:include page="_anchor.jsp" />
<jsp:include page="_footer.jsp" />
