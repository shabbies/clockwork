package servlet;

import controller.AppController;
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
import model.APIManager;
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
        AppController appController = (AppController)session.getAttribute("appController");
        APIManager apiManager = appController.getAPIManager();
        String URL = apiManager.getEPNewUser();
        String email = (String)request.getParameter("email");
        String username = (String)request.getParameter("username");
        String password = (String)request.getParameter("password");
        //password confirmation is to make sure that user remembers what he types, since password is censored
        String referrer = (String)request.getParameter("referrer");
        String passwordConfirmation = password;
        String accountType = (String)request.getParameter("account_type");
        String contactNumber = (String)request.getParameter("number");
        
        //verify contact number
        if (contactNumber != null){
            try {
                if (contactNumber.length() != 8){
                    throw new Exception();
                }
                int numVerify = Integer.parseInt(contactNumber);
            } catch (Exception e){
                session.setAttribute("error", "Please enter a valid contact number");
                response.sendRedirect("/register_" + accountType + ".jsp");
                return;
            }
        }
        
        //verify T&C agree
        if (request.getParameterValues("tc-checkbox") == null){
            session.setAttribute("error", "Please agree to the Terms before continuing");
            response.sendRedirect("/register_" + accountType + ".jsp");
            return;
        }
        
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost(URL);
        httpPost.setHeader("Accept", "application/json");
        List <NameValuePair> nvps = new ArrayList <NameValuePair>();
        nvps.add(new BasicNameValuePair("user[email]", email));
        nvps.add(new BasicNameValuePair("user[username]", username));
        nvps.add(new BasicNameValuePair("user[password]", password));
        nvps.add(new BasicNameValuePair("user[password_confirmation]", passwordConfirmation));
        nvps.add(new BasicNameValuePair("user[account_type]", accountType));
        if (referrer != null){
            nvps.add(new BasicNameValuePair("user[referred_by]",referrer));
        }
        if (contactNumber != null){
            nvps.add(new BasicNameValuePair("user[contact_number]",contactNumber));
        }
        
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
                UserController userController = appController.getUserController();
                user = userController.createUserFromJSON(responseString);
                userController.login(user);
            } else {
                String error;
                System.out.println(responseString);
                if (responseString.contains("email")){
                    error = "This email address has already been taken, please use an alternative!";
                } else if (responseString.contains("contact")){
                    error = "This contact number has already been associated with another account, please use an alternative!";
                } else {
                    error = "This password is too short, please ensure that it is at least 8 characters long!";
                }
                session.setAttribute("error", error);
                response.sendRedirect("/register_" + accountType + ".jsp");
                return;
            }
            
        } finally {
            EntityUtils.consume(entity);
            response2.close();
        }
        
        session.setAttribute("currentUser", user);
        
        // Redirection based on initial location
        if (session.getAttribute("loginSource") != null){
            String loginSource = (String)session.getAttribute("loginSource");
            session.removeAttribute("loginSource");
            if (loginSource.equals("create_new_post")){
                if (accountType.equals("employer")){
                    response.sendRedirect("/create_post.jsp");
                } else {
                    String error = "Only employers are allowed to post jobs!";
                    session.setAttribute("error", error);
                    response.sendRedirect("/index.jsp");
                }
                return;
            } else if (loginSource.contains("apply_job")){
                if (accountType.equals("job_seeker")){
                    session.setAttribute("updateSource", loginSource);
                    response.sendRedirect("/complete_profile.jsp");
                } else {
                    String error = "Only job seekers are allowed to apply for jobs!";
                    session.setAttribute("error", error);
                    response.sendRedirect("/index.jsp");
                }
                return;
            }
        } else {
            if (user.getAccountType().equals("employer")){
                response.sendRedirect("/dashboard.jsp");
                return;
            } else {
                response.sendRedirect("/mydashboard.jsp");
            }
        }
    }

}
