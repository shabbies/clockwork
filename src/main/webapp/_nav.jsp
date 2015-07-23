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
            <% if (session.getAttribute("currentUser") != null) {
            User currentUser = (User)session.getAttribute("currentUser"); %>
            <!-- Gerald TODO: styling -->
            <div style="color: rgba(255,255,255,.7); float: left;">Welcome <%=currentUser.getUsername()%></div>
            <!-- END -->
            <% } %>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">
                <li><a class="page-scroll" href="#about">Work</a></li>
                <li><a class="page-scroll" href="#services">Hire</a></li>
                <li><a class="page-scroll" href="#portfolio">How it works</a></li>
                <% if (session.getAttribute("currentUser") == null){ %>
                <li><button class="btn btn-primary wow tada" onclick="location.href='/login.jsp'">Login / Register</button></li>
                <% } else { %>
                <li><button class="btn btn-primary wow tada" onclick="$('#logout_form').submit();">Logout</button></li>
                <% } %>
            </ul>
        </div>
            <!-- /.navbar-collapse -->
    </div>
            <!-- /.container-fluid -->
</nav>
            <form id="logout_form" action="/LogoutServlet" method="POST" style="display: none;"></form>