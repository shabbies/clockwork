package servlet;

import controller.AppController;
import controller.PostController;
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
import model.Post;
import model.User;
import org.apache.commons.io.IOUtils;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.message.BasicNameValuePair;

public class ApplyJobServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int postID = Integer.parseInt(request.getParameter("post_id"));
        HttpSession session = request.getSession();
        User currentUser = (User)session.getAttribute("currentUser");
        if (currentUser == null){
            session.setAttribute("error", "Please login before applying for a job");
            session.setAttribute("loginSource", "apply_job-" + postID);
            response.sendRedirect("/login.jsp");
            return;
        } else if (currentUser.getAccountType().equals("employer")){
            session.setAttribute("error", "Only a job seeker account is able to apply for a job!");
            response.sendRedirect("/index.jsp");
            return;
        } else if (currentUser.getContactNumber() == 0 || currentUser.getDateOfBirth() == null || currentUser.getGender() == '\u0000' || currentUser.getNationality() == null){
            session.setAttribute("error", "Please complete your profile before applying for a job");
            session.setAttribute("updateSource", "apply_job-" + postID);
            response.sendRedirect("/complete_profile.jsp");
            return;
        }
        String email = currentUser.getEmail();
        String token = currentUser.getAuthenticationToken();
        AppController appController = (AppController)session.getAttribute("appController");
        APIManager apiManager = appController.getAPIManager();
        String URL = apiManager.getEPApply();
        PostController postController = appController.getPostController();
        Post post = postController.getPost(postID);
        
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost(URL);
        httpPost.setHeader("Authentication-Token", token);
        List <NameValuePair> nvps = new ArrayList <NameValuePair>();
        nvps.add(new BasicNameValuePair("post_id", "" + postID));
        nvps.add(new BasicNameValuePair("email", email));

        httpPost.setEntity(new UrlEncodedFormEntity(nvps));
        CloseableHttpResponse httpResponse = httpclient.execute(httpPost);
        HttpEntity entity = null;
        try {
            entity = httpResponse.getEntity();
            int statusCode = httpResponse.getStatusLine().getStatusCode();
            String error = null;
            switch (statusCode){
                case 403:
                    error = "You have already applied for this job!";
                    session.setAttribute("error", error);
                    response.sendRedirect("/index.jsp");
                    return;
                case 401:
                    error = "There is a problem with the job application, please contact the administrator";
                    session.setAttribute("error", error);
                    response.sendRedirect("/index.jsp");
                    return;
                case 200:
                    post.setStatus("applied");
                    String message = "You have successfully applied for this job!";
                    session.setAttribute("message", message);
                    response.sendRedirect("/mydashboard.jsp");
                    return;
                case 400:
                    StringWriter writer = new StringWriter();
                    InputStream readingStream = entity.getContent();
                    IOUtils.copy(readingStream, writer, "UTF-8");
                    String responseString = writer.toString();
                    switch (responseString){
                        case "Bad Request - Post not found":
                            error = "There is a problem with the job application, please contact the administrator";
                            break;
                        case "Bad Request - Only job seekers are allowed to apply for a job":
                            error = "Only job seekers are allowed to apply for a job!";
                            break;
                        case "Bad Request - You have already applied for another job that clashes with this":
                            error = "You have applied for another job that clashes with this!";
                            break;
                    }
                    session.setAttribute("error", error);
                    response.sendRedirect("/index.jsp");
                    return;
            }
            
        } finally {
            httpResponse.close();
            EntityUtils.consume(entity);
        }
        
        
    }

}
