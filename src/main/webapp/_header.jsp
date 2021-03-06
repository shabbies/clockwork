<%@page import="model.User"%>
<%@page import="controller.AppController"%>


<html>

<head profile="http://www.w3.org/2005/10/profile">
    <link rel="icon" type="image/png" href="/img/favicon.ico">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Workiki</title>

    <!-- Bootstrap Core CSS -->
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.js"></script>
    <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="css/bootstrap-sortable.css" type="text/css">

    <!-- Custom Fonts -->
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic,900,900italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Raleway:400,800,600,500,700,300,200,100,900' rel='stylesheet' type='text/css'>

    <link rel="stylesheet" href="font-awesome/css/font-awesome.min.css" type="text/css">

    <!-- Plugin CSS -->
    <link rel="stylesheet" href="css/animate.min.css" type="text/css">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css" type="text/css">
    <link href='fc/fullcalendar.css' rel='stylesheet' />
    <link href='fc/fullcalendar.print.css' rel='stylesheet' media='print' />
    <link href='rating/jquery.raty.css' rel='stylesheet' />
    <link href="css/bootstrap-switch.css" rel="stylesheet">
    <link href="css/whatsapp.css" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <!-- Javascript Imports -->
    <script src='fc/lib/moment.min.js'></script>
    <script src='fc/fullcalendar.min.js'></script>
    <script src='rating/jquery.raty.js'></script>

    <%  User currentUser = null;
        if (session.getAttribute("currentUser") != null) {
            currentUser = (User)session.getAttribute("currentUser");
        }
        AppController appController = null;
        if (session.getAttribute("appController") == null) {
            appController = new AppController();
            session.setAttribute("environment", appController.getEnvironment());
            session.setAttribute("appController", appController);
        }
    %>
    <% if (request.getRequestURI().indexOf("post.jsp") != -1){ %>
    <meta property="og:title"       content="<%=request.getAttribute("facebookTitle")%>" />
    <meta property="og:url"         content="<%=request.getAttribute("facebookURL")%>" />
    <meta property="og:description" content="Have fun working at Workiki!" />
    <meta property="og:image"       content="<%=request.getAttribute("facebookImage")%>" />
    <meta property="og:image:width" content="200"/>
    <meta property="og:image:height" content="100"/>
    <% } %>
</head>
<body id="page-top">