<%@page import="model.User"%>

<nav id="mainNav" class="navbar navbar-default navbar-fixed-top">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand page-scroll" href="/index.jsp">Workiki</a>
        </div>
        
        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">
                
                <% if (currentUser != null){
                String link = (currentUser.getAccountType().equals("job_seeker"))? "/mydashboard.jsp": "/dashboard.jsp";%>
                <li><a class="page-scroll" href="<%= link %>">My Dashboard</a></li>
                <% } %>
                <% if (currentUser == null) { %>
                <li><a class="page-scroll" href="/howitworks.jsp">How it works</a></li>
                <% } %>
                <%  // if (currentUser == null || currentUser.getAccountType().equals("employer")){ %>
                <!--<li><a class="page-scroll" href="/pricing.jsp">Pricing Plans</a></li>-->
                <% // } %>
                    <% if (currentUser == null){ %>
                <li><button class="btn btn-primary wow tada" onclick="location.href='/login.jsp'">Login / Register</button></li>
                    <% } else {  %>
                
                <li id="notification_li">
                    <span id="notification_count" style="display: none;">0</span>
                    <a href="#" id="notificationLink">Notifications</a>
                    <div id="notificationContainer">
                        <div id="notificationTitle">Notifications</div>
                        <div id="notificationsBody" class="notifications">
                            <div id="noNotifications" class="col-md-12" style="display:none !important;"> You have no new notifications! </div>
                        </div>
                        <div id="notificationFooter"><a href="/all_notifications.jsp">See All</a></div>
                    </div>
                </li>
                    <% String profileUpdateLink = (currentUser.getContactNumber() == 0 || currentUser.getDateOfBirth() == null || currentUser.getGender() == '\u0000' || currentUser.getNationality() == null)? "/complete_profile.jsp": "/edit_profile.jsp";
                    if (currentUser.getAccountType().equals("employer")){
                        profileUpdateLink = "/edit_profile.jsp";
                    }%>
                <li><span><a href="<%=profileUpdateLink%>" class="page-scroll">Welcome, <%=currentUser.getUsername()%></a></span></li>
                <li><button class="btn btn-primary wow tada" onclick="$('#logout_form').submit();">Logout</button></li>
                    <% } %>
            </ul>
        </div>
        <!-- /.navbar-collapse -->
    </div>
    <!-- /.container-fluid -->
</nav>
<form id="logout_form" action="/LogoutServlet" method="POST" style="display: none;"></form>

<script>
    var notification_ids = [];
    
    $(document).ready(function(){
        $("#notificationLink").click(function() {
            $("#notificationContainer").fadeToggle(300, function(){
                if ($("#notificationContainer").css("display") === "none"){
                    $(document).off('scroll.scrollLock');
                } else {
                    var scrollTop = $(document).scrollTop();
                    $(document).on('scroll.scrollLock', function() {
                        $(document).scrollTop(scrollTop);
                    });
                    readNotifications();
                }
            });
            $("#notification_count").fadeOut("slow");
            return false;
        });

        //Document Click
        $(document).click(function(){
            $("#notificationContainer").hide();
            $(document).off('scroll.scrollLock'); 
        });
    
    <% if (currentUser != null){ %>
            $.ajax({
                url: "/GetNotificationsServlet",
                method: "GET",
                async: true,
                data: {
                    location: "nav"
                },
                success: function(resultString) {
                    if (resultString !== "") {
                        var results = JSON.parse(resultString);
                        $("#notification_count").html(results.length);
                        if (results.length === 0){
                            $("#notification_count").hide();
                            $("#noNotifications").show();
                        } else {
                            $("#notification_count").show();
                        }
                        $(results).each(function(){
                            var id = $(this).attr("id");
                            var post_id = $(this).attr("postId");
                            var content = $(this).attr("content");
                            var image = $(this).attr("avatarPath");
                            if(typeof image === "undefined"){
                                image = "img/user-placeholder.jpg";
                            }
                            var linkURL = null;
                            if (content.indexOf("accepted") !== -1 || content.indexOf("new applicant") !== -1){
                                linkURL = "/listing.jsp?id=" + post_id;
                            } else if (content.indexOf("a new rating") !== -1){
                                linkURL = "/all_ratings.jsp";
                            } else if (content.indexOf("review") !== -1){
                                linkURL = "/review_applicants.jsp?id=" + post_id;
                            } else {
                                <% if (currentUser.getAccountType().equals("job_seeker")){%>
                                linkURL = "/mydashboard.jsp";
                                <% } else { %>
                                linkURL = "/dashboard.jsp";
                                <% } %>
                            }
                            var $div = $("<div>", {class: "notification_content", onclick: "window.location='" + linkURL + "'"});
                            var $image = $("<img>", {class: "col-md-3 notification_content_profile img-rounded img-responsive display-inline", src: image});
                            var $content = $("<div>", {class: "col-md-10 display-inline noti-bar-content"})
                            $content.append(content);
                            $div.append($image);
                            $div.append($content);
                            $(".notifications").append($div);
                            
                            notification_ids.push(id);
                        });
                        dotdot();
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.log(textStatus, errorThrown);
                }
            });
    <% } %>

        function dotdot(){
            $(".noti-bar-content").dotdotdot({
                /*  The text to add as ellipsis. */
                ellipsis    : '... ',
                /*  How to cut off the text/html: 'word'/'letter'/'children' */
                wrap        : 'word',
                /*  Wrap-option fallback to 'letter' for long words */
                fallbackToLetter: true,
                /*  jQuery-selector for the element to keep and put after the ellipsis. */
                after       : null,
                /*  Whether to update the ellipsis: true/'window' */
                watch       : false,
                /*  Optionally set a max-height, if null, the height will be measured. */
                height      : null,
                /*  Deviation for the height-option. */
                tolerance   : 0,
                /*  Callback function that is fired after the ellipsis is added,
        receives two parameters: isTruncated(boolean), orgContent(string). */
                callback    : function( isTruncated, orgContent ) {},
                lastCharacter   : {
                    /*  Remove these characters from the end of the truncated text. */
                    remove      : [ ' ', ',', ';', '.', '!', '?' ],
                    /*  Don't add an ellipsis if this array contains 
            the last character of the truncated text. */
                    noEllipsis  : []
                }
            });
        }
    });
    
    function readNotifications(){
        if (notification_ids.length > 0) {
            $.ajax({
                url: "/ReadNotificationsServlet",
                method: "GET",
                async: true,
                data: {
                    notification_ids: notification_ids.toString()
                },
                success: function(resultString) {
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.log(textStatus, errorThrown);
                }
            });
        }
    };
</script>
