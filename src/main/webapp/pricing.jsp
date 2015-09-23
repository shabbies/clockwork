<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>

<header class="main">
    <div class="header-full-content">
        <div class="header-content-inner">
            <h1 class="text-center">Our Pricing</h1>
            
            <div class="row row-centered pricing-div">
                <div class="col-md-3 col-lg-3">
                    
                    <!-- PRICE ITEM -->
                    <div class="panel price panel-black">
                        <div class="panel-heading text-center">
                            <h3>OPEN BETA</h3>
                        </div>
                        <div class="panel-body text-center">
                            <span class="pricing-header"><strong>FREE</strong></span>
                        </div>
                        <ul class="list-group list-group-flush text-center">
                            <li class="list-group-item"><i class="icon-ok text-danger"></i> Unlimited Posting</li>
                            <li class="list-group-item"><i class="icon-ok text-danger"></i> Unlimited Hires</li>
                            <li class="list-group-item"><i class="icon-ok text-danger"></i> Email support</li>
                            <li class="list-group-item"><i class="icon-ok text-danger"></i> Personalised Start Up Usage Guide </li>
                            <li class="list-group-item"><i class="icon-ok text-danger"></i> &nbsp; </li>
                        </ul>
                        <div class="panel-footer">
                            <a href="/register_employer.jsp" class="btn btn-lg btn-block btn-primary" id="beta_buy">TRY NOW!</a>
                        </div>
                    </div>
                    <!-- /PRICE ITEM -->
                    
                    
                </div>
                
                <div class="col-md-3 col-lg-3">
                    
                    <!-- PRICE ITEM -->
                    <div class="panel price panel-silver">
                        <div class="panel-heading text-center">
                            <h3>SILVER PLAN</h3>
                        </div>
                        <div class="panel-body text-center">
                            <span class="pricing-header" style="color:grey"><strong>$39.90</strong></span>
                        </div>
                        <ul class="list-group list-group-flush text-center">
                            <li class="list-group-item"><i class="icon-ok text-danger"></i> Unlimited Posting</li>
                            <li class="list-group-item"><i class="icon-ok text-danger"></i> Up to 5 Hires</li>
                            <li class="list-group-item"><i class="icon-ok text-danger"></i> Summarised Report after Job Expiry</li>
                            <li class="list-group-item"><i class="icon-ok text-danger"></i> Email Support</li>
                            <li class="list-group-item"><i class="icon-ok text-danger"></i> No Featured Posting</li>
                        </ul>
                        <div class="panel-footer">
                            <button class="btn btn-lg btn-block btn-primary" id="silver_plan_buy">BUY NOW!</button>
                        </div>
                    </div>
                    <!-- /PRICE ITEM -->
                    
                    
                </div>
                
                <div class="col-md-3 col-lg-3">
                    
                    <!-- PRICE ITEM -->
                    <div class="panel price panel-gold">
                        <div class="panel-heading arrow_box text-center">
                            <h3>GOLD PLAN</h3>
                        </div>
                        <div class="panel-body text-center">
                            <span class="pricing-header"><strong>$59.90</strong></span>
                        </div>
                        <ul class="list-group list-group-flush text-center">
                            <li class="list-group-item"><i class="icon-ok text-info"></i> Unlimited Posting</li>
                            <li class="list-group-item"><i class="icon-ok text-info"></i> Up to 20 Hires</li>
                            <li class="list-group-item"><i class="icon-ok text-info"></i> LIVE Analytics on Web</li>
                            <li class="list-group-item"><i class="icon-ok text-info"></i> Email/Phone Support (9am-6pm)</li>
                            <li class="list-group-item"><i class="icon-ok text-info"></i> Featured Pay-Per-Post</li>
                        </ul>
                        <div class="panel-footer">
                            <button class="btn btn-lg btn-block btn-primary" id="gold_plan_buy">BUY NOW!</button>
                        </div>
                    </div>
                    <!-- /PRICE ITEM -->
                    
                    
                </div>
                
                <div class="col-md-3 col-lg-3">
                    
                    <!-- PRICE ITEM -->
                    <div class="panel price panel-plat">
                        <div class="panel-heading arrow_box text-center">
                            <h3>PLATINUM PLAN</h3>
                        </div>
                        <div class="panel-body text-center">
                            <span class="pricing-header"><strong>$99.90</strong></span>
                        </div>
                        <ul class="list-group list-group-flush text-center">
                            <li class="list-group-item"><i class="icon-ok text-success"></i> Unlimited Posting</li>
                            <li class="list-group-item"><i class="icon-ok text-success"></i> Unlimited Hires</li>
                            <li class="list-group-item"><i class="icon-ok text-info"></i> LIVE Analytics on all platforms</li>
                            <li class="list-group-item"><i class="icon-ok text-success"></i> 24/7 Email & Phone Support</li>
                            <li class="list-group-item"><i class="icon-ok text-success"></i> 2 Free Featured Post / Month</li>
                        </ul>
                        <div class="panel-footer">
                            <button class="btn btn-lg btn-block btn-primary" id="platinum_plan_buy">BUY NOW!</button>
                        </div>
                    </div>
                    <!-- /PRICE ITEM -->
                    
                    
                </div>
                
                
                
            </div>
        </div>
    </div>
</header>

<form action="https://www.sandbox.paypal.com/cgi-bin/webscr" method="post" target="_top" id="silver_plan_subscription" hidden>
    <input type="hidden" name="cmd" value="_s-xclick">
    <input type="hidden" name="hosted_button_id" value="8A5J2PP9ZR34J">
    <input type="image" src="https://www.sandbox.paypal.com/en_US/i/btn/btn_subscribeCC_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
    <img alt="" border="0" src="https://www.sandbox.paypal.com/en_US/i/scr/pixel.gif" width="1" height="1">
</form>

<form action="https://www.sandbox.paypal.com/cgi-bin/webscr" method="post" target="_top" id="gold_plan_subscription" hidden>
    <input type="hidden" name="cmd" value="_s-xclick">
    <input type="hidden" name="hosted_button_id" value="TDDDPARVPMBML">
    <input type="image" src="https://www.sandbox.paypal.com/en_US/i/btn/btn_subscribeCC_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
    <img alt="" border="0" src="https://www.sandbox.paypal.com/en_US/i/scr/pixel.gif" width="1" height="1">
</form>

<form action="https://www.sandbox.paypal.com/cgi-bin/webscr" method="post" target="_top" id="platinum_plan_subscription" hidden>
    <input type="hidden" name="cmd" value="_s-xclick">
    <input type="hidden" name="hosted_button_id" value="LWBLX8PEW9MQG">
    <input type="image" src="https://www.sandbox.paypal.com/en_US/i/btn/btn_subscribeCC_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
    <img alt="" border="0" src="https://www.sandbox.paypal.com/en_US/i/scr/pixel.gif" width="1" height="1">
</form>



<script>
    $(document).on("click", "#silver_plan_buy", function(){
       $("#silver_plan_subscription").submit(); 
    });
    
    $(document).on("click", "#gold_plan_buy", function(){
       $("#gold_plan_subscription").submit(); 
    });
    
    $(document).on("click", "#platinum_plan_buy", function(){
       $("#platinum_plan_subscription").submit(); 
    });
</script>
<jsp:include page="_footer.jsp" />
