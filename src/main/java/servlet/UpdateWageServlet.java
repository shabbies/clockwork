package servlet;

import controller.AppController;
import java.io.IOException;
import java.io.InputStream;
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
import model.APIManager;
import model.User;
import org.apache.commons.io.IOUtils;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.message.BasicNameValuePair;

public class UpdateWageServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        AppController appController = (AppController)session.getAttribute("appController");
        APIManager apiManager = appController.getAPIManager();
        String URL = apiManager.getEPUpdateWage();
        int postID = Integer.parseInt(request.getParameter("post_id"));
        int applicantID = Integer.parseInt(request.getParameter("user_id"));
        double wage = Double.parseDouble((String)request.getParameter("salary"));
        String date = request.getParameter("date");
        User currentUser = (User)session.getAttribute("currentUser");
        
        String email = currentUser.getEmail();
        String token = currentUser.getAuthenticationToken();
        
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost(URL);
        httpPost.setHeader("Authentication-Token", token);
        List <NameValuePair> nvps = new ArrayList <NameValuePair>();
        nvps.add(new BasicNameValuePair("post_id", "" + postID));
        nvps.add(new BasicNameValuePair("email", email));
        nvps.add(new BasicNameValuePair("applicant_id", "" + applicantID));
        nvps.add(new BasicNameValuePair("salary", "" + wage));
        nvps.add(new BasicNameValuePair("date", date));

        httpPost.setEntity(new UrlEncodedFormEntity(nvps));
        CloseableHttpResponse httpResponse = httpclient.execute(httpPost);
        HttpEntity entity = null;
        try {
            entity = httpResponse.getEntity();
            StringWriter writer = new StringWriter();
            InputStream readingStream = entity.getContent();
            IOUtils.copy(readingStream, writer, "UTF-8");
            String responseString = writer.toString();
            System.out.println(responseString);
            if(httpResponse.getStatusLine().getStatusCode() == 201){
                String message = "You have successfully updated wages!";
                session.setAttribute("message", message);
            }  else {
                String error = "A system error has occurred, please try again";
                session.setAttribute("error", error);
            }
            response.sendRedirect("/listing.jsp?id=" + postID);
        } finally {
            httpResponse.close();
            EntityUtils.consume(entity);
        }
    }

}
