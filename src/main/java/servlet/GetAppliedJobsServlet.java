package servlet;

import controller.AppController;
import controller.PostController;
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
import model.Post;
import model.User;
import org.apache.commons.io.IOUtils;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.message.BasicNameValuePair;

public class GetAppliedJobsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // preparing variables
        HttpSession session = request.getSession();
        User currentUser = (User)session.getAttribute("currentUser");
        String email = currentUser.getEmail();
        String token = currentUser.getAuthenticationToken();
        AppController appController = (AppController)session.getAttribute("appController");
        APIManager apiManager = appController.getAPIManager();
        String URL = apiManager.getEPAppliedJobs();
        PostController postController = appController.getPostController();
        
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost(URL);
        httpPost.setHeader("Authentication-Token", token);
        List <NameValuePair> nvps = new ArrayList <NameValuePair>();
        nvps.add(new BasicNameValuePair("email", email));

        httpPost.setEntity(new UrlEncodedFormEntity(nvps));
        CloseableHttpResponse httpResponse = httpclient.execute(httpPost);

        HttpEntity entity = null;
        HashMap <String, ArrayList <Post>> appliedJobs = new HashMap <String, ArrayList <Post>> ();
        HashMap <Integer, String> appliedJobsStatusMap = new HashMap <Integer, String> ();
        ArrayList <Post> completedJobs;
        try {
            entity = httpResponse.getEntity();
            if(httpResponse.getStatusLine().getStatusCode() == 200){
                StringWriter writer = new StringWriter();
                InputStream readingStream = entity.getContent();
                IOUtils.copy(readingStream, writer, "UTF-8");
                String responseString = writer.toString();
                appliedJobs = postController.loadAppliedJobs(responseString);
                appliedJobsStatusMap = postController.getApplicationPostStatus();
                completedJobs = postController.getCompletedJobs();
            } else {
                String error = "A system error has occurred, please try again";
                session.setAttribute("error", error);
                response.sendRedirect("/index.jsp");
                return;
            }
        } catch (ParseException e){
            session.setAttribute("error", "An error has occurred, please contact the administrator");
            response.sendRedirect("/index.jsp");
            return;
        } finally {
            EntityUtils.consume(entity);
            httpResponse.close();
        }
        session.setAttribute("appliedJobsMap", appliedJobs);
        session.setAttribute("appliedJobsStatusMap", appliedJobsStatusMap);
        session.setAttribute("completedJobsList", completedJobs);
        response.sendRedirect("/mydashboard.jsp");
    }
}