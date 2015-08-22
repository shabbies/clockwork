package servlet;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

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
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpSession;
import model.User;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.message.BasicNameValuePair;

public class UpdateUserProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User)session.getAttribute("currentUser");
        String token = currentUser.getAuthenticationToken();
        String email = currentUser.getEmail();
        String username = (String)request.getParameter("username");
        int contactNumber = 0;
        if (!(request.getParameter("contact_number").equals(""))){
            try {
                contactNumber = Integer.parseInt((String)request.getParameter("contact_number"));
            } catch (NumberFormatException e){
                String error = "Please enter a valid contact number";
                session.setAttribute("error", error);
                response.sendRedirect("/edit_profile.jsp");
            }
        } 
        String address = (String)request.getParameter("address");
        String dateOfBirthString = request.getParameter("dob_date");
        Date dateOfBirth = null;
        if (dateOfBirthString != null){ 
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            try {
                dateOfBirth = df.parse(dateOfBirthString);
            } catch (ParseException e){
                String error = "There is an error with the date of birth!";
                session.setAttribute("error", error);
                response.sendRedirect("/edit_profile.jsp");
            }
        }
        
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost("https://clockwork-api.herokuapp.com/api/v1/users/update");
        httpPost.setHeader("Authentication-Token", token);
        
        List <NameValuePair> nvps = new ArrayList <NameValuePair>();
        nvps.add(new BasicNameValuePair("email", email));
        nvps.add(new BasicNameValuePair("username", username));
        nvps.add(new BasicNameValuePair("address", address));
        if (dateOfBirthString == null){
            nvps.add(new BasicNameValuePair("date_of_birth", ""));
        } else {
            nvps.add(new BasicNameValuePair("date_of_birth", dateOfBirthString));
        }
        if (contactNumber != 0){
            nvps.add(new BasicNameValuePair("contact_number", String.valueOf(contactNumber)));
        } else {
            nvps.add(new BasicNameValuePair("contact_number", ""));
        }
        
        httpPost.setEntity(new UrlEncodedFormEntity(nvps));
        CloseableHttpResponse response2 = httpclient.execute(httpPost);
        HttpEntity entity = null;
        try {
            entity = response2.getEntity();  
            int statusCode = response2.getStatusLine().getStatusCode();
            if (statusCode == 400){
                String message = "Your profile has been successfully updated.";
                session.setAttribute("message", message);
            } else if (statusCode == 200){
                currentUser.setAddress(address);
                currentUser.setContactNumber(contactNumber);
                currentUser.setDateOfBirth(dateOfBirth);
                currentUser.setUsername(username);
                String message = "Your profile has been successfully updated.";
                session.setAttribute("message", message);
            } else {
                String error = "The authentication token is invalid.";
                session.setAttribute("error", error);
            }
        } finally {
            EntityUtils.consume(entity);
            response2.close();
        }
        
        if (session.getAttribute("updateSource") != null){
            String updateSource = (String)session.getAttribute("updateSource");
            session.removeAttribute("updateSource");
            if (updateSource.contains("apply_job")){
                String postID = updateSource.substring(updateSource.indexOf("-") + 1);
                String message = "Please proceed with your job application here!";
                session.setAttribute("message", message);
                response.sendRedirect("/post.jsp?id=" + postID);
                return;
            }
        }
        
        response.sendRedirect("/edit_profile.jsp");
    }
}