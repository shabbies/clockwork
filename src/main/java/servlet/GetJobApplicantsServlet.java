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
import model.APIManager;
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
        APIManager apiManager = appController.getAPIManager();
        String URL = apiManager.getEPApplicants();
        UserController userController = appController.getUserController();
        
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
            if(httpResponse.getStatusLine().getStatusCode() == 201){
                StringWriter writer = new StringWriter();
                InputStream readingStream = entity.getContent();
                IOUtils.copy(readingStream, writer, "UTF-8");
                String responseString = writer.toString();
                HashMap<String, ArrayList <User>> applicantMap = userController.loadPostApplicants(responseString);
                RequestDispatcher rd = null;
                switch (location){
                    case "listing":
                        session.setAttribute("hiredList", applicantMap.get("hired"));
                        session.setAttribute("applicantList", applicantMap.get("pending"));
                        session.setAttribute("offeredList", applicantMap.get("offered"));
                        rd = request.getRequestDispatcher("/GetCompletedApplicantsServlet?id=" + postID + "&location=listing");
                        rd.forward(request, response);
                        break;
                    case "reviewing":
                        session.setAttribute("hiredList", applicantMap.get("hired"));
                        session.setAttribute("completedList", applicantMap.get("completed"));
                        rd = request.getRequestDispatcher("/GetCompletedApplicantsServlet?id=" + postID + "&location=reviewing");
                        rd.forward(request, response);
                        break;
                    case "manage":
                        session.setAttribute("hiredList", applicantMap.get("hired"));
                        rd = request.getRequestDispatcher("/GetCompletedApplicantsServlet?id=" + postID + "&location=manage");
                        rd.forward(request, response);
                        break;
                    default:
                        session.setAttribute("completedList", applicantMap.get("completed"));
                        rd = request.getRequestDispatcher("/GetCompletedApplicantsServlet?id=" + postID + "&location=completed");
                        rd.forward(request, response);
                        break;
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