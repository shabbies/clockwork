<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>

<header class="main">
<div class="header-content">
<div class="header-content-inner">
    <div class="alert alert-success" role="alert" style="font-size: 14px;" hidden>
        <span class="glyphicon glyphicon-ok-sign" aria-hidden="true"></span>
        <strong id="message"></strong>
    </div>
    <h1 class="text-center">OOPS!</h1>

    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <div class="panel panel-default">
                <div class="panel-body text-dark" >

                    <h3>There seems to be an error with the your registration!</h3>

                    <h4><small>your verification email might have expired! click below to resend a new one!</small></h4>
                    <button id="resend-confirmation" class="btn btn-lg btn-primary btn-srad">Resend verification email</button>
                </div>
            </div>
        </div>
    </div>

</div>
</div>
</header>

<jsp:include page="_footer.jsp" />

<script>
    $("#resend-confirmation").on("click", function(){
        $.ajax({
            url: '/SendConfirmationEmailServlet',
            type: 'POST',
            success: function(data) {
                $("#message").html(data);
                $("#message").parent().show();
            }
        });
    });
</script>