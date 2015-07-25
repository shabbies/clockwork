<jsp:include page="_header.jsp" />
<jsp:include page="_nav.jsp" />

<header class="main">
    <div class="header-content">
        <div class="header-content-inner">
            <div class="row">
                <div class="col-md-6 col-md-offset-3">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <%if (session.getAttribute("error") != null){%>
                            <!-- Gerald TODO: Style error message -->
                            <h4 style="color: black;">  <%=session.getAttribute("error")%></h4>   
                            <%  session.removeAttribute("error");
                                session.setAttribute("loginSource", "create_new_post");}%>
                            <!-- END -->
                            <h2 class="text-center primary">Login</h2>
                            
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

                                <div class="form-group form-group-lg col-md-12 text-left"> 
                                  <input type="submit" class="btn btn-lg btn-block btn-primary btn-srad" value="Login"/>
                                </div>
                            </form>
                            <div class="form-group form-group-lg col-md-12 text-left"> 
                                <button href="" class="btn btn-lg btn-block btn-info btn-srad" onclick="checkLoginState();">Login thru Facebook</button>
                            </div>
                            <div class="form-group form-group-lg col-md-12 text-left"> 
                                <a href="/register.jsp" class="btn btn-lg btn-block btn-default btn-srad">New to Clockwork? Click Here</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>                  
</header>                     
                                
<script>
function statusChangeCallback(response) {
    if (response.status === 'connected') {
      // Logged into your app and Facebook.
      alert("logged in");
    } else {
        FB.login(function(response) {
            if (response.status === 'connected') {
                console.log(response);
            } else if (response.status === 'not_authorized') {
                //console.log(response);
            } else {
                alert("???");
            }
        }, {scope: 'public_profile,email'});
    }
}

  // This function is called when someone finishes with the Login
  // Button.  See the onlogin handler attached to it in the sample
  // code below.
  function checkLoginState() {
    FB.getLoginStatus(function(response) {
      statusChangeCallback(response);
    });
  }

  window.fbAsyncInit = function() {
  FB.init({
    appId      : '879787135436221',
    cookie     : true,  // enable cookies to allow the server to access 
                        // the session
    xfbml      : true,  // parse social plugins on this page
    version    : 'v2.4' // use version 2.2
  });
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
<jsp:include page="_footer.jsp" />
