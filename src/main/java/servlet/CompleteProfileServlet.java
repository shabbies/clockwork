package servlet;

import controller.AppController;
import controller.UserController;
import java.io.IOException;
import java.io.StringWriter;
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
import java.util.Date;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import model.APIManager;
import model.User;
import org.apache.commons.io.IOUtils;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntityBuilder;

@MultipartConfig
public class CompleteProfileServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        AppController appController = (AppController)session.getAttribute("appController");
        APIManager apiManager = appController.getAPIManager();
        String URL = apiManager.getEPCompleteProfile();
        User currentUser = (User)session.getAttribute("currentUser");
        String token = currentUser.getAuthenticationToken();
        String email = currentUser.getEmail();
        String username = request.getParameter("username");
        String contactNumberString = request.getParameter("contact_number");
        String nationality = request.getParameter("nationality");
        String gender = request.getParameter("gender");
        int contactNumber = 0;
        if (contactNumberString != null){
            if (!contactNumberString.isEmpty()){
                try {
                    contactNumber = Integer.parseInt((String)request.getParameter("contact_number"));
                } catch (NumberFormatException e){
                    String error = "Please enter a valid contact number";
                    session.setAttribute("error", error);
                    response.sendRedirect("/edit_profile.jsp");
                }
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
                return;
            }
        }
        Part avatarPart = request.getPart("avatar");
        byte[] avatarByte = null;
        if (avatarPart != null){
            avatarByte = IOUtils.toByteArray(avatarPart.getInputStream());
        }
        
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost(URL);
        httpPost.setHeader("Authentication-Token", token);
        
        MultipartEntityBuilder builder = MultipartEntityBuilder.create();
        builder.setMode(HttpMultipartMode.BROWSER_COMPATIBLE);
        if (avatarByte != null && avatarByte.length != 0){
            builder.addBinaryBody("avatar", avatarByte, ContentType.create(avatarPart.getContentType()), currentUser.getId() + " " + avatarPart.getName() + ".jpg");
        }
        if (email != null){
            builder.addTextBody("email", email, ContentType.TEXT_PLAIN);
        }
        if (username != null){
            builder.addTextBody("username", username, ContentType.TEXT_PLAIN);
        }
        if (address != null){
            builder.addTextBody("address", address, ContentType.TEXT_PLAIN);
        }
        if (nationality != null){
            builder.addTextBody("nationality", nationality, ContentType.TEXT_PLAIN);
        }
        if (gender != null){
            builder.addTextBody("gender", gender, ContentType.TEXT_PLAIN);
        }
        if (dateOfBirthString != null){
            builder.addTextBody("date_of_birth", dateOfBirthString, ContentType.TEXT_PLAIN);
        }
        if (contactNumber != 0){
            builder.addTextBody("contact_number", String.valueOf(contactNumber), ContentType.TEXT_PLAIN);
        }
        
        HttpEntity entity = builder.build();
        httpPost.setEntity(entity);
        
        CloseableHttpResponse response2 = httpclient.execute(httpPost);
        User user;
        
        try {
            entity = response2.getEntity();
            StringWriter writer = new StringWriter();
            IOUtils.copy(entity.getContent(), writer, "UTF-8");
            String theString = writer.toString();
            int statusCode = response2.getStatusLine().getStatusCode();
            if (statusCode == 200){
                UserController userController = appController.getUserController();
                userController.updateUser(theString);
                String message = "Your profile has been successfully updated.";
                session.setAttribute("message", message);
            } else {
                String error = theString;
                session.setAttribute("error", error);
                response.sendRedirect("/complete_profile.jsp");
                return;
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
        
        response.sendRedirect("/mydashboard.jsp");
    }
}