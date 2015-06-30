<!DOCTYPE html>
<%@ page import="java.util.ArrayList" %>
<%@page import="model.Post"%>
<html ng-app="clockworkApp" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>clockwork - Start Bootstrap Theme</title>

    <!-- Bootstrap Core CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">

    <!-- Custom Fonts -->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic,900,900italic' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="font-awesome/css/font-awesome.min.css" type="text/css">

    <!-- Plugin CSS -->
    <link rel="stylesheet" href="css/animate.min.css" type="text/css">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <!-- Javascript Imports -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
</head>

<%
    ArrayList <Post> postList = (ArrayList <Post>)session.getAttribute("postList");
%>
<body id="page-top">
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
                <a class="navbar-brand page-scroll" href="#page-top">clockwork</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li><a class="page-scroll" href="#about">Work</a></li>
                    <li><a class="page-scroll" href="#services">Hire</a></li>
                    <li><a class="page-scroll" href="#portfolio">How it works</a></li>
                    <li><button class="btn btn-primary wow tada">Login / Register</button></li>
                </ul>
            </div>
                <!-- /.navbar-collapse -->
        </div>
            <!-- /.container-fluid -->
    </nav>

    <header>
        <div class="header-content">
            <div class="header-content-inner">
                <h1>Lets Begin!</h1>
                    <div class="header-content-btn">
                        <a href="" id="btnwork" class="btn btn-primary btn-xl">Find Work (Register now)</a>
                        <a href="" id="btnjob" class="btn btn-primary btn-xl">Post your Job (It's free)</a>
                    </div>
            </div>
        </div>
    </header>

    <section id="jobs" ng-controller="jobListCtrl">
        <div class="job-search text-center">
            <div class="container">
                <form id="searchForm">
                    <div class="input-group input-group-lg stylish-input-group">
                        <input type="text" class="form-control" id="searchText" autocomplete="off" placeholder="search keyword...">
                        <span class="input-group-btn">
                                <button class="btn btn-primary" type="button"> FIND JOBS <span class="glyphicon glyphicon-search"></span></button>
                        </span>
                    </div>
                </form>
            </div>
        </div>


        <div class="content">
            <div class="container">
                <div class="col-lg-12 search-label"> 
                    <h3>Search Results for "<span>goodie bag</span>"</h3>                             
                </div>

                
                <div class="col-lg-4">
                    <%for (Post post : postList){%>
                    <div class="job-entry">
                        <div class="row">
                            <div class="col-lg-9">
                                <h4><%=post.getHeader()%></h4>
                            </div>
                            <span class="job-entry-price pull-right primary"><strong>$<%=post.getSalary()%>.00</strong></span>   
                        </div>

                        <div class="row">
                            <div class="col-lg-12">
                                <h5><%=post.getDescription()%></h5>
                            </div>
                        </div>

                        <div class="row job-entry-apply">
                            <a href="" class="btn btn-primary btn pull-right">Apply now <i class="fa fa-check"></i></a>
                        </div>

                    </div>
                    <%}%>
                </div>
            </div>
        </div>

</div>

</section>

<hr class="grey">
<footer>
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <span class="copyright">Copyright � Clockwork 2015</span>
            </div>
            <div class="col-md-4">
                <ul class="list-inline social-buttons text-center">
                    <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                    <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                    <li><a href="#"><i class="fa fa-linkedin"></i></a></li>
                </ul>
            </div>
            <div class="col-md-4">
                <ul class="list-inline quicklinks pull-right">
                    <li><a href="#">Privacy Policy</a></li>
                    <li><a href="#">Terms of Use</a></li>
                </ul>
            </div>
        </div>
    </div>
</footer>

<!-- jQuery -->
<script src="js/jquery.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="js/bootstrap.min.js"></script>

<!-- Plugin JavaScript -->
<script src="js/jquery.easing.min.js"></script>
<script src="js/jquery.fittext.js"></script>
<script src="js/wow.min.js"></script>
<script src="js/angular.min.js"></script>

<script src="js/controllers.js"></script>

<!-- Custom Theme JavaScript -->
<script src="js/clockwork.js"></script>


<!-- Page Load Javascript -->
<script>
    $( document ).ready(function() {
        
    });
</script>
</body>
</html>
