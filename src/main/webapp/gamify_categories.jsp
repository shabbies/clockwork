<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>

<header class="main">
<div class="header-content">
<div class="header-content-inner">
<div class="row">
<div class="col-md-12">  
<div class="panel panel-default">
    <div class="panel-body">
        <div class="col-xs-4 text-center quiz-cleanup"> 
            <a href="GetQuizServlet?type=clean_up" class="col-xs-12 text-left quiz-inner">
                <img src="img/occupation.png" class="quiz-cleanup-icon quiz-icon col-xs-4"/>
                <h3 class="col-xs-8 inner-words">
                    <div>Clean Up</div>
                    <small>How to clear tables efficiently?</small>
                </h3>
            </a>
        </div>
        <div class="col-xs-4 text-center quiz-takeorder"> 
            <a href="quiz/take_order" class="col-xs-12 text-left quiz-inner incomplete">
                <img src="img/menus1.png" class="quiz-takeorder-icon quiz-icon col-xs-4"/>
                <h3 class="col-xs-8 inner-words">
                    <div>Order Taking</div>
                    <small>writing clear order sheets!</small>
                </h3>
            </a>
        </div>
        <div class="col-xs-4 text-center quiz-barista"> 
            <a href="quiz/barista" class="col-xs-12 text-left quiz-inner incomplete">
                <img src="img/tea24.png" class="quiz-barista-icon quiz-icon col-xs-4"/>
                <h3 class="col-xs-8 inner-words">
                    <div>Barista</div>
                    <small>making the best coffee!</small>
                </h3>
            </a>
        </div>
        <div class="col-xs-4 text-center quiz-selling"> 
            <a href="quiz/selling" class="col-xs-12 text-left quiz-inner incomplete">
                <img src="img/speaker15.png" class="quiz-selling-icon quiz-icon col-xs-4"/>
                <h3 class="col-xs-8 inner-words">
                    <div>Selling</div>
                    <small>become the best cross-seller</small>
                </h3>
            </a>
        </div>
        <div class="col-xs-4 text-center quiz-kitchen"> 
            <a href="quiz/kitchen" class="col-xs-12 text-left quiz-inner incomplete">
                <img src="img/chef19.png" class="quiz-kitchen-icon quiz-icon col-xs-4"/>
                <h3 class="col-xs-8 inner-words">
                    <div>Kitchen</div>
                    <small>cooking food right</small>
                </h3>
            </a>
        </div>
        <div class="col-xs-4 text-center quiz-bartender"> 
            <a href="quiz/bartender" class="col-xs-12 text-left quiz-inner incomplete">
                <img src="img/drink24.png" class="quiz-bartender-icon quiz-icon col-xs-4"/>
                <h3 class="col-xs-8 inner-words">
                    <div>Bartender</div>
                    <small>uhm... alcohol?</small>
                </h3>
            </a>
        </div>
        <div class="col-xs-4 text-center quiz-service"> 
            <a href="quiz/serice" class="col-xs-12 text-left quiz-inner incomplete">
                <img src="img/covered16.png" class="quiz-service-icon quiz-icon col-xs-4"/>
                <h3 class="col-xs-8 inner-words">
                    <div>Service</div>
                    <small>being nice to your customers</small>
                </h3>
            </a>
        </div>
        <div class="col-xs-4 text-center quiz-cashier"> 
            <a href="quiz/cashier" class="col-xs-12 text-left quiz-inner incomplete">
                <img src="img/cashier3.png" class="quiz-cashier-icon quiz-icon col-xs-4"/>
                <h3 class="col-xs-8 inner-words">
                    <div>Cashier</div>
                    <small>money is VERY important</small>
                </h3>
            </a>
        </div>
    </div>
</div>
</div>
</div>
</div>
</div>                  
</header>                     
<jsp:include page="_footer.jsp" />

<script>
    $(".incomplete").click(function(e){
        e.preventDefault()
        alert("Oops! This is not yet available!")
    });
</script>
