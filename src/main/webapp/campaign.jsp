<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>

<header class="main">
    <div class="header-content">
        <div class="header-content-inner">


            <div class="row">
                <div class="col-md-6 col-md-offset-3">
                    <div class="panel panel-default">
                        <div class="panel-body">
                         <h3 class="text-center" style="color: black;
                         text-transform: uppercase;
                         font-family: 'Raleway', sans-serif;
                         font-weight: 700;">Stand a chance to win a PS4!</h3>
                         <form class="form form-signup" action="/" method="POST" role="form">

                            <div class="row" style="padding:20px;">
                                <img src="https://psmedia.playstation.com/is/image/psmedia/ps4-system-imageblock-vs-us-19jun15?$TwoColumn_Image$" style="width:200px"/>
                            </div>

                            <div class="form-group form-group-lg col-md-12 text-left"> 
                                <div class="input-group"> 
                                    <div class="input-group-addon"><i class="fa fa-user fa-lg fa-fw"></i></div> 
                                    <input id="register-company" class="form-control" type="text" placeholder="Name" name="username" required> 
                                </div> 
                            </div>

                            <div class="form-group form-group-lg col-md-12 text-left"> 
                                <div class="input-group"> 
                                    <div class="input-group-addon"><i class="fa fa-envelope fa-lg fa-fw"></i></div> 
                                    <input id="register-email" class="form-control" type="email" placeholder="Email address" name="email" required> 
                                </div> 
                            </div>

                            <input class="btn btn-lg btn-primary btn-srad" type="submit" value="Submit Entry">
                        </form>

                        <div class="row text-center" style="padding-top:10px">
                            <div class="col-centered" style="max-width:300px; ">
                                <a href="https://geo.itunes.apple.com/sg/app/clockworksg/id1046206671?mt=8" style="float:left;display:inline-block;overflow:hidden;background:url(http://linkmaker.itunes.apple.com/images/badges/en-us/badge_appstore-lrg.svg) no-repeat;width:165px;height:40px;"></a>

                                <a href="https://play.google.com/store/apps/details?id=com.sg.clockwork">
                                  <img alt="Get it on Google Play"
                                  src="https://developer.android.com/images/brand/en_generic_rgb_wo_45.png" />
                              </a>
                          </div>
                      </div>
                  </div>
              </div>
          </div>
      </div>
  </div>
</div>
</header>
<jsp:include page="_javascript_checker.jsp" />
<jsp:include page="_footer.jsp" />