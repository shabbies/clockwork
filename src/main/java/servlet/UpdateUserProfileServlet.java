package servlet;

import com.google.gson.Gson;
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
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.StringEntity;
import org.apache.http.message.BasicNameValuePair;

public class UpdateUserProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User)session.getAttribute("currentUser");
        String token = currentUser.getAuthenticationToken();
        String email = currentUser.getEmail();
        String username = null;
        if (!(request.getParameter("username").equals(""))){
            username = (String)request.getParameter("username");
        }
        int contactNumber = 0;
        if (!(request.getParameter("contact_number").equals(""))){
            contactNumber = Integer.parseInt((String)request.getParameter("contact_number"));
        } 
        String address = null;
        if (!(request.getParameter("address").equals(""))){
            address = (String)request.getParameter("address");
        }
        String dateOfBirthString = (String)request.getParameter("dob_date");
        SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy");
        Date dateOfBirth = null;
        try {
            dateOfBirth = df.parse(dateOfBirthString);
        } catch (ParseException ex){
            ex.printStackTrace();
        }
        
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpPut httpPut = new HttpPut("https://clockwork-api.herokuapp.com/users.json");
        httpPut.setHeader("Accept", "application/json");
        httpPut.setHeader("Cache-Control", "max-age=0, private, must-revalidate");
        httpPut.setHeader("Authentication-Token", token);
        
        List <NameValuePair> nvps = new ArrayList <NameValuePair>();
        nvps.add(new BasicNameValuePair("user[email]", email));
        nvps.add(new BasicNameValuePair("user[username]", username));
        nvps.add(new BasicNameValuePair("user[address]", address));
        nvps.add(new BasicNameValuePair("user[date_of_birth]", dateOfBirthString));
        if (contactNumber != 0){
            nvps.add(new BasicNameValuePair("user[contact_number]", String.valueOf(contactNumber)));
        } else {
            nvps.add(new BasicNameValuePair("user[contact_number]", ""));
        }
        
        httpPut.setEntity(new UrlEncodedFormEntity(nvps));
        CloseableHttpResponse response2 = httpclient.execute(httpPut);
        HttpEntity entity = null;
        try {
            entity = response2.getEntity();  
            int statusCode = response2.getStatusLine().getStatusCode();
            if (statusCode == 200){
                currentUser.setAddress(address);
                currentUser.setContactNumber(contactNumber);
                currentUser.setDateOfBirth(dateOfBirth);
                currentUser.setUsername(username);
            } else {
                String error;
                if (statusCode == 401){
                    error = "The authentication token is invalid.";
                } else {
                    error = "The email address is in used, please use a different one.";
                }
                session.setAttribute("error", error);
            }
            
        } finally {
            EntityUtils.consume(entity);
            response2.close();
        }
        
        response.sendRedirect("/dashboard.jsp");
    }

}
