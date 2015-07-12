<!DOCTYPE html>
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
    <jsp:include page="_nav.jsp" />

    <header style="min-height: 100%; background-color: #ac1d39; background-image:none;">
        <div class="header-content">
            <div class="header-content-inner">
                <h2 class="text-center">Hello!</h2>
                <h3 class="text-center">Hiring on Clockwork is simple & effective. Give it a go!</h3>

                <div class="row">
                    <div class="col-md-6 col-md-offset-3">
                        <div class="panel panel-default">
                            <div class="panel-body">

                                <form class="form form-signup" action="/RegisterAccountServlet" method="POST" role="form">

                                    <div class="form-group form-group-lg col-md-12 text-left"> 
                                       <label for="register-company" class="control-label">Company Name</label> 
                                       <div class="input-group"> 
                                           <div class="input-group-addon"><i class="fa fa-building fa-lg fa-fw"></i></div> 
                                           <input id="register-company" class="form-control" type="text" placeholder="Company Name..." name="company_name" required> </div> 
                                       </div>

                                       <div class="form-group form-group-lg col-md-12 text-left"> 
                                           <label for="register-email" class="control-label">Email Address</label> 
                                           <div class="input-group"> 
                                               <div class="input-group-addon"><i class="fa fa-envelope fa-lg fa-fw"></i></div> 
                                               <input id="register-email" class="form-control" type="email" placeholder="Email address…" name="email" required> </div> 
                                           </div>

                                           <div class="form-group form-group-lg col-md-12 text-left"> 
                                               <label for="register-password" class="control-label">Password</label> 
                                               <div class="input-group"> 
                                                   <div class="input-group-addon"><i class="fa fa-lock fa-lg fa-fw"></i></div> 
                                                   <input id="register-password" class="form-control" type="pasword" placeholder="Password…" name="password" required> </div> 
                                               </div>

                                               <input type="hidden" name="account_type" value="employer">
                                               <input class="btn btn-lg btn-primary" type="submit" value="Create Account">


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
