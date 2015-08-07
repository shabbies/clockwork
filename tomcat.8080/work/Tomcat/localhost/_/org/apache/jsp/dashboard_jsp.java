/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.57
 * Generated at: 2015-08-07 14:48:55 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class dashboard_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "_nav.jsp", out, false);
      out.write("\n");
      out.write("\n");
      out.write("<header class=\"main\">\n");
      out.write("    <div class=\"header-content\">\n");
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
      out.write("                        <tbody> \n");
      out.write("                            <tr> \n");
      out.write("                                <td>Bellboy</td>\n");
      out.write("                                <td>20/08/2015</td>\n");
      out.write("                                <td><span class=\"badge db-default-badge\">No Applicants</span></td>\n");
      out.write("                                <td><a href=\"/edit_post.jsp\" class=\"btn btn-warning\">Edit Job</a></td>\n");
      out.write("                            </tr>\n");
      out.write("                            <tr> \n");
      out.write("                                <td>Bellboy</td>\n");
      out.write("                                <td>21/08/2015</td>\n");
      out.write("                                <td><span class=\"badge db-default-badge\">Ongoing</span></td>\n");
      out.write("                                <td><a href=\"/listing.jsp\" class=\"btn btn-primary\"> <span class=\"badge\">4</span> Click to Hire</a></td>\n");
      out.write("                               \n");
      out.write("                            </tr>\n");
      out.write("                             <tr> \n");
      out.write("                                <td>Bellboy</td>\n");
      out.write("                                <td>18/08/2015</td>\n");
      out.write("                                <td><span class=\"badge db-default-badge\">Completed</span></td>\n");
      out.write("                                <td><a href=\"/listing.jsp?completed=true\" class=\"btn btn-success\"> Click to Review</a></td>\n");
      out.write("                               \n");
      out.write("                            </tr>\n");
      out.write("                        </tbody>\n");
      out.write("\n");
      out.write("                    </table>\n");
      out.write("\n");
      out.write("                    <div>\n");
      out.write("                        <a href=\"/create_post.jsp\" class=\"btn btn-primary\"><i class=\"fa fa-fw fa-plus\"></i> Add a New Listing</a>\n");
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
      out.write("                            <h2>Hi User!</h2> \n");
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
