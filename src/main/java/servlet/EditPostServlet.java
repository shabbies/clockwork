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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpSession;
import model.User;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.message.BasicNameValuePair;

public class EditPostServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User)session.getAttribute("currentUser");
        String header = (String)request.getParameter("header");
        int salary = Integer.parseInt(request.getParameter("salary"));
        String description = (String)request.getParameter("description");
        String location = (String)request.getParameter("location");
        String jobDateString = (String)request.getParameter("job_date");
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        Date jobDate = null;
        try {
            jobDate = df.parse(jobDateString);
        } catch (ParseException ex){
            ex.printStackTrace();
        }
        String email = currentUser.getEmail();
        String token = currentUser.getAuthenticationToken();
        
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost("https://clockwork-api.herokuapp.com/api/v1/posts/update");
        httpPost.setHeader("Authentication-Token", token);
        List <NameValuePair> nvps = new ArrayList <NameValuePair>();
        nvps.add(new BasicNameValuePair("header", header));
        nvps.add(new BasicNameValuePair("salary", "" + salary));
        nvps.add(new BasicNameValuePair("description", description));
        nvps.add(new BasicNameValuePair("location", location));
        nvps.add(new BasicNameValuePair("job_date",jobDate.toString()));
        nvps.add(new BasicNameValuePair("email", email));

        httpPost.setEntity(new UrlEncodedFormEntity(nvps));
        CloseableHttpResponse httpResponse = httpclient.execute(httpPost);
        HttpEntity entity = null;
        try {
            entity = httpResponse.getEntity();
            if(httpResponse.getStatusLine().getStatusCode() == 401){
                String error = "Only the owner of the post is allowed to edit it!";
                session.setAttribute("error", error);
                response.sendRedirect("/index.jsp");
                return;
            } 
        } finally {
            httpResponse.close();
            EntityUtils.consume(entity);
        }
        
        String message = "Post has been successfully updated!";
        session.setAttribute("message", message);
        response.sendRedirect("/dashboard.jsp");
    }

}
