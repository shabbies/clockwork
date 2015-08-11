package servlet;

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

public class ApplyJobServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int postID = Integer.parseInt(request.getParameter("post_id"));
        HttpSession session = request.getSession();
        User currentUser = (User)session.getAttribute("currentUser");
        if (currentUser == null){
            session.setAttribute("error", "Please login before applying for a job");
            session.setAttribute("loginSource", "apply_job-" + postID);
            response.sendRedirect("/login.jsp");
            return;
        } else if (currentUser.getAccountType().equals("employer")){
            session.setAttribute("error", "Only a job seeker account is able to apply for a job!");
            response.sendRedirect("/index.jsp");
            return;
        } else if (currentUser.getContactNumber() == 0){
            session.setAttribute("error", "Please complete your profile before applying for a job");
            response.sendRedirect("/edit_profile.jsp");
            return;
        }
        String email = currentUser.getEmail();
        String token = currentUser.getAuthenticationToken();
        
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost("https://clockwork-api.herokuapp.com/api/v1/users/apply");
        httpPost.setHeader("Authentication-Token", token);
        List <NameValuePair> nvps = new ArrayList <NameValuePair>();
        nvps.add(new BasicNameValuePair("job_id", "" + postID));
        nvps.add(new BasicNameValuePair("email", email));

        httpPost.setEntity(new UrlEncodedFormEntity(nvps));
        CloseableHttpResponse httpResponse = httpclient.execute(httpPost);
        HttpEntity entity = null;
        try {
            entity = httpResponse.getEntity();
            if(httpResponse.getStatusLine().getStatusCode() == 500){
                String error = "You have already applied for this job!";
                session.setAttribute("error", error);
                response.sendRedirect("/index.jsp");
                return;
            }
        } finally {
            httpResponse.close();
            EntityUtils.consume(entity);
        }
        String message = "You have successfully applied for this job!";
        session.setAttribute("message", message);
        response.sendRedirect("/post.jsp?id=" + postID);
    }

}
