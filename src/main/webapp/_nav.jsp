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
            <a class="navbar-brand page-scroll" href="/index.jsp">clockwork</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">

                <% if (currentUser == null){ %>
                    <!--
                    <li><a class="page-scroll" href="/register_job_seeker.jsp">Work <i class="fa fa-fw fa-bell hidden"></i></a></li>
                    <li><a class="page-scroll" href="/create_post.jsp">Hire</a></li>
                    -->
                <% } else {  %>
                    <% String link = (currentUser.getAccountType().equals("job_seeker"))? "/mydashboard.jsp": "/dashboard.jsp";%>
                    <li><a class="page-scroll" href="<%= link %>">My Dashboard</a></li>
                <% } %>

                <li><a class="page-scroll" href="#portfolio">How it works</a></li>
                <% if (currentUser == null){ %>
                    <li><button class="btn btn-primary wow tada" onclick="location.href='/login.jsp'">Login / Register</button></li>
                <% } else {  %>
                  
                    <li id="notification_li">
                        <span id="notification_count">3</span>
                        <a href="#" id="notificationLink">Notifications</a>
                        <div id="notificationContainer">
                        <div id="notificationTitle">Notifications</div>
                        <div id="notificationsBody" class="notifications">
                            <div class="notification_content">
                                <img src="img/user-placeholder.jpg" alt="" class="col-md-3 notification_content_profile img-rounded img-responsive display-inline" />
                                <div class="col-md-9 display-inline">kennethsohsc has just offered you a job! Click here to accept it now!</div>
                            </div>
                            <div class="notification_content">
                                <img src="img/user-placeholder.jpg" alt="" class="col-md-3 notification_content_profile img-rounded img-responsive display-inline" />
                                <div class="col-md-10 display-inline">kennethsohsc has just offered you a job! Click here to accept it now!</div>
                            </div>
                        </div>
                        <div id="notificationFooter"><a href="#">See All</a></div>
                        </div>
                    </li>
                    <li><span>Welcome, <%=currentUser.getUsername()%></span></li>
                    <li><button class="btn btn-primary wow tada" onclick="$('#logout_form').submit();">Logout</button></li>
               <% } %>
           </ul>
       </div>
       <!-- /.navbar-collapse -->
   </div>
   <!-- /.container-fluid -->
</nav>
<form id="logout_form" action="/LogoutServlet" method="POST" style="display: none;"></form>

<script type="text/javascript" >
$(document).ready(function(){
    $("#notificationLink").click(function() {
        $("#notificationContainer").fadeToggle(300);
        $("#notification_count").fadeOut("slow");
        return false;
    });

    //Document Click
    $(document).click(function(){
        $("#notificationContainer").hide();
    });
    //Popup Click
    $("#notificationContainer").click(function(){
        return false
    });
    
    <% if (currentUser != null){ %>
        $.ajax({
            url: 'https://clockwork-api.herokuapp.com/api/v1/users/get_unread_notifications',
            dataType: 'json',
            method: "POST",
            async: true,
            beforeSend: function(xhr){
                xhr.setRequestHeader('Authentication-Token', "<%=currentUser.getAuthenticationToken()%>");
            },
            data: {
                email: "<%=currentUser.getEmail()%>"
            },
            success: function(resultString) {
                var result = JSON.parse(resultString);
            },
            error: function(jqXHR, textStatus, errorThrown) {
              console.log(textStatus, errorThrown);
            }
        });
    <% } %>

});
</script>