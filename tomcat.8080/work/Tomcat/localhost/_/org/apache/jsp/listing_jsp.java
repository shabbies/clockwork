/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.57
 * Generated at: 2015-08-06 06:18:15 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class listing_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("\n");
      out.write("\n");
      out.write("            <div class=\"col-md-5\">\n");
      out.write("                <div class=\"panel panel-default\">\n");
      out.write("                    <div class=\"panel-body db-user\">\n");
      out.write("\n");
      out.write("                        <div class=\"text-center\">\n");
      out.write("                            <img src=\"http://placehold.it/320x150\" alt=\"\" class=\"col-centered img-rounded img-responsive\" />\n");
      out.write("                        </div>\n");
      out.write("\n");
      out.write("                        <div class=\"db-user-info\">\n");
      out.write("                            <h2>Bellboy</h2> \n");
      out.write("                            <h4>Join our team at Maison Ikkoku!</h4>\n");
      out.write("                            <h5>\n");
      out.write("                                Singaporeans / PRs preferred.</br>\n");
      out.write("                                Provide impeccable service and exceeding customer's expectations.</br>\n");
      out.write("                                Prepare and serve beverages</br>\n");
      out.write("                                Table setting and maintain cleanliness environment</br>\n");
      out.write("                                Take order and deliver food to customers</br>\n");
      out.write("                                Assist Manager/Supervisor in daily operational matters.\n");
      out.write("                            </h5>\n");
      out.write("                        </div>\n");
      out.write("                        ");
 if (request.getParameter("completed") == null) { 
      out.write("\n");
      out.write("                        <a href=\"/edit_post.jsp\" class=\"btn btn-primary btn-block\"><i class=\"fa fa-fw fa-pencil\"></i> Edit Listing</a>\n");
      out.write("                        ");
 } 
      out.write("\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("            <div class=\"col-md-7\">\n");
      out.write("                <div class=\"panel panel-default\">\n");
      out.write("\n");
      out.write("\n");
      out.write("                    <div class=\"panel-heading\"> \n");
      out.write("                        <h4>Your Applications</h4> \n");
      out.write("                    </div> \n");
      out.write("\n");
      out.write("                    ");
 if (request.getParameter("completed") == null) { 
      out.write("\n");
      out.write("\n");
      out.write("                    <table class=\"table db-job-table\"> \n");
      out.write("\n");
      out.write("                        <thead> \n");
      out.write("                            <tr> \n");
      out.write("                                <th>Name</th>\n");
      out.write("                                <th>Rating</th>\n");
      out.write("                                <th>Status</th>\n");
      out.write("                                <th>Action</th>\n");
      out.write("                            </tr>\n");
      out.write("                        </thead>\n");
      out.write("\n");
      out.write("                        <tbody> \n");
      out.write("                            <tr> \n");
      out.write("                                <td>Adam</td>\n");
      out.write("                                <td>4 star</td>\n");
      out.write("                                <td>Pending</td>\n");
      out.write("                                <td><button class=\"btn btn-success btn-hire\">Hire</button></td>\n");
      out.write("                            </tr>\n");
      out.write("                            <tr> \n");
      out.write("                                <td>Suan</td>\n");
      out.write("                                <td>3 star</td>\n");
      out.write("                                <td>Pending</td>\n");
      out.write("                                <td><button class=\"btn btn-success btn-hire\">Hire</button></td>\n");
      out.write("                            </tr>\n");
      out.write("                            <tr> \n");
      out.write("                                <td>Adam</td>\n");
      out.write("                                <td>4 star</td>\n");
      out.write("                                <td>Hired</td>\n");
      out.write("                                <td><a href=\"#\" class=\"btn btn-warning\">Message</a></td>\n");
      out.write("                            </tr>\n");
      out.write("                            <tr> \n");
      out.write("                                <td>Suan</td>\n");
      out.write("                                <td>3 star</td>\n");
      out.write("                                <td>Pending</td>\n");
      out.write("                                <td><button class=\"btn btn-success btn-hire\">Hire</button></td>\n");
      out.write("                            </tr>\n");
      out.write("                            <tr>\n");
      out.write("                                <td></td>\n");
      out.write("                                <td></td>\n");
      out.write("                                <td></td>\n");
      out.write("                                <td><button class=\"btn btn-lg btn-primary btn-hire\"><span class=\"badge\">3</span> Hire All</button></td>\n");
      out.write("                            </tr>\n");
      out.write("                        </tbody>\n");
      out.write("\n");
      out.write("                    </table>\n");
      out.write("\n");
      out.write("                    ");
 } else { 
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("                    <table class=\"table db-job-table\"> \n");
      out.write("\n");
      out.write("                        <thead> \n");
      out.write("                            <tr> \n");
      out.write("                                <th>Name</th>\n");
      out.write("                                <th>Status</th>\n");
      out.write("                                <th>Choose Rating</th>\n");
      out.write("                                <th>Leave a Review</th>\n");
      out.write("                            </tr>\n");
      out.write("                        </thead>\n");
      out.write("\n");
      out.write("                        <tbody> \n");
      out.write("                            <tr> \n");
      out.write("                                <td>Adam</td>\n");
      out.write("                                <td>Completed</td>\n");
      out.write("                                <td><div class=\"score\" data-score=\"4\"></div></td>\n");
      out.write("                                <td><button class=\"btn btn-success btn-comment\">Leave Comment</button></td>\n");
      out.write("                            </tr>\n");
      out.write("                            <tr> \n");
      out.write("                               <td>Susan</td>\n");
      out.write("                               <td>Completed</td>\n");
      out.write("                               <td><div class=\"score\" data-score=\"3\"></div></td>\n");
      out.write("                               <td><button class=\"btn btn-success btn-comment\">Leave Comment</button></td>\n");
      out.write("                           </tr>\n");
      out.write("                           <tr> \n");
      out.write("                            <td>David</td>\n");
      out.write("                            <td>Completed</td>\n");
      out.write("                            <td><div class=\"score\" data-score=\"2\"></div></td>\n");
      out.write("                            <td><button class=\"btn btn-success btn-comment\">Leave Comment</button></td>\n");
      out.write("                        </tr>\n");
      out.write("\n");
      out.write("                    </tbody>\n");
      out.write("\n");
      out.write("                </table>\n");
      out.write("\n");
      out.write("                ");
 } 
      out.write("\n");
      out.write("\n");
      out.write("            </div> \n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("    </div>\n");
      out.write("\n");
      out.write("</div>\n");
      out.write("</header>\n");
      out.write("\n");
      out.write("\n");
      out.write("<!-- Hire Modal -->\n");
      out.write("<div class=\"modal fade\" id=\"hireModal\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"hireModalLabel\">\n");
      out.write("  <div class=\"modal-dialog\" role=\"document\">\n");
      out.write("    <div class=\"modal-content\">\n");
      out.write("      <div class=\"modal-header\">\n");
      out.write("        <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\n");
      out.write("\n");
      out.write("    </div>\n");
      out.write("    <div class=\"modal-body payment-mode text-center\">\n");
      out.write("\n");
      out.write("       <h4>Choose your preferred mode of payment</h4>\n");
      out.write("\n");
      out.write("       <button class=\"btn btn-lg btn-primary\">Credit Card</button>\n");
      out.write("       <button class=\"btn btn-lg btn-primary\">iBanking</button>\n");
      out.write("       <button class=\"btn btn-lg btn-primary\">Paypal</button>\n");
      out.write("   </div>\n");
      out.write("   <div class=\"modal-footer\">\n");
      out.write("    <button type=\"button\" class=\"btn btn-default\" data-dismiss=\"modal\">Close</button>\n");
      out.write("</div>\n");
      out.write("</div>\n");
      out.write("</div>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("<script>\n");
      out.write("\n");
      out.write("$(document).on(\"click\", \".btn-hire\", function() {\n");
      out.write("    $('#hireModal').modal('show');\n");
      out.write("});\n");
      out.write("</script>\n");
      out.write("<!-- End of Hire Modal -->\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!-- Comment Modal -->\n");
      out.write("<div class=\"modal fade\" id=\"commentModal\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"commentModalLabel\">\n");
      out.write("  <div class=\"modal-dialog\" role=\"document\">\n");
      out.write("    <div class=\"modal-content\">\n");
      out.write("      <div class=\"modal-header\">\n");
      out.write("        <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\n");
      out.write("\n");
      out.write("    </div>\n");
      out.write("    <div class=\"modal-body payment-mode text-center\">\n");
      out.write("\n");
      out.write("       <h4>Leave a comment</h4>\n");
      out.write("\n");
      out.write("       <textarea class=\"form-control\" style=\"min-width: 100%\"></textarea>\n");
      out.write("   </div>\n");
      out.write("   <div class=\"modal-footer\">\n");
      out.write("     <button type=\"button\" class=\"btn btn-default\" data-dismiss=\"modal\">Close</button>\n");
      out.write("     <button type=\"button\" class=\"btn btn-primary\">Submit</button>\n");
      out.write(" </div>\n");
      out.write("</div>\n");
      out.write("</div>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("<script>\n");
      out.write("\n");
      out.write("$(document).on(\"click\", \".btn-comment\", function() {\n");
      out.write("    $('#commentModal').modal('show');\n");
      out.write("});\n");
      out.write("</script>\n");
      out.write("<!-- End of Hire Modal -->\n");
      out.write("\n");
      out.write("\n");
      out.write("<script>\n");
      out.write("\n");
      out.write("$.fn.raty.defaults.path = '../rating/images';\n");
      out.write("\n");
      out.write("$(function() {\n");
      out.write("\n");
      out.write("    $('.score').raty({\n");
      out.write("      score: function() {\n");
      out.write("        return $(this).attr('data-score');\n");
      out.write("    }\n");
      out.write("});\n");
      out.write("});\n");
      out.write("</script>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "_javascript_checker.jsp", out, false);
      out.write('\n');
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