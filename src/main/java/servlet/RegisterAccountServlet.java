package servlet;

import controller.UserController;
import java.io.IOException;
import java.io.StringWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpSession;
import model.User;
import org.apache.commons.io.IOUtils;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.message.BasicNameValuePair;

public class RegisterAccountServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String)request.getParameter("email");
        String username = (String)request.getParameter("username");
        String password = (String)request.getParameter("password");
        //password confirmation is to make sure that user remembers what he types, since password is censored
        String passwordConfirmation = password;
        String accountType = (String)request.getParameter("account_type");
        
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost("https://clockwork-api.herokuapp.com/users.json");
        httpPost.setHeader("Accept", "application/json");
        List <NameValuePair> nvps = new ArrayList <NameValuePair>();
        nvps.add(new BasicNameValuePair("user[email]", email));
        nvps.add(new BasicNameValuePair("user[username]", username));
        nvps.add(new BasicNameValuePair("user[password]", password));
        nvps.add(new BasicNameValuePair("user[password_confirmation]", passwordConfirmation));
        nvps.add(new BasicNameValuePair("user[account_type]",accountType));

        httpPost.setEntity(new UrlEncodedFormEntity(nvps));
        CloseableHttpResponse response2 = httpclient.execute(httpPost);
        User user = null;
        HttpEntity entity = null;
        try {
            entity = response2.getEntity();  
            StringWriter writer = new StringWriter();
            IOUtils.copy(entity.getContent(), writer, "UTF-8");
            String responseString = writer.toString();
            if (response2.getStatusLine().getStatusCode() == 201){
                UserController userController = new UserController();
                user = userController.createUserFromJSON(responseString);
            } else {
                String error;
                if (responseString.contains("email")){
                    error = "This email address has already been taken, please use an alternative.";
                } else {
                    error = "This password is too short, please ensure that it is at least 8 characters long";
                }
                session.setAttribute("error", error);
                response.sendRedirect("/index.jsp");
                return;
            }
            
        } finally {
            EntityUtils.consume(entity);
            response2.close();
        }
        
        session.setAttribute("currentUser", user);
        
        // Redirection based on initial location
        if (session.getAttribute("loginSource") != null && session.getAttribute("loginSource").equals("create_new_post")){
            session.removeAttribute("loginSource");
            response.sendRedirect("/create_post.jsp");
            return;
        }
        response.sendRedirect("/index.jsp");
    }

}
