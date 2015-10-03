package servlet;

import controller.AppController;
import controller.UserController;
import java.io.IOException;
import java.io.PrintWriter;
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
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;
import model.APIManager;
import model.User;
import org.apache.commons.io.IOUtils;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.message.BasicNameValuePair;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        AppController appController = (AppController)session.getAttribute("appController");
        APIManager apiManager = appController.getAPIManager();
        String URL = apiManager.getEPLogin();
        String email = (String)request.getParameter("email");
        String password = (String)request.getParameter("password");
        
        CloseableHttpClient httpClient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost(URL);
        httpPost.setHeader("Accept", "application/json");
        List <NameValuePair> nvps = new ArrayList <NameValuePair>();
        nvps.add(new BasicNameValuePair("user[email]", email));
        nvps.add(new BasicNameValuePair("user[password]", password));
        
        httpPost.setEntity(new UrlEncodedFormEntity(nvps));
        CloseableHttpResponse response2 = httpClient.execute(httpPost);
        User user;

        try {
            HttpEntity entity2 = response2.getEntity();   
            if(response2.getStatusLine().getStatusCode() == 401){
                String error = "The email / password is invalid, please try again.";
                session.setAttribute("error", error);
                response.sendRedirect("/login.jsp");
                return;
            }
            StringWriter writer = new StringWriter();
            IOUtils.copy(entity2.getContent(), writer, "UTF-8");
            String theString = writer.toString();
            UserController userController = appController.getUserController();
            user = userController.createUserFromJSON(theString);
            user = userController.login(user);
            EntityUtils.consume(entity2);
        } finally {
            response2.close();
        }
        
        session.setAttribute("currentUser", user);
        
        // Redirection based on initial location
        if (session.getAttribute("loginSource") != null){
            String loginSource = (String)session.getAttribute("loginSource");
            session.removeAttribute("loginSource");
            if (loginSource.equals("create_new_post")){
                response.sendRedirect("/create_post.jsp");
                return;
            } else if (loginSource.contains("apply_job")){
                if (user.getAccountType().equals("job_seeker")){
                    String postID = loginSource.substring(loginSource.indexOf("-") + 1);
                    RequestDispatcher rd = request.getRequestDispatcher("/ApplyJobServlet?post_id=" + postID);
                    rd.forward(request, response);
                } else {
                    String error = "Only job seekers are allowed to apply for jobs!";
                    session.setAttribute("error", error);
                    response.sendRedirect("/dashboard.jsp");
                    return;
                }
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
