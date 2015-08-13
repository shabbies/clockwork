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

public class HireUserServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int postID = Integer.parseInt(request.getParameter("post_id"));
        int applicantID = Integer.parseInt(request.getParameter("applicant_id"));
        HttpSession session = request.getSession();
        User currentUser = (User)session.getAttribute("currentUser");
        
        String email = currentUser.getEmail();
        String token = currentUser.getAuthenticationToken();
        
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost("https://clockwork-api.herokuapp.com/api/v1/users/hire");
        httpPost.setHeader("Authentication-Token", token);
        List <NameValuePair> nvps = new ArrayList <NameValuePair>();
        nvps.add(new BasicNameValuePair("job_id", "" + postID));
        nvps.add(new BasicNameValuePair("email", email));
        nvps.add(new BasicNameValuePair("applicant_id", "" + applicantID));

        httpPost.setEntity(new UrlEncodedFormEntity(nvps));
        CloseableHttpResponse httpResponse = httpclient.execute(httpPost);
        HttpEntity entity = null;
        try {
            entity = httpResponse.getEntity();
            if(httpResponse.getStatusLine().getStatusCode() == 201){
                String message = "You have successfully hired!";
                session.setAttribute("message", message);
                response.sendRedirect("/listing.jsp?id=" + postID);
                return;
            } 
        } finally {
            httpResponse.close();
            EntityUtils.consume(entity);
        }
    }

}
