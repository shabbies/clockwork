<!DOCTYPE html>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Post"%>
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

<body id="page-top">
    <jsp:include page="_header.jsp" />

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
                    <form action="/GetAllPostsServlet" method="GET">
                        <input type="submit" value="Login">
                    </form>                         
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
                <span class="copyright">Copyright © Clockwork 2015</span>
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

<!-- Custom Theme JavaScript -->
<script src="js/clockwork.js"></script>

</body>
</html>
