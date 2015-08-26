package servlet;

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
import model.User;
import org.apache.commons.io.IOUtils;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntityBuilder;

@MultipartConfig
public class UpdateUserProfileServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User)session.getAttribute("currentUser");
        String token = currentUser.getAuthenticationToken();
        String email = currentUser.getEmail();
        String username = request.getParameter("username");
        String contactNumberString = request.getParameter("contact_number");
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
        
        String oldPassword = request.getParameter("old_password").trim();
        String newPassword = request.getParameter("new_password").trim();
        String newPasswordConfirmation = request.getParameter("new_password_confirmation").trim();
        
        if (!newPassword.equals(newPasswordConfirmation)){
            String error = "New password should match!";
            session.setAttribute("error", error);
            response.sendRedirect("/edit_profile.jsp");
            return;
        }
        
        if (newPassword.length() < 8){
            String error = "Password length should be greater than 8!";
            session.setAttribute("error", error);
            response.sendRedirect("/edit_profile.jsp");
            return;
        }
        
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost("https://clockwork-api.herokuapp.com/api/v1/users/update");
        httpPost.setHeader("Authentication-Token", token);
        
        MultipartEntityBuilder builder = MultipartEntityBuilder.create();
        builder.setMode(HttpMultipartMode.BROWSER_COMPATIBLE);
        if (avatarByte != null){
            builder.addBinaryBody("avatar", avatarByte, ContentType.create(avatarPart.getContentType()), currentUser.getId() + " " + avatarPart.getName());
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
        if (dateOfBirthString != null){
            builder.addTextBody("date_of_birth", dateOfBirthString, ContentType.TEXT_PLAIN);
        }
        if (contactNumber != 0){
            builder.addTextBody("contact_number", String.valueOf(contactNumber), ContentType.TEXT_PLAIN);
        }
        if (oldPassword != null && newPassword != null && newPasswordConfirmation != null){
            builder.addTextBody("old_password", oldPassword, ContentType.TEXT_PLAIN);
            builder.addTextBody("password", newPassword, ContentType.TEXT_PLAIN);
            builder.addTextBody("password_confirmation", newPasswordConfirmation, ContentType.TEXT_PLAIN);
        }
        HttpEntity entity = builder.build();
        httpPost.setEntity(entity);
        
        CloseableHttpResponse response2 = httpclient.execute(httpPost);
        User user;
        
        try {
            entity = response2.getEntity();
            int statusCode = response2.getStatusLine().getStatusCode();
            if (statusCode == 400){
                String error = "You have to be at least 15 to use this service!";
                session.setAttribute("error", error);
            } else if (statusCode == 200){
                StringWriter writer = new StringWriter();
                IOUtils.copy(entity.getContent(), writer, "UTF-8");
                String theString = writer.toString();
                UserController userController = new UserController();
                user = userController.createUserFromJSON(theString);
                session.setAttribute("currentUser", user);
                String message = "Your profile has been successfully updated.";
                session.setAttribute("message", message);
            } else if (statusCode == 403){
                String error = "The old password is invalid";
                session.setAttribute("error", error);
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