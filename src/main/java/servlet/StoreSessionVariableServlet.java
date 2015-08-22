package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.Enumeration;
import javax.servlet.http.HttpSession;

public class StoreSessionVariableServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
   
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        Enumeration<String> paramNames = request.getParameterNames();
        while (paramNames.hasMoreElements()){
            String paramName = (paramNames.nextElement()).trim();
            paramName = paramName.replaceAll("id", "ID");
            if (paramName.startsWith("_")){
                paramName = paramName.replace("_", "");
            }
            if (paramName.endsWith("_")){
                paramName = paramName.substring(0, paramName.length() - 2);
            }
            String newParamName = "";
            for (int i = 0; i < paramName.length(); i++){
                char character = paramName.charAt(i);
                if (character == '_'){
                    character = Character.toUpperCase(paramName.charAt(i + 1));
                    i++;
                }
                newParamName += character;
            }
            session.setAttribute(newParamName, request.getAttribute(paramName));
        }
    }
}