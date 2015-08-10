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
import org.apache.http.client.methods.HttpPut;
import org.apache.http.message.BasicNameValuePair;

public class UpdateUserProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String)request.getParameter("username");
        int contactNumber = Integer.parseInt(request.getParameter("contact_number"));
        String address = (String)request.getParameter("address");
        String dateOfBirthString = (String)request.getParameter("dob_date");
        SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy");
        Date dateOfBirth = null;
        try {
            dateOfBirth = df.parse(dateOfBirthString);
        } catch (ParseException ex){
            ex.printStackTrace();
        } 
        
        User user = (User)session.getAttribute("currentUser");
  
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpPut httpPut = new HttpPut("https://clockwork-api.herokuapp.com/users.json");
        httpPut.setHeader("Accept", "application/json");
        List <NameValuePair> nvps = new ArrayList <NameValuePair>();
        nvps.add(new BasicNameValuePair("user[username]", username));
        nvps.add(new BasicNameValuePair("user[address]", address));
        nvps.add(new BasicNameValuePair("user[date_of_birth]", dateOfBirthString));
        nvps.add(new BasicNameValuePair("user[contact_number]",String.valueOf(contactNumber)));

        httpPut.setEntity(new UrlEncodedFormEntity(nvps));
        CloseableHttpResponse response2 = httpclient.execute(httpPut);
        HttpEntity entity = null;
        try {
            entity = response2.getEntity();  
            int statusCode = response2.getStatusLine().getStatusCode();
            if (statusCode == 200){
                user.setAddress(address);
                user.setContactNumber(contactNumber);
                user.setDateOfBirth(dateOfBirth);
                user.setUsername(username);
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
