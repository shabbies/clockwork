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

<% ArrayList <Post> postList = (ArrayList <Post>)session.getAttribute("postList"); %>
<body id="page-top">
    
 <jsp:include page="_nav.jsp" />
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


    <div class="main">
        <div class="container">

            <div class="col-lg-12 search-label"> 
                <h3>Search Results for "<span>goodie bag</span>"</h3>                             
            </div>

            <%for (Post post : postList){%>

            <div class="col-lg-4">

                <div class="job-entry">

                    <div class="row">
                        <div class="col-lg-9">
                            <h4><%=post.getHeader()%></h4>
                        </div>

                        <span class="job-entry-price pull-right primary"><strong>$<%=post.getSalary()%>/hr</strong></span>   
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

            </div>

            <%}%>

        </div>
    </div>

</div>

</section>

<jsp:include page="_footer.jsp" />






