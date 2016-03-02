package servlet;

import controller.AppController;
import controller.MatchController;
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
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpSession;
import model.APIManager;
import model.Match;
import model.User;
import org.apache.commons.io.IOUtils;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.message.BasicNameValuePair;

public class GetCompletedApplicantsServlet extends HttpServlet {

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
        APIManager apiManager = appController.getAPIManager();
        String URL = apiManager.getEPCompletedApplicants();
        MatchController matchController = appController.getMatchController();
        
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost(URL);
        httpPost.setHeader("Authentication-Token", token);
        List <NameValuePair> nvps = new ArrayList <NameValuePair>();
        nvps.add(new BasicNameValuePair("email", email));
        nvps.add(new BasicNameValuePair("post_id", postID));
        httpPost.setEntity(new UrlEncodedFormEntity(nvps));
        
        CloseableHttpResponse httpResponse = httpclient.execute(httpPost);
        HttpEntity entity = null;
        try {
            entity = httpResponse.getEntity();
            StringWriter writer = new StringWriter();
            InputStream readingStream = entity.getContent();
            IOUtils.copy(readingStream, writer, "UTF-8");
            String responseString = writer.toString();
            if(httpResponse.getStatusLine().getStatusCode() == 201){
                HashMap<Integer, Match> matchedUsers = matchController.loadMatchMap(responseString);
                session.setAttribute("matchMap", matchedUsers);
                switch (location) {
                    case "reviewing":
                        response.sendRedirect("/review_applicants.jsp?id=" + postID);
                        return;
                    case "listing":
                        session.setAttribute("matchMap", matchController.getPostMatchMap(Integer.parseInt(postID)));
                        response.sendRedirect("/listing.jsp?id=" + postID);
                        return;
                    default:
                        response.sendRedirect("/complete_job.jsp?id=" + postID);
                        return;
                }
            } else {
                session.setAttribute("error", responseString);
                response.sendRedirect("/index.jsp");
                return;
            }
        } catch (ParseException e){
        
        } finally {
            EntityUtils.consume(entity);
            httpResponse.close();
        }
    }
}