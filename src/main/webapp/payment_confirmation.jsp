<%@include file="_header.jsp"%>
<%  String paypalAuthToken = request.getParameter("auth"); 
    session.setAttribute("paypalAuthToken", paypalAuthToken); %>
<header class="main">
  <div class="header-content">
    <div class="header-content-inner">
      <h1 class="text-center">Thank you!</h1>

      <div class="row">
        <div class="col-md-8 col-md-offset-2">
          <div class="panel panel-default">
            <div class="panel-body text-dark" >

              <h2>Payment has been made.</h2>
              <h4>You will be redirected shortly.</h4>

              <a href="/" class="btn btn-lg btn-primary btn-srad" style="margin-top:20px">Click here to be redirected</a>
            </div>
          </div>
        </div>
      </div>

    </div>
  </div>
</header>

<script>
    $(document).ready(function(){
        window.setTimeout(function(){
            var referrer = document.referrer;
            if (referrer.indexOf("paypal") === -1){
                $.ajax({
                    url: '/StoreSessionVariableServlet',
                    data: { "message": "Please register to complete your payment process!"},
                    type: 'POST',
                    success: function(data) {
                        window.location.replace("/register_employer.jsp"); 
                    }
                });
            }    
            window.location.replace("/"); 
        }, 500);  
    });
</script>

<jsp:include page="_footer.jsp" />
