/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.57
 * Generated at: 2015-07-21 12:59:04 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class create_005fpost_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("  <div class=\"header-content\">\n");
      out.write("    <div class=\"header-content-inner\">\n");
      out.write("      <h2 class=\"text-center\">Let's Create a new listing!</h2>\n");
      out.write("\n");
      out.write("      <div class=\"row\">\n");
      out.write("        <div class=\"col-md-6 col-md-offset-3\">\n");
      out.write("          <div class=\"panel panel-default\">\n");
      out.write("            <div class=\"panel-body\">\n");
      out.write("              <form class=\"form form-signup\" action=\"/CreatePostServlet\" method=\"POST\" role=\"form\">\n");
      out.write("\n");
      out.write("                <div class=\"form-group form-group-lg col-md-12 text-left\"> \n");
      out.write("                 <label for=\"job-title\" class=\"control-label\">Job Title</label> \n");
      out.write("                 <input id=\"job-title\" class=\"form-control\" type=\"text\" placeholder=\"\" name=\"header\" required> \n");
      out.write("               </div>\n");
      out.write("\n");
      out.write("               <div class=\"form-group col-md-12 text-left\"> \n");
      out.write("                 <label for=\"job-desc\" class=\"control-label\">Job Description</label> \n");
      out.write("                 <textarea id=\"job-desc\" class=\"form-control form-group-lg\" rows=\"3\" name=\"description\" rows=\"3\" required></textarea> \n");
      out.write("               </div>\n");
      out.write("\n");
      out.write("               <div class=\"form-group form-group-lg col-md-12 text-left\"> \n");
      out.write("                 <label for=\"job-pay\" class=\"control-label\">Job Location</label> \n");
      out.write("                 <input id=\"job-pay\" class=\"form-control\" type=\"text\" placeholder=\"\" name=\"location\" required>  \n");
      out.write("               </div>\n");
      out.write("\n");
      out.write("               <div class=\"form-group form-group-lg col-md-6 text-left\"> \n");
      out.write("                 <label for=\"job-pay\" class=\"control-label\">Job Date</label> \n");
      out.write("                 <div class=\"input-group\"> \n");
      out.write("                   <div class=\"input-group-addon\"><i class=\"fa fa-calendar fa-lg fa-fw\"></i></div> \n");
      out.write("                   <input id=\"job-pay\" class=\"form-control\" type=\"date\" placeholder=\"\" name=\"job_date\" required> \n");
      out.write("                 </div> \n");
      out.write("               </div>\n");
      out.write("\n");
      out.write("               <div class=\"form-group form-group-lg col-md-6 text-left\"> \n");
      out.write("                 <label for=\"job-pay\" class=\"control-label\">Pay</label> \n");
      out.write("                 <div class=\"input-group\"> \n");
      out.write("                   <div class=\"input-group-addon\"><i class=\"fa fa-dollar fa-lg fa-fw\"></i></div> \n");
      out.write("                   <input id=\"job-pay\" class=\"form-control\" type=\"number\" placeholder=\"\" name=\"salary\" required> \n");
      out.write("                 </div> \n");
      out.write("               </div>\n");
      out.write("\n");
      out.write("               <input type=\"submit\" class=\"btn btn-lg btn-primary\" value=\"Create Listing\"/>\n");
      out.write("\n");
      out.write("             </form>\n");
      out.write("           </div>\n");
      out.write("         </div>\n");
      out.write("       </div>\n");
      out.write("     </div>\n");
      out.write("   </div>\n");
      out.write(" </div>\n");
      out.write("</header>\n");
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
