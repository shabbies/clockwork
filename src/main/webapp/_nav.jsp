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

                <li><a class="page-scroll" href="/howitworks.jsp">How it works</a></li>
                <li><a class="page-scroll" href="/pricing.jsp">Pricing Plans</a></li>
                <% if (currentUser == null){ %>
                    <li><button class="btn btn-primary wow tada" onclick="location.href='/login.jsp'">Login / Register</button></li>
                <% } else {  %>
                    <% String profileUpdateLink = (currentUser.getContactNumber() == 0 || currentUser.getDateOfBirth() == null || currentUser.getGender() == '\u0000' || currentUser.getNationality() == null)? "/complete_profile.jsp": "/edit_profile.jsp";%>
                    <li><a href="<%=profileUpdateLink%>" class="page-scroll">Welcome, <%=currentUser.getUsername()%></a></li>
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
   
});
</script>