/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.57
 * Generated at: 2015-08-13 01:03:28 UTC
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
import java.util.ArrayList;
import model.Post;

public final class dashboard_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(2);
    _jspx_dependants.put("/_nav.jsp", Long.valueOf(1439427303000L));
    _jspx_dependants.put("/_header.jsp", Long.valueOf(1439194542000L));
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
      out.write("               ");
 if (currentUser == null){ 
      out.write("\n");
      out.write("               <li><a class=\"page-scroll\" href=\"/register_job_seeker.jsp\">Work <i class=\"fa fa-fw fa-bell hidden\"></i></a></li>\n");
      out.write("               <li><a class=\"page-scroll\" href=\"/create_post.jsp\">Hire</a></li>\n");
      out.write("               ");
 } else {  
      out.write("\n");
      out.write("               ");
 String link = (currentUser.getAccountType().equals("job_seeker"))? "/mydashboard.jsp": "/dashboard.jsp";
      out.write("\n");
      out.write("               <li><a class=\"page-scroll\" href=\"");
      out.print( link );
      out.write("\">My Dashboard</a></li>\n");
      out.write("               ");
 } 
      out.write("\n");
      out.write("\n");
      out.write("               <li><a class=\"page-scroll\" href=\"#portfolio\">How it works</a></li>\n");
      out.write("               ");
 if (currentUser == null){ 
      out.write("\n");
      out.write("               <li><button class=\"btn btn-primary wow tada\" onclick=\"location.href='/login.jsp'\">Login / Register</button></li>\n");
      out.write("               ");
 } else {  
      out.write("\n");
      out.write("               <li><span>Welcome, ");
      out.print(currentUser.getUsername());
      out.write("</span></li>\n");
      out.write("               <li><button class=\"btn btn-primary wow tada\" onclick=\"$('#logout_form').submit();\">Logout</button></li>\n");
      out.write("               ");
 } 
      out.write("\n");
      out.write("           </ul>\n");
      out.write("       </div>\n");
      out.write("       <!-- /.navbar-collapse -->\n");
      out.write("   </div>\n");
      out.write("   <!-- /.container-fluid -->\n");
      out.write("</nav>\n");
      out.write("<form id=\"logout_form\" action=\"/LogoutServlet\" method=\"POST\" style=\"display: none;\"></form>");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
  
    if (currentUser == null){
        session.setAttribute("error", "Please login or register first before viewing your job applications!");
        response.sendRedirect("/login.jsp");
        return;
    } else if (!currentUser.getAccountType().equals("employer")){
        session.setAttribute("error", "Only employers can view job applications!");
        response.sendRedirect("/index.jsp");
        return;
    }

    ArrayList <Post> publishedList = (ArrayList <Post>)session.getAttribute("publishedList"); 
    if (publishedList == null){ 
      out.write("\n");
      out.write("        ");
      if (true) {
        _jspx_page_context.forward("/GetAllListedJobsServlet");
        return;
      }
      out.write("\n");
      out.write("    ");
} else { 
        session.removeAttribute("publishedList");
    }       
    if (currentUser == null){
        session.setAttribute("error", "Please login or register first before viewing your job applications!");
        response.sendRedirect("/login.jsp");
        return;
    } else if (!currentUser.getAccountType().equals("employer")){
        session.setAttribute("error", "Only employers can view job applications!");
        response.sendRedirect("/index.jsp");
        return;
    }
      out.write("\n");
      out.write("\n");
      out.write("<header class=\"main\">\n");
      out.write("    <div class=\"header-content\">\n");
      out.write("        ");
 if (session.getAttribute("error") != null){
      out.write("\n");
      out.write("        <div class=\"alert alert-danger\" role=\"alert\">\n");
      out.write("            <span class=\"glyphicon glyphicon-exclamation-sign\" aria-hidden=\"true\"></span>\n");
      out.write("            <span class=\"sr-only\">Error:</span>\n");
      out.write("            ");
      out.print(session.getAttribute("error"));
      out.write("\n");
      out.write("        </div>\n");
      out.write("        ");
session.removeAttribute("error");}
      out.write("\n");
      out.write("        ");
 if (session.getAttribute("message") != null){
      out.write("\n");
      out.write("        <div class=\"alert alert-success\" role=\"alert\">\n");
      out.write("            <span class=\"glyphicon glyphicon-ok-sign\" aria-hidden=\"true\"></span>\n");
      out.write("            ");
      out.print(session.getAttribute("message"));
      out.write("\n");
      out.write("        </div>\n");
      out.write("        ");
session.removeAttribute("message");}
      out.write("\n");
      out.write("\n");
      out.write("        <div class=\"row\">\n");
      out.write("            <div class=\"col-md-8\">\n");
      out.write("                <div class=\"panel panel-default\">\n");
      out.write("\n");
      out.write("\n");
      out.write("                    <div class=\"panel-heading\"> \n");
      out.write("                        <h4>Your Job Listings</h4> \n");
      out.write("                    </div> \n");
      out.write("\n");
      out.write("                    <table class=\"table db-job-table\"> \n");
      out.write("\n");
      out.write("                        <thead> \n");
      out.write("                            <tr> \n");
      out.write("                                <th>Job</th>\n");
      out.write("                                <th>Date</th>\n");
      out.write("                                <th>Status</th>\n");
      out.write("                                 <th>Action</th>\n");
      out.write("                            </tr>\n");
      out.write("                        </thead>\n");
      out.write("\n");
      out.write("                        <tbody>\n");
      out.write("                            ");
 for (Post post : publishedList){
      out.write("\n");
      out.write("                            <tr> \n");
      out.write("                                <td>");
      out.print(post.getHeader());
      out.write("</td>\n");
      out.write("                                <td>");
      out.print(post.getJobDateString());
      out.write("</td>\n");
      out.write("                                ");
 if (post.getStatus().equals("listed")){
                                    String redirectURL = "/edit_post.jsp?id=" + post.getId(); 
      out.write("\n");
      out.write("                                    <td><span class=\"badge db-default-badge\">No Applicants</span></td>\n");
      out.write("                                    <td><a href=\"");
      out.print(redirectURL);
      out.write("\" class=\"btn btn-warning\">Edit Job</a></td>\n");
      out.write("                                ");
 } else if (post.getStatus().equals("applied")){
                                    String redirectURL = "/listing.jsp?id=" + post.getId();
      out.write("\n");
      out.write("                                    <td><span class=\"badge db-default-badge\">Ongoing</span></td>\n");
      out.write("                                    <td><a href=\"");
      out.print(redirectURL);
      out.write("\" class=\"btn btn-primary\"> <span class=\"badge\">");
      out.print(post.getApplicantCount());
      out.write("</span> Click to Hire</a></td>\n");
      out.write("                                ");
 } else { 
      out.write("\n");
      out.write("                                    <td><span class=\"badge db-default-badge\">Completed</span></td>\n");
      out.write("                                    <td><a href=\"/listing.jsp?completed=true\" class=\"btn btn-success\"> Click to Review</a></td>\n");
      out.write("                                ");
}
      out.write("\n");
      out.write("                            </tr>\n");
      out.write("                            ");
}
      out.write("\n");
      out.write("                        </tbody>\n");
      out.write("                    </table>\n");
      out.write("\n");
      out.write("                    <div>\n");
      out.write("                        <a href=\"/create_post.jsp\" class=\"btn btn-primary\"><i class=\"fa fa-fw fa-plus\"></i> Post a new Job</a>\n");
      out.write("                    </div>\n");
      out.write("                </div> \n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("            <div class=\"col-md-4\">\n");
      out.write("                <div class=\"panel panel-default\">\n");
      out.write("                    <div class=\"panel-body db-user\">\n");
      out.write("\n");
      out.write("                        <div class=\"text-center\">\n");
      out.write("                            <img src=\"http://placehold.it/120x120\" alt=\"\" class=\"db-user-pic col-centered img-rounded img-responsive\" />\n");
      out.write("                        </div>\n");
      out.write("\n");
      out.write("                        <div class=\"db-user-info\">\n");
      out.write("                            <h2>Hi ");
      out.print(currentUser.getUsername());
      out.write("!</h2> \n");
      out.write("                            <span>What would you like to do today?</span>\n");
      out.write("                        </div>\n");
      out.write("                        <a href=\"/edit_profile.jsp\" class=\"btn btn-primary btn-block\"><i class=\"fa fa-fw fa-plus\"></i> Complete my Profile</a>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("    </div>\n");
      out.write("</header>\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "_footer.jsp", out, false);
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
