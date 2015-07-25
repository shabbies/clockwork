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
                                <button href="" class="btn btn-lg btn-block btn-info btn-srad" onclick="facebookLogin();">Login thru Facebook</button>
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
var facebookLoginWindow;
var loginWindowTimer;
function facebookLogin()
{
	var popupWidth=500;
	var popupHeight=300;
	var xPosition=($(window).width()-popupWidth)/2;
	var yPosition=($(window).height()-popupHeight)/2;
	var loginUrl="http://www.facebook.com/dialog/oauth/?"+
		"client_id="+879787135436221+"&"+
		"redirect_uri=http://clockworksmu.herokuapp.com/FacebookLoginServlet"+
		"display=popup";
	
	facebookLoginWindow=window.open(loginUrl, "LoginWindow", 
		"location=1,scrollbars=1,"+
		"width="+popupWidth+",height="+popupHeight+","+
		"left="+xPosition+",top="+yPosition);
		
	loginWindowTimer=setInterval(onTimerCallbackToCheckLoginWindowClosure, 1000);
}
</script>
<jsp:include page="_footer.jsp" />
