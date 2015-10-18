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
                                <input class="hidden" value="<%=request.getParameter("rf")%>" name="referrer"/>
                                <div class="form-group form-group-lg col-md-12 text-left"> 
                                    <label for="register-nric" class="control-label">NRIC</label> 
                                    <div class="input-group"> 
                                        <div id="register-nric-icon" class="input-group-addon"><i class="fa fa-list-alt fa-lg fa-fw"></i></div> 
                                        <input id="register-nric" class="form-control" type="text" placeholder="NRIC" name="nric" required> 
                                    </div> 
                                    
                                    <div class="nric_error" style="display: none;">  
                                        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                                        Please enter a valid NRIC number!
                                    </div>
                                </div>
                                
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
$("#register-nric").focusout(function() {
    var str = $("#register-nric").val();
    if (str.length != 9) 
        $('.nric_error').removeAttr("style");

        $("#register-nric").css("border", "1px solid #ee4054" );
        $("#register-nric").css("box-shadow", "none");

        $("#register-nric-icon").css("border", "1px solid #ee4054");
        $("#register-nric-icon").css("background-color", "#ee4054");
        $("#register-nric-icon").css("color", "#fff");

    str = str.toUpperCase();

    var i, 
        icArray = [];
    for(i = 0; i < 9; i++) {
        icArray[i] = str.charAt(i);
    }

    icArray[1] = parseInt(icArray[1], 10) * 2;
    icArray[2] = parseInt(icArray[2], 10) * 7;
    icArray[3] = parseInt(icArray[3], 10) * 6;
    icArray[4] = parseInt(icArray[4], 10) * 5;
    icArray[5] = parseInt(icArray[5], 10) * 4;
    icArray[6] = parseInt(icArray[6], 10) * 3;
    icArray[7] = parseInt(icArray[7], 10) * 2;

    var weight = 0;
    for(i = 1; i < 8; i++) {
        weight += icArray[i];
    }

    var offset = (icArray[0] == "T" || icArray[0] == "G") ? 4:0;
    var temp = (offset + weight) % 11;

    var st = ["J","Z","I","H","G","F","E","D","C","B","A"];
    var fg = ["X","W","U","T","R","Q","P","N","M","L","K"];

    var theAlpha;
    if (icArray[0] == "S" || icArray[0] == "T") { 
        theAlpha = st[temp]; 
    } else if (icArray[0] == "F" || icArray[0] == "G") { 
        theAlpha = fg[temp]; 
    }

    if (icArray[8] !== theAlpha){
        $('.nric_error').removeAttr("style");

        $("#register-nric").css("border", "1px solid #ee4054" );
        $("#register-nric").css("box-shadow", "none");

        $("#register-nric-icon").css("border", "1px solid #ee4054");
        $("#register-nric-icon").css("background-color", "#ee4054");
        $("#register-nric-icon").css("color", "#fff");
    } else {
        $(".nric_error").attr("style", "display: none;");
        $("#register-nric").css("border", "1px solid #ccc" );
        $("#register-nric").css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075)");
        
        $("#register-nric-icon").css("border", "1px solid #ccc");
        $("#register-nric-icon").css("background-color", "#eee");
        $("#register-nric-icon").css("color", "#555");
    }
});
</script>