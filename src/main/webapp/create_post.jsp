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

 <jsp:include page="_nav.jsp" />


 <header style="min-height: 100%; background-color: #ac1d39; background-image:none;">
    <div class="header-content">
        <div class="header-content-inner">
            <h2 class="text-center">Let's Create a new listing!</h2>

            <div class="row">
                <div class="col-md-6 col-md-offset-3">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <form class="form form-signup" action="/CreatePostServlet" method="POST" role="form">

                                <div class="form-group form-group-lg col-md-12 text-left"> 
                                   <label for="job-title" class="control-label">Job Title</label> 
                                   <input id="job-title" class="form-control" type="text" placeholder="" name="header" required> 
                               </div>

                               <div class="form-group col-md-12 text-left"> 
                                   <label for="job-desc" class="control-label">Job Description</label> 
                                   <textarea id="job-desc" class="form-control form-group-lg" rows="3" name="description" rows="3" required></textarea> 
                               </div>

                               <div class="form-group form-group-lg col-md-12 text-left"> 
                                   <label for="job-pay" class="control-label">Job Location</label> 
                                   <input id="job-pay" class="form-control" type="text" placeholder="" name="location" required>  
                               </div>

                               <div class="form-group form-group-lg col-md-6 text-left"> 
                                   <label for="job-pay" class="control-label">Job Date</label> 
                                   <div class="input-group"> 
                                       <div class="input-group-addon"><i class="fa fa-calendar fa-lg fa-fw"></i></div> 
                                       <input id="job-pay" class="form-control" type="text" placeholder="" name="job_date" required> </div> 
                                   </div>

                                   <div class="form-group form-group-lg col-md-6 text-left"> 
                                       <label for="job-pay" class="control-label">Pay</label> 
                                       <div class="input-group"> 
                                           <div class="input-group-addon"><i class="fa fa-dollar fa-lg fa-fw"></i></div> 
                                           <input id="job-pay" class="form-control" type="number" placeholder="" name="salary" required> </div> 
                                       </div>


                                       <input type="submit" class="btn btn-lg btn-primary" value="Next >>">

                                   </a>
                               </div>
                           </form>
                       </div>
                   </div>
               </div>
           </div>
       </div>
   </div>
</header>

<jsp:include page="_footer.jsp" />