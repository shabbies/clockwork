/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.57
 * Generated at: 2015-08-10 02:44:42 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.ArrayList;
import model.Post;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

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

      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "_header.jsp", out, false);
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
  ArrayList <Post> postList = (ArrayList <Post>)session.getAttribute("postList"); 
if (postList == null){
      if (true) {
        _jspx_page_context.forward("/GetAllPostsServlet");
        return;
      }
}
      out.write('\n');
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "_nav.jsp", out, false);
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "_hero.jsp", out, false);
      out.write("\n");
      out.write("\n");
      out.write("<section id=\"jobs\" ng-controller=\"jobListCtrl\">\n");
      out.write("    <div class=\"job-search text-center\">\n");
      out.write("\n");
      out.write("        <div class=\"container\">\n");
      out.write("            <form id=\"searchForm\">\n");
      out.write("                <div class=\"input-group input-group-lg stylish-input-group\">\n");
      out.write("                    <input type=\"text\" class=\"form-control\" id=\"searchText\" autocomplete=\"off\" placeholder=\"search keyword...\">\n");
      out.write("                    <span class=\"input-group-btn\">\n");
      out.write("                        <button class=\"btn btn-primary\" type=\"button\"> FIND JOBS <span class=\"glyphicon glyphicon-search\"></span></button>\n");
      out.write("                    </span>\n");
      out.write("                </div>\n");
      out.write("            </form>\n");
      out.write("        </div>\n");
      out.write("    </div>\n");
      out.write("    <div class=\"container\">\n");
      out.write("\n");
      out.write("        <div class=\"col-lg-12 search-label\"> \n");
      out.write("            <h3>Search Results for \"<span>goodie bag</span>\"</h3>                             \n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("        ");
for (Post post : postList){
      out.write("\n");
      out.write("\n");
      out.write("        <div class=\"col-lg-4\">\n");
      out.write("\n");
      out.write("            <div class=\"job-entry\">\n");
      out.write("                <div class=\"job-entry-desc\">\n");
      out.write("                    <div class=\"row\">\n");
      out.write("                        <div class=\"col-xs-9\">\n");
      out.write("                            <h4><strong>");
      out.print(post.getHeader());
      out.write("</strong></h4>\n");
      out.write("                            <h5>Resort World Singapore\n");
      out.write("                            </br>\n");
      out.write("                            <i class=\"fa fa-map-marker primary\"></i> \n");
      out.write("                            Bishan\n");
      out.write("                        </h5>\n");
      out.write("                    </div>\n");
      out.write("                    <span class=\"job-entry-price pull-right primary\"><strong>$");
      out.print(post.getSalary());
      out.write("/hr</strong></span>\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("                <div class=\"row\">\n");
      out.write("                    <div class=\"col-xs-12\">\n");
      out.write("                        <h5>");
      out.print(post.getDescription());
      out.write(" Lorem ipsum dolor sit amet, consectetur adipisicing elit. Fuga repellat corrupti nam provident praesentium vel! Nobis vel distinctio deserunt similique, nemo, voluptate a rem excepturi cumque ut quam quia minima.</br></br>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Fuga repellat corrupti nam provident praesentium vel! Nobis vel distinctio deserunt similique, nemo, voluptate a rem excepturi cumque ut quam quia minima.</h5>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("            <div class=\"row job-entry-apply\" id=\"open-jobModal\" data-header=\"");
      out.print( post.getHeader());
      out.write("\" data-desc=\"");
      out.print(post.getDescription());
      out.write("\" data-salary=\"$");
      out.print(post.getSalary());
      out.write("/hr\">\n");
      out.write("               <div class=\"col-xs-6\"> \n");
      out.write("                <div class=\"detailIconsDiv\">\n");
      out.write("                    <ul class=\"list-inline text-left\">\n");
      out.write("                        <li class=\"detailIcons\"><a href=\"#\" class=\"whitelink\"><i class=\"fa fa-dollar\"></i></a></li>\n");
      out.write("                        <li class=\"detailIcons\"><a href=\"#\" class=\"whitelink\"><i class=\"fa fa-cutlery\"></i></a></li>\n");
      out.write("                        <li class=\"detailIcons\"><a href=\"#\" class=\"whitelink\"><i class=\"fa fa-compass\"></i></a></li>\n");
      out.write("                    </ul>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("            <div class=\"col-xs-6\">\n");
      out.write("                <a href=\"#\"  class=\"btn btn-primary btn pull-right\">Apply now <i class=\"fa fa-check\"></i></a>\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("    </div>\n");
      out.write("\n");
      out.write("</div>\n");
      out.write("\n");
}
      out.write("\n");
      out.write("\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("</section>\n");
      out.write("\n");
      out.write("<hr class=\"grey\">\n");
      out.write("<footer>\n");
      out.write("    <div class=\"container\">\n");
      out.write("        <div class=\"row\">\n");
      out.write("            <div class=\"col-md-4 col-xs-4\">\n");
      out.write("                <span class=\"copyright\">Copyright © Clockwork 2015</span>\n");
      out.write("            </div>\n");
      out.write("            <div class=\"col-md-4 col-xs-4\">\n");
      out.write("                <ul class=\"list-inline social-buttons text-center\">\n");
      out.write("                    <li><a href=\"#\"><i class=\"fa fa-twitter\"></i></a>\n");
      out.write("                    </li>\n");
      out.write("                    <li><a href=\"#\"><i class=\"fa fa-facebook\"></i></a>\n");
      out.write("                    </li>\n");
      out.write("                    <li><a href=\"#\"><i class=\"fa fa-linkedin\"></i></a>\n");
      out.write("                    </li>\n");
      out.write("                </ul>\n");
      out.write("            </div>\n");
      out.write("            <div class=\"col-md-4 col-xs-4\">\n");
      out.write("                <ul class=\"list-inline quicklinks pull-right\">\n");
      out.write("                    <li><a href=\"#\">Privacy Policy</a>\n");
      out.write("                    </li>\n");
      out.write("                    <li><a href=\"#\">Terms of Use</a>\n");
      out.write("                    </li>\n");
      out.write("                </ul>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("    </div>\n");
      out.write("</footer>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!-- Job Modal -->\n");
      out.write("<div class=\"modal fade\" id=\"jobModal\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"jobModalLabel\">\n");
      out.write("  <div class=\"modal-dialog modal-lg\" role=\"document\">\n");
      out.write("    <div class=\"modal-content\">\n");
      out.write("      <div class=\"modal-header\">\n");
      out.write("        <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\n");
      out.write("\n");
      out.write("    </div>\n");
      out.write("    <div class=\"modal-body\">\n");
      out.write("\n");
      out.write("       <div class=\"col-md-7 modal-job-details\">\n");
      out.write("           <div class=\"col-md-4 text-center\">\n");
      out.write("            <img src=\"http://placehold.it/120x120\" alt=\"\" class=\"db-user-pic img-rounded img-responsive\"/>\n");
      out.write("            \n");
      out.write("            <h2 id=\"modalSalary\">$10/hr</h2>\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("        <div class=\"col-md-8\">\n");
      out.write("            <h4 id=\"modalHeader\"><strong>Bellboy</strong> @ HardRock Hotel</h4>\n");
      out.write("            <h5>Resort World Singapore</h5>\n");
      out.write("            <h5>21/08/2015</h5>\n");
      out.write("\n");
      out.write("            <h5 id=\"modalDesc\">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Fuga repellat corrupti nam provident praesentium vel! Nobis vel distinctio deserunt similique, nemo, voluptate a rem excepturi cumque ut quam quia minima.</br></br>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Fuga repellat corrupti nam provident praesentium vel! Nobis vel distinctio deserunt similique, nemo, voluptate a rem excepturi cumque ut quam quia minima.\n");
      out.write("            </h5>\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("    </div>\n");
      out.write("\n");
      out.write("    <div class=\"col-md-5 modal-job-calendar\">\n");
      out.write("        <h4><strong>Schedule for the Month</strong></h4>\n");
      out.write("        <div id=\"calendar\"></div>\n");
      out.write("    </div>\n");
      out.write("</div>\n");
      out.write("<div class=\"modal-footer\">\n");
      out.write("   <div class=\"pull-right\" style=\"padding-right: 15px;\">\n");
      out.write("    <button type=\"button\" class=\"btn btn-default btn-lg\" data-dismiss=\"modal\">Close</button>\n");
      out.write("    <button type=\"button\" class=\"btn btn-primary btn-lg\">Apply for Job</button>\n");
      out.write("</div>\n");
      out.write("</div>\n");
      out.write("</div>\n");
      out.write("</div>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("<script>\n");
      out.write("\n");
      out.write("$(document).on(\"click\", \"#open-jobModal\", function() {\n");
      out.write("    var headerText = $(this).data('header');\n");
      out.write("    var descText = $(this).data('desc');\n");
      out.write("    var salaryText = $(this).data('salary');\n");
      out.write("\n");
      out.write("    $('#jobModalLabel').html(headerText);\n");
      out.write("    $('#modalHeader').html(headerText);\n");
      out.write("    $('#modalDesc').html(descText);\n");
      out.write("    $('#modalSalary').html(salaryText);\n");
      out.write("\n");
      out.write("\n");
      out.write("    $('#jobModal').modal('show');\n");
      out.write("});\n");
      out.write("\n");
      out.write("$('#jobModal').on('shown.bs.modal', function () {\n");
      out.write("   $(\"#calendar\").fullCalendar('render');\n");
      out.write("});\n");
      out.write("</script>\n");
      out.write("<!-- End of Job Modal -->\n");
      out.write("\n");
      out.write("\n");
      out.write("<script>\n");
      out.write("\n");
      out.write("$(document).ready(function() {\n");
      out.write("   $('#jobModal').modal('show');\n");
      out.write("   $('#calendar').fullCalendar({\n");
      out.write("    editable: false,\n");
      out.write("    allDayDefault: true,\n");
      out.write("    contentHeight: 240,\n");
      out.write("    titleFormat: 'MMMM',\n");
      out.write("    eventColor: '#ee4054',\n");
      out.write("    events: [\n");
      out.write("    {\n");
      out.write("        title: 'A Event',\n");
      out.write("        start: '2015-08-05',\n");
      out.write("        end: '2015-08-05'\n");
      out.write("    },\n");
      out.write("    {\n");
      out.write("        title: 'C Event',\n");
      out.write("        start: '2015-08-07',\n");
      out.write("        end: '2015-08-07'\n");
      out.write("    },\n");
      out.write("    {\n");
      out.write("        title: 'B Event',\n");
      out.write("        start: '2015-08-06',\n");
      out.write("        end: '2015-08-06'\n");
      out.write("    },\n");
      out.write("    {\n");
      out.write("        title: 'D Event',\n");
      out.write("        start: '2015-08-02',\n");
      out.write("        end: '2015-08-05'\n");
      out.write("    }\n");
      out.write("    ],\n");
      out.write("    eventAfterRender: function(event, element, view) {\n");
      out.write("      $(element).css('height','30px');\n");
      out.write("      $(element).css('font-weight','700');\n");
      out.write("  }/*, eventRender: function (event, element, view) { \n");
      out.write("        var dateString = event.start.format(\"YYYY-MM-DD\");\n");
      out.write("        $(view.el[0]).find('.fc-day[data-date=\"' + dateString + '\"]').css('background-color', '#ee4054');\n");
      out.write("    }*/\n");
      out.write("});\n");
      out.write("\n");
      out.write("\n");
      out.write("   $(\".job-entry-desc\").dotdotdot({\n");
      out.write("    /*  The text to add as ellipsis. */\n");
      out.write("    ellipsis    : '... ',\n");
      out.write("    /*  How to cut off the text/html: 'word'/'letter'/'children' */\n");
      out.write("    wrap        : 'word',\n");
      out.write("    /*  Wrap-option fallback to 'letter' for long words */\n");
      out.write("    fallbackToLetter: true,\n");
      out.write("    /*  jQuery-selector for the element to keep and put after the ellipsis. */\n");
      out.write("    after       : null,\n");
      out.write("    /*  Whether to update the ellipsis: true/'window' */\n");
      out.write("    watch       : false,\n");
      out.write("    /*  Optionally set a max-height, if null, the height will be measured. */\n");
      out.write("    height      : null,\n");
      out.write("    /*  Deviation for the height-option. */\n");
      out.write("    tolerance   : 0,\n");
      out.write("        /*  Callback function that is fired after the ellipsis is added,\n");
      out.write("        receives two parameters: isTruncated(boolean), orgContent(string). */\n");
      out.write("        callback    : function( isTruncated, orgContent ) {},\n");
      out.write("        lastCharacter   : {\n");
      out.write("            /*  Remove these characters from the end of the truncated text. */\n");
      out.write("            remove      : [ ' ', ',', ';', '.', '!', '?' ],\n");
      out.write("            /*  Don't add an ellipsis if this array contains \n");
      out.write("            the last character of the truncated text. */\n");
      out.write("            noEllipsis  : []\n");
      out.write("        }\n");
      out.write("    });\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("});\n");
      out.write("\n");
      out.write("\n");
      out.write("</script>\n");
      out.write("\n");
      out.write("\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "_footer.jsp", out, false);
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
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
