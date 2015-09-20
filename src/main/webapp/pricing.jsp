<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>

<header class="main">
    <div class="header-content">
        <div class="header-content-inner">
            <h1 class="text-center">Our Pricing</h1>
            
            <div class="row row-centered pricing-div">
                <div class="col-md-4 col-lg-4">
                    
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
                            <li class="list-group-item"><i class="icon-ok text-danger"></i> Summarized Report after Job Expiry</li>
                            <li class="list-group-item"><i class="icon-ok text-danger"></i> Email support</li>
                            <li class="list-group-item"><i class="icon-ok text-danger"></i> No Featured Posting</li>
                        </ul>
                        <div class="panel-footer">
                            <a class="btn btn-lg btn-block btn-primary" href="#">BUY NOW!</a>
                        </div>
                    </div>
                    <!-- /PRICE ITEM -->
                    
                    
                </div>
                
                <div class="col-md-4 col-lg-4">
                    
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
                            <li class="list-group-item"><i class="icon-ok text-info"></i> Live Analytics on Web</li>
                            <li class="list-group-item"><i class="icon-ok text-info"></i> Email/Phone Support (9am-6pm)</li>
                            <li class="list-group-item"><i class="icon-ok text-info"></i> Featured Pay-Per-Post</li>
                        </ul>
                        <div class="panel-footer">
                            <a class="btn btn-lg btn-block btn-primary" href="#">BUY NOW!</a>
                        </div>
                    </div>
                    <!-- /PRICE ITEM -->
                    
                    
                </div>
                
                <div class="col-md-4 col-lg-4">
                    
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
                            <a class="btn btn-lg btn-block btn-primary" href="#">BUY NOW!</a>
                        </div>
                    </div>
                    <!-- /PRICE ITEM -->
                    
                    
                </div>
                
                
                
            </div>
        </div>
    </div>
</header>
<form action="https://www.sandbox.paypal.   com/cgi-bin/webscr" method="post" target="_top">
<input type="hidden" name="cmd" value="_xclick-subscriptions">
<input type="hidden" name="business" value="FNMMM6WBLEMK4">
<input type="hidden" name="lc" value="SG">
<input type="hidden" name="item_name" value="Clockwork Silver Plan">
<input type="hidden" name="src" value="1">
<input type="hidden" name="a3" value="39.90">
<input type="hidden" name="p3" value="1">
<input type="hidden" name="t3" value="M">
<input type="hidden" name="currency_code" value="SGD">
<input type="hidden" name="bn" value="PP-SubscriptionsBF:btn_subscribeCC_LG.gif:NonHosted">
<input type="image" src="https://www.sandbox.paypal.com/en_GB/SG/i/btn/btn_subscribeCC_LG.gif" border="0" name="submit" alt="PayPal ? The safer, easier way to pay online.">
<img alt="" border="0" src="https://www.sandbox.paypal.com/en_GB/i/scr/pixel.gif" width="1" height="1">
</form>

<jsp:include page="_footer.jsp" />
