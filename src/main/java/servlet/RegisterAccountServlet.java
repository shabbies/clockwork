package servlet;

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
import javax.servlet.http.HttpSession;
import model.User;
import org.apache.commons.io.IOUtils;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.message.BasicNameValuePair;

public class RegisterAccountServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        String email = (String)request.getParameter("email");
        //TODO: remove username from db. username should be the email. One less field for user to enter
        String username = email;
        String companyName = (String)request.getParameter("company_name");
        String password = (String)request.getParameter("password");
        //TODO: remove password confirmation. if need to change pw. the user can forget password.
        String passwordConfirmation = password;
        String accountType = (String)request.getParameter("account_type");
        
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost("https://clockwork-api.herokuapp.com/users");
        httpPost.setHeader("Accept", "application/json");
        List <NameValuePair> nvps = new ArrayList <NameValuePair>();
        nvps.add(new BasicNameValuePair("user[email]", email));
        nvps.add(new BasicNameValuePair("user[username]", username));
        nvps.add(new BasicNameValuePair("user[company_name]", companyName));
        nvps.add(new BasicNameValuePair("user[password]", password));
        nvps.add(new BasicNameValuePair("user[password_confirmation]", passwordConfirmation));
        nvps.add(new BasicNameValuePair("user[account_type]",accountType));

        httpPost.setEntity(new UrlEncodedFormEntity(nvps));
        CloseableHttpResponse response2 = httpclient.execute(httpPost);
        User user;

        try {
            HttpEntity entity2 = response2.getEntity();   
            StringWriter writer = new StringWriter();
            IOUtils.copy(entity2.getContent(), writer, "UTF-8");
            String theString = writer.toString();
            UserController userController = new UserController();
            user = userController.createUserFromJSON(theString);
            EntityUtils.consume(entity2);
        } finally {
            response2.close();
        }
        
        session.setAttribute("currentUser", user);
        response.sendRedirect("/GetAllPostsServlet");
    }

}
