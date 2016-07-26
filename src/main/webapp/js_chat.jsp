<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>

<%@include file="_job_details.jsp"%>
<%@include file="_only_js.jsp"%>
    
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.User"%>
<%@ page import="model.Post"%>
<%@ page buffer="32kb" %>
<header class="main">
<div class="header-full-content">
    
<%@include file="_message.jsp"%>
    
<div class="row">
    <div class="col-md-8">
        <div class="panel panel-default js-chat-body">
            <div class="panel-heading"> 
                <h4>Your Conversations</h4> 
            </div> 

            <div class="col-xs-4" style="padding-left: 0px; padding-right: 0px;">
                <div class="js-chat-side-panel col-md-12">
                    <!--
                    <div class="js-chat-side-panel-details" id="1234">
                        <img src='https://s3-ap-southeast-1.amazonaws.com/media.clockworksmu.herokuapp.com/app/public/assets/logos/Tiong+Bahru+Bakery+2.jpg'>
                        <div>
                            <strong>Tiong Bahru Bakery</strong>
                            <small>Waiter</small>
                            <small>13/06 - 15/06</small>
                        </div>
                    </div>
                    
                    <div class="js-chat-side-panel-details">
                        <img src='https://s3-ap-southeast-1.amazonaws.com/media.clockworksmu.herokuapp.com/app/public/assets/logos/Tiong+Bahru+Bakery+2.jpg'>
                        <div>
                            <strong>Tiong Bahru Bakery</strong>
                            <small>Waiter</small>
                            <small>13/06 - 15/06</small>
                        </div>
                    </div>
                    <div class="js-chat-side-panel-details">
                        <img src='https://s3-ap-southeast-1.amazonaws.com/media.clockworksmu.herokuapp.com/app/public/assets/logos/Tiong+Bahru+Bakery+2.jpg'>
                        <div>
                            <strong>Tiong Bahru Bakery</strong>
                            <small>Waiter</small>
                            <small>13/06 - 15/06</small>
                        </div>
                    </div>
                    <div class="js-chat-side-panel-details">
                        <img src='https://s3-ap-southeast-1.amazonaws.com/media.clockworksmu.herokuapp.com/app/public/assets/logos/Tiong+Bahru+Bakery+2.jpg'>
                        <div>
                            <strong>Tiong Bahru Bakery</strong>
                            <small>Waiter</small>
                            <small>13/06 - 15/06</small>
                        </div>
                    </div>
                    -->
                </div>
            </div>
            <div id="chat-column" class="col-xs-8 chat-other-text-panel">
                <jsp:include page="_chat.jsp" />
            </div>
            <div id="start-column" class="col-xs-8 chat-other-text-panel danger">
                <div>
                    <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                    <strong> Please begin by selecting one of the chats at the side!</strong>
                </div>
            </div>
        </div> 
    </div>

    <%@include file="_js_dashboard.jsp"%>
<div>
    <a href="/mydashboard.jsp" class="btn btn-lg btn-warning btn-srad" type="button">Back to Dashboard</a>
</div>

</div>

</div>
</header>
<jsp:include page="_anchor.jsp" />
<jsp:include page="_footer.jsp" />

<script>
    $(document).ready(function(){
       $("#chat-column").hide();
        $.ajax({
            url: "/GetJSChatrooms",
            method: "POST",
            async: true,
            success: function(responseString) {
                var results = JSON.parse(responseString);
                $(results).each(function(){
                    var avatar = $(this).attr("avatar");
                    if(avatar === null){
                        avatar = "img/user-placeholder.jpg";
                    }
                    var name = $(this).attr("name");
                    var job = $(this).attr("job");
                    var start_date = $(this).attr("start_date");
                    var end_date = $(this).attr("end_date");
                    var chatroom_id = $(this).attr("chatroom_id")
                    
                    var moment_start = moment(start_date);
                    var moment_end = moment(end_date);
                    var formatted_start = moment_start.format("D MMM");
                    var formatted_end = moment_end.format("D MMM");
                    var date_string = formatted_start + " - " + formatted_end;
                    
                    var $name_strong = $("<strong>");
                    var $job_small = $("<small>");
                    var $date_small = $("<small>");
                    
                    $name_strong.append(name);
                    $job_small.append(job);
                    $date_small.append(date_string);
                    
                    var $content_div = $("<div>");
                    
                    $content_div.append($name_strong);
                    $content_div.append($job_small);
                    $content_div.append($date_small);
                    
                    var $image = $("<img>", {class: "hidden-md hidden-sm hidden-xs", src: avatar});
                    var $main_div = $("<div>", {class: "js-chat-side-panel-details", id: chatroom_id});
                    
                    $main_div.append($image);
                    $main_div.append($content_div);
                    
                    $(".js-chat-side-panel").append($main_div);
                });
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.log(textStatus, errorThrown);
            }
        }); 
        
        $(".js-chat-side-panel").on("click", ".js-chat-side-panel-details", function(){
            $("#start-column").hide();
            $("#chat-column").show();
            $(this).addClass("active").siblings().removeClass("active");
            Chat.refreshChat($(this).attr("id"));
        }); 
    });
</script>