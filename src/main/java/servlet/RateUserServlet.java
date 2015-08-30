package servlet;

import controller.AppController;
import controller.UserController;
import java.io.IOException;

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
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.message.BasicNameValuePair;

public class RateUserServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        AppController appController = (AppController)session.getAttribute("appController");
        UserController userController = appController.getUserController();
        User currentUser = (User)session.getAttribute("currentUser");
        String formRatings = request.getParameter("ratings");
        String formComments = request.getParameter("comments");
        int postID = Integer.parseInt(request.getParameter("post_id"));
        String email = currentUser.getEmail();
        String token = currentUser.getAuthenticationToken();
        
        String userRatings = userController.loadUserRatingsList(formRatings, formComments);
        
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost("https://clockwork-api.herokuapp.com/api/v1/posts/rate");
        httpPost.setHeader("Authentication-Token", token);
        List <NameValuePair> nvps = new ArrayList <NameValuePair>();
        nvps.add(new BasicNameValuePair("email", email));
        nvps.add(new BasicNameValuePair("post_id", "" + postID));
        nvps.add(new BasicNameValuePair("user_feedback", userRatings));

        httpPost.setEntity(new UrlEncodedFormEntity(nvps));
        CloseableHttpResponse httpResponse = httpclient.execute(httpPost);
        HttpEntity entity = null;
        try {
            entity = httpResponse.getEntity();
            if(httpResponse.getStatusLine().getStatusCode() == 201){
                String message = "You have successfully rated your employees";
                session.setAttribute("message", message);
            }  else {
                String error = "A system error has occurred, please try again";
                session.setAttribute("error", error);
            }
            response.sendRedirect("/dashboard.jsp");
        } finally {
            httpResponse.close();
            EntityUtils.consume(entity);
        }
    }

}
