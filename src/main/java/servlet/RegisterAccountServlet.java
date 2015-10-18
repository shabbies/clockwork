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
        String NRIC = (String)request.getParameter("nric");
        
        // NRIC Validation
        if (accountType.equals("job_seeker")){
            try {
                if (NRIC.length() != 9){
                    throw new Exception();
                }
                NRIC = NRIC.toUpperCase();
                Object[] ICArray = new Object[9];
                for (int i = 0; i < NRIC.length(); i++){
                    ICArray[i] = NRIC.charAt(i);
                }

                ICArray[1] = Integer.parseInt(ICArray[1].toString()) * 2;
                ICArray[2] = Integer.parseInt(ICArray[2].toString()) * 7;
                ICArray[3] = Integer.parseInt(ICArray[3].toString()) * 6;
                ICArray[4] = Integer.parseInt(ICArray[4].toString()) * 5;
                ICArray[5] = Integer.parseInt(ICArray[5].toString()) * 4;
                ICArray[6] = Integer.parseInt(ICArray[6].toString()) * 3;
                ICArray[7] = Integer.parseInt(ICArray[7].toString()) * 2;

                int weight = 0;
                for (int i = 1; i < 8; i++){
                    weight += (int)ICArray[i];
                }
                int offset = (ICArray[0] == "T" || ICArray[0] == "G") ? 4:0;
                int temp = (offset + weight) % 11;

                char[] st = {'J','Z','I','H','G','F','E','D','C','B','A'};
                char[] fg = {'X','W','U','T','R','Q','P','N','M','L','K'};

                char theAlpha = '0';
                if ((char)ICArray[0] == 'S' || (char)ICArray[0] == 'T') { 
                    theAlpha = st[temp]; 
                } else if ((char)ICArray[0] == 'F' || (char)ICArray[0] == 'G') { 
                    theAlpha = fg[temp]; 
                }

                if (theAlpha != (char)ICArray[8]){
                    throw new Exception();
                }
            } catch (Exception e){
                String error = "NRIC is invalid, please enter a valid one!";
                session.setAttribute("error", error);
                response.sendRedirect("/index.jsp");
                return;
            }
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
        if (NRIC != null){
            nvps.add(new BasicNameValuePair("user[nric]", NRIC));
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
                if (responseString.contains("email")){
                    error = "This email address has already been taken, please use an alternative!";
                } else if (responseString.contains("nric")){
                    error = "This NRIC has already been associated with another account, please login instead!";
                    session.setAttribute("error", error);
                    response.sendRedirect("/login.jsp");
                    return;
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
