<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>

<header class="main">
<div class="header-content">
<div class="header-content-inner">
    <h1 class="text-center">Hurray!</h1>

    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <div class="panel panel-default">
                <div class="panel-body text-dark" >

                    <h3>You have successfully confirmed your account!</h3>
                    <h4>You will be redirected to shortly.</h4>

                    <a href="/login.jsp" class="btn btn-lg btn-primary btn-srad" style="margin-top:20px">Click here to be redirected</a>
                </div>
            </div>
        </div>
    </div>

</div>
</div>
</header>

<jsp:include page="_anchor.jsp" />
<jsp:include page="_footer.jsp" />

<script>
    $(document).ready(function(){
        window.setTimeout(function(){
            $.ajax({
                url: '/LogoutServlet',
                data: { 
                    "message": "Please login to access your account!"
                },
                type: 'POST',
                success: function(data) {
                    $.ajax({
                        url: '/StoreSessionVariableServlet',
                        data: { 
                            "message": "Please login to access your account!"
                        },
                        type: 'POST',
                        success: function(data) {
                            window.location.replace("/login.jsp");     
                        }
                    });
                }
            });
        }, 2000);  
    });
</script>