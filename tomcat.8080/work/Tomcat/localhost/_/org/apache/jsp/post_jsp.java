/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.57
 * Generated at: 2015-08-12 03:42:04 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import model.User;
import model.User;
import model.User;
import model.Post;

public final class post_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(2);
    _jspx_dependants.put("/_nav.jsp", Long.valueOf(1439195328000L));
    _jspx_dependants.put("/_header.jsp", Long.valueOf(1439195328000L));
  }

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\n");
      out.write("<html>\n");
      out.write("\n");
      out.write("<head>\n");
      out.write("    <meta charset=\"utf-8\">\n");
      out.write("    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n");
      out.write("    <meta name=\"description\" content=\"\">\n");
      out.write("    <meta name=\"author\" content=\"\">\n");
      out.write("\n");
      out.write("    <title>Clockwork</title>\n");
      out.write("\n");
      out.write("    <!-- Bootstrap Core CSS -->\n");
      out.write("    <link rel=\"stylesheet\" href=\"css/bootstrap.min.css\" type=\"text/css\">\n");
      out.write("\n");
      out.write("    <!-- Custom Fonts -->\n");
      out.write("    <link href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>\n");
      out.write("    <link href='http://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic,900,900italic' rel='stylesheet' type='text/css'>\n");
      out.write("    <link href='http://fonts.googleapis.com/css?family=Raleway:400,800,600,500,700,300,200,100,900' rel='stylesheet' type='text/css'>\n");
      out.write("\n");
      out.write("    <link rel=\"stylesheet\" href=\"font-awesome/css/font-awesome.min.css\" type=\"text/css\">\n");
      out.write("\n");
      out.write("    <!-- Plugin CSS -->\n");
      out.write("    <link rel=\"stylesheet\" href=\"css/animate.min.css\" type=\"text/css\">\n");
      out.write("\n");
      out.write("    <!-- Custom CSS -->\n");
      out.write("    <link rel=\"stylesheet\" href=\"css/style.css\" type=\"text/css\">\n");
      out.write("    <link href='fc/fullcalendar.css' rel='stylesheet' />\n");
      out.write("    <link href='fc/fullcalendar.print.css' rel='stylesheet' media='print' />\n");
      out.write("    <link href='rating/jquery.raty.css' rel='stylesheet' />\n");
      out.write("    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->\n");
      out.write("    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->\n");
      out.write("    <!--[if lt IE 9]>\n");
      out.write("    <script src=\"https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js\"></script>\n");
      out.write("    <script src=\"https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js\"></script>\n");
      out.write("    <![endif]-->\n");
      out.write("\n");
      out.write("    <!-- Javascript Imports -->\n");
      out.write("    <script src=\"https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js\"></script>\n");
      out.write("    <script src='fc/lib/moment.min.js'></script>\n");
      out.write("    <script src='fc/lib/jquery.min.js'></script>\n");
      out.write("    <script src='fc/fullcalendar.min.js'></script>\n");
      out.write("    <script src='rating/jquery.raty.js'></script>\n");
      out.write("\n");
      out.write("    ");
  User currentUser = null;
        if (session.getAttribute("currentUser") != null) {
            currentUser = (User)session.getAttribute("currentUser");
        }
    
      out.write("\n");
      out.write("</head>\n");
      out.write("\n");
      out.write("<body id=\"page-top\">");
      out.write('\n');
      out.write("\n");
      out.write("\n");
      out.write("<nav id=\"mainNav\" class=\"navbar navbar-default navbar-fixed-top\">\n");
      out.write("    <div class=\"container-fluid\">\n");
      out.write("        <!-- Brand and toggle get grouped for better mobile display -->\n");
      out.write("        <div class=\"navbar-header\">\n");
      out.write("            <button type=\"button\" class=\"navbar-toggle collapsed\" data-toggle=\"collapse\" data-target=\"#bs-example-navbar-collapse-1\">\n");
      out.write("                <span class=\"sr-only\">Toggle navigation</span>\n");
      out.write("                <span class=\"icon-bar\"></span>\n");
      out.write("                <span class=\"icon-bar\"></span>\n");
      out.write("                <span class=\"icon-bar\"></span>\n");
      out.write("            </button>\n");
      out.write("            <a class=\"navbar-brand page-scroll\" href=\"/index.jsp\">clockwork</a>\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("        <!-- Collect the nav links, forms, and other content for toggling -->\n");
      out.write("        <div class=\"collapse navbar-collapse\" id=\"bs-example-navbar-collapse-1\">\n");
      out.write("            <ul class=\"nav navbar-nav navbar-right\">\n");
      out.write("\n");
      out.write("                <li><a class=\"page-scroll\" href=\"/mydashboard.jsp\">Work <i class=\"fa fa-fw fa-bell\"></i></a></li>\n");
      out.write("\n");
      out.write("                <li><a class=\"page-scroll\" href=\"/dashboard.jsp\">Hire</a></li>\n");
      out.write("                <li><a class=\"page-scroll\" href=\"#portfolio\">How it works</a></li>\n");
      out.write("                ");
 if (currentUser == null){ 
      out.write("\n");
      out.write("                <li><button class=\"btn btn-primary wow tada\" onclick=\"location.href='/login.jsp'\">Login / Register</button></li>\n");
      out.write("                ");
 } else {  
      out.write("\n");
      out.write("                <li><span>Welcome, ");
      out.print(currentUser.getUsername());
      out.write("</span></li>\n");
      out.write("                <li><button class=\"btn btn-primary wow tada\" onclick=\"$('#logout_form').submit();\">Logout</button></li>\n");
      out.write("                ");
 } 
      out.write("\n");
      out.write("            </ul>\n");
      out.write("        </div>\n");
      out.write("        <!-- /.navbar-collapse -->\n");
      out.write("    </div>\n");
      out.write("    <!-- /.container-fluid -->\n");
      out.write("</nav>\n");
      out.write("<form id=\"logout_form\" action=\"/LogoutServlet\" method=\"POST\" style=\"display: none;\"></form>");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<header class=\"main\">\n");
      out.write("  <div class=\"header-content\">\n");
      out.write("    <div class=\"header-content-inner\">\n");
      out.write("      ");
  String postID = request.getParameter("id");
      String formURL = "/GetPostServlet?id=" + postID;
      Post post = (Post)session.getAttribute("post");
      if (post == null){
      out.write("\n");
      out.write("      ");
      if (true) {
        _jspx_page_context.forward(formURL);
        return;
      }
      out.write("\n");
      out.write("      ");
} else { session.removeAttribute("post");}
      out.write("\n");
      out.write("      ");
 if (session.getAttribute("error") != null){
      out.write("\n");
      out.write("      <div class=\"alert alert-danger\" role=\"alert\">\n");
      out.write("        <span class=\"glyphicon glyphicon-exclamation-sign\" aria-hidden=\"true\"></span>\n");
      out.write("        <span class=\"sr-only\">Error:</span>\n");
      out.write("        ");
      out.print(session.getAttribute("error"));
      out.write("\n");
      out.write("      </div>\n");
      out.write("      ");
session.removeAttribute("error");}
      out.write("\n");
      out.write("      ");
 if (session.getAttribute("message") != null){
      out.write("\n");
      out.write("      <div class=\"alert alert-danger\" role=\"alert\">\n");
      out.write("        <span class=\"glyphicon glyphicon-exclamation-sign\" aria-hidden=\"true\"></span>\n");
      out.write("        <span class=\"sr-only\">Error:</span>\n");
      out.write("        ");
      out.print(session.getAttribute("message"));
      out.write("\n");
      out.write("      </div>\n");
      out.write("      ");
session.removeAttribute("message");}
      out.write("\n");
      out.write("      <h2 class=\"text-center\"><strong>");
      out.print(post.getHeader());
      out.write("</strong> @ ");
      out.print(post.getCompany());
      out.write("</h2>\n");
      out.write("\n");
      out.write("      <div class=\"row\">\n");
      out.write("        <div class=\"col-md-12\">\n");
      out.write("          <div class=\"panel panel-default\">\n");
      out.write("            <div class=\"panel-body  grey\">\n");
      out.write("              <div class=\"col-md-7 modal-job-details\">\n");
      out.write("               <div class=\"col-md-4 text-center\">\n");
      out.write("                <img src=\"http://placehold.it/200x200\" alt=\"\" class=\"db-user-pic img-rounded img-responsive\"/>\n");
      out.write("\n");
      out.write("                <h1 id=\"modalSalary\">");
      out.print(post.getSalary());
      out.write("</h1>\n");
      out.write("              </div>\n");
      out.write("\n");
      out.write("              <div class=\"col-md-8\">\n");
      out.write("               <h4 id=\"modalHeader\"><strong>");
      out.print(post.getHeader());
      out.write("</strong> @ ");
      out.print(post.getCompany());
      out.write("</h4>\n");
      out.write("               <h4>");
      out.print(post.getLocation());
      out.write("</h4>\n");
      out.write("               <h4>");
      out.print(post.getJobDateString());
      out.write("</h4>\n");
      out.write("\n");
      out.write("               <h5>");
      out.print(post.getDescription());
      out.write("</h5>\n");
      out.write("             </div>\n");
      out.write("           </div>\n");
      out.write("           <div class=\"col-md-5 modal-job-calendar\">\n");
      out.write("            <h4><strong>Schedule for the Month</strong></h4>\n");
      out.write("            <div id=\"calendar\"></div>\n");
      out.write("          </div>\n");
      out.write("\n");
      out.write("          <div class=\"text-center\">\n");
      out.write("            <button type=\"button\" class=\"btn btn-primary btn-lg\">Apply for Job</button>\n");
      out.write("            <button type=\"button\" class=\"btn btn-warning btn-lg hidden\">Edit Job</button>\n");
      out.write("          </div>\n");
      out.write("\n");
      out.write("        </div>\n");
      out.write("      </div>\n");
      out.write("    </div>\n");
      out.write("  </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("</div>\n");
      out.write("</div>\n");
      out.write("</header>\n");
      out.write("\n");
      out.write("\n");
      out.write("<script>\n");
      out.write("\n");
      out.write("$(document).ready(function() {\n");
      out.write(" $('#calendar').fullCalendar({\n");
      out.write("  editable: false,\n");
      out.write("  allDayDefault: true,\n");
      out.write("  contentHeight: 240,\n");
      out.write("  titleFormat: 'MMMM',\n");
      out.write("  eventColor: '#ee4054',\n");
      out.write("  events: [\n");
      out.write("  {\n");
      out.write("    title: 'A Event',\n");
      out.write("    start: '2015-08-05',\n");
      out.write("    end: '2015-08-05'\n");
      out.write("  },\n");
      out.write("  {\n");
      out.write("    title: 'C Event',\n");
      out.write("    start: '2015-08-07',\n");
      out.write("    end: '2015-08-07'\n");
      out.write("  },\n");
      out.write("  {\n");
      out.write("    title: 'B Event',\n");
      out.write("    start: '2015-08-06',\n");
      out.write("    end: '2015-08-06'\n");
      out.write("  },\n");
      out.write("  {\n");
      out.write("    title: 'D Event',\n");
      out.write("    start: '2015-08-02',\n");
      out.write("    end: '2015-08-05'\n");
      out.write("  }\n");
      out.write("  ],\n");
      out.write("  eventAfterRender: function(event, element, view) {\n");
      out.write("    $(element).css('height','30px');\n");
      out.write("    $(element).css('font-weight','700');\n");
      out.write("  }/*, eventRender: function (event, element, view) { \n");
      out.write("        var dateString = event.start.format(\"YYYY-MM-DD\");\n");
      out.write("        $(view.el[0]).find('.fc-day[data-date=\"' + dateString + '\"]').css('background-color', '#ee4054');\n");
      out.write("      }*/\n");
      out.write("    });\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("});\n");
      out.write("\n");
      out.write("\n");
      out.write("</script>\n");
      out.write("\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "_footer.jsp", out, false);
      out.write('\n');
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
