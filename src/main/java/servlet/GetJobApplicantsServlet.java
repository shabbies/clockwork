package servlet;

import controller.AppController;
import controller.UserController;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;
import model.User;
import org.apache.commons.io.IOUtils;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.message.BasicNameValuePair;

public class GetJobApplicantsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // preparing variables
        HttpSession session = request.getSession();
        User currentUser = (User)session.getAttribute("currentUser");
        String email = currentUser.getEmail();
        String token = currentUser.getAuthenticationToken();
        String postID = request.getParameter("id");
        String location = request.getParameter("location");
        AppController appController = (AppController)session.getAttribute("appController");
        UserController userController = appController.getUserController();
        
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost("https://clockwork-api.herokuapp.com/api/v1/posts/get_all_applicants");
        httpPost.setHeader("Authentication-Token", token);
        List <NameValuePair> nvps = new ArrayList <NameValuePair>();
        nvps.add(new BasicNameValuePair("email", email));
        nvps.add(new BasicNameValuePair("post_id", postID));
        httpPost.setEntity(new UrlEncodedFormEntity(nvps));
        
        CloseableHttpResponse httpResponse = httpclient.execute(httpPost);
        HttpEntity entity = null;
        try {
            entity = httpResponse.getEntity();
            if(httpResponse.getStatusLine().getStatusCode() == 201){
                StringWriter writer = new StringWriter();
                InputStream readingStream = entity.getContent();
                IOUtils.copy(readingStream, writer, "UTF-8");
                String responseString = writer.toString();
                HashMap<String, ArrayList <User>> applicantMap = userController.loadPostApplicants(responseString);
                if (location.equals("listing")){
                    session.setAttribute("hiredList", applicantMap.get("hired"));
                    session.setAttribute("applicantList", applicantMap.get("pending"));
                    session.setAttribute("offeredList", applicantMap.get("offered"));
                    response.sendRedirect("/listing.jsp?id=" + postID);
                    return;
                } else if (location.equals("reviewing")){
                    session.setAttribute("hiredList", applicantMap.get("hired"));
                    session.setAttribute("reviewingList", applicantMap.get("reviewing"));
                    session.setAttribute("completedList", applicantMap.get("completed"));
                    RequestDispatcher rd = request.getRequestDispatcher("/GetCompletedApplicantsServlet?id=" + postID + "&location=reviewing");
                    rd.forward(request, response);
                } else {
                    session.setAttribute("completedList", applicantMap.get("completed"));
                    RequestDispatcher rd = request.getRequestDispatcher("/GetCompletedApplicantsServlet?id=" + postID + "&location=completed");
                    rd.forward(request, response);
                }
            } else {
                String error = "A system error has occurred, please try again";
                session.setAttribute("error", error);
                response.sendRedirect("/index.jsp");
                return;
            }
        } finally {
            EntityUtils.consume(entity);
            httpResponse.close();
        }
        
    }
}