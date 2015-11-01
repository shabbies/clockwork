<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>

<header class="main">
<div class="header-content">
<div class="header-content-inner">
    <%@include file="_message.jsp"%>
    <h1 class="text-center">OOPS!</h1>

    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <div class="panel panel-default">
                <div class="panel-body text-dark" >

                    <h3>You have not verified your account yet!</h3>
                    <br />
                    <h4>Please check that you have received your verification email and verified your account before continuing!</h4>
                    <br/>

                    <h4><small>haven't receive your verification email yet? click below to resend!</small></h4>
                    <a href="/" class="btn btn-lg btn-primary btn-srad">Resend verification email</a>
                </div>
            </div>
        </div>
    </div>

</div>
</div>
</header>

<jsp:include page="_footer.jsp" />
