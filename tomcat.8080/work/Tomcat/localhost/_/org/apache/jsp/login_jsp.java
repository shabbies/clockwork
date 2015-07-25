/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.57
 * Generated at: 2015-07-25 16:13:10 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class login_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("        <div class=\"header-content-inner\">\n");
      out.write("            <div class=\"row\">\n");
      out.write("                <div class=\"col-md-6 col-md-offset-3\">\n");
      out.write("                    <div class=\"panel panel-default\">\n");
      out.write("                        <div class=\"panel-body\">\n");
      out.write("                            ");
if (session.getAttribute("error") != null){
      out.write("\n");
      out.write("                            <!-- Gerald TODO: Style error message -->\n");
      out.write("                            <h4 style=\"color: black;\">  ");
      out.print(session.getAttribute("error"));
      out.write("</h4>   \n");
      out.write("                            ");
  session.removeAttribute("error");
                                session.setAttribute("loginSource", "create_new_post");}
      out.write("\n");
      out.write("                            <!-- END -->\n");
      out.write("                            <h2 class=\"text-center primary\">Login</h2>\n");
      out.write("                            \n");
      out.write("                            <form action=\"/LoginServlet\" method=\"POST\" role=\"form\">\n");
      out.write("                                <div class=\"form-group form-group-lg col-md-12 text-left\"> \n");
      out.write("                                    <div class=\"input-group\"> \n");
      out.write("                                        <div class=\"input-group-addon\"><i class=\"fa fa-envelope fa-lg fa-fw\"></i></div> \n");
      out.write("                                        <input id=\"login-email\" class=\"form-control\" type=\"text\" placeholder=\"Your email address\" name=\"email\" required> \n");
      out.write("                                    </div>\n");
      out.write("                                </div>\n");
      out.write("\n");
      out.write("                                <div class=\"form-group form-group-lg col-md-12 text-left\"> \n");
      out.write("                                    <div class=\"input-group\"> \n");
      out.write("                                        <div class=\"input-group-addon\"><i class=\"fa fa-lock fa-lg fa-fw\"></i></div> \n");
      out.write("                                        <input id=\"login-password\" class=\"form-control\" type=\"password\" placeholder=\"password\" name=\"password\" required>\n");
      out.write("                                    </div>\n");
      out.write("                                </div>\n");
      out.write("\n");
      out.write("                                <div class=\"form-group form-group-lg col-md-12 text-left\"> \n");
      out.write("                                  <input type=\"submit\" class=\"btn btn-lg btn-block btn-primary btn-srad\" value=\"Login\"/>\n");
      out.write("                                </div>\n");
      out.write("                            </form>\n");
      out.write("                            <div class=\"form-group form-group-lg col-md-12 text-left\"> \n");
      out.write("                                <button href=\"\" class=\"btn btn-lg btn-block btn-info btn-srad\" onclick=\"facebookLogin();\">Login thru Facebook</button>\n");
      out.write("                            </div>\n");
      out.write("                            <div class=\"form-group form-group-lg col-md-12 text-left\"> \n");
      out.write("                                <a href=\"/register.jsp\" class=\"btn btn-lg btn-block btn-default btn-srad\">New to Clockwork? Click Here</a>\n");
      out.write("                            </div>\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("    </div>                  \n");
      out.write("</header>                     \n");
      out.write("                                \n");
      out.write("<script>\n");
      out.write("var facebookLoginWindow;\n");
      out.write("var loginWindowTimer;\n");
      out.write("function facebookLogin()\n");
      out.write("{\n");
      out.write("\tvar popupWidth=500;\n");
      out.write("\tvar popupHeight=300;\n");
      out.write("\tvar xPosition=($(window).width()-popupWidth)/2;\n");
      out.write("\tvar yPosition=($(window).height()-popupHeight)/2;\n");
      out.write("\tvar loginUrl=\"http://www.facebook.com/dialog/oauth/?\"+\n");
      out.write("\t\t\"client_id=\"+879787135436221+\"&\"+\n");
      out.write("\t\t\"redirect_uri=http://clockworksmu.herokuapp.com/FacebookLoginServlet\"+\n");
      out.write("\t\t\"display=popup\";\n");
      out.write("\t\n");
      out.write("\tfacebookLoginWindow=window.open(loginUrl, \"LoginWindow\", \n");
      out.write("\t\t\"location=1,scrollbars=1,\"+\n");
      out.write("\t\t\"width=\"+popupWidth+\",height=\"+popupHeight+\",\"+\n");
      out.write("\t\t\"left=\"+xPosition+\",top=\"+yPosition);\n");
      out.write("\t\t\n");
      out.write("\tloginWindowTimer=setInterval(onTimerCallbackToCheckLoginWindowClosure, 1000);\n");
      out.write("}\n");
      out.write("</script>\n");
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
