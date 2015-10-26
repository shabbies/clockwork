package servlet;

import controller.AppController;
import controller.UserController;
import java.io.IOException;
import java.io.InputStream;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.http.HttpSession;
import model.APIManager;
import model.User;
import org.apache.commons.io.IOUtils;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

public class RecordScoreServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // preparing variables
        HttpSession session = request.getSession();
        AppController appController = (AppController)session.getAttribute("appController");
        UserController userController = appController.getUserController();
        APIManager apiManager = appController.getAPIManager();
        String URL = apiManager.getEPRecordQuiz();
        User currentUser = (User)session.getAttribute("currentUser");
        String email = currentUser.getEmail();
        String token = currentUser.getAuthenticationToken();
        String genre = request.getParameter("genre");
        String questions = request.getParameter("questions");
        if (!questions.isEmpty()){
            questions = questions.substring(0, questions.lastIndexOf(","));
        }
        
        // retrieve stored data
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost(URL);
        httpPost.setHeader("Authentication-Token", token);
        List <NameValuePair> nvps = new ArrayList <NameValuePair>();
        nvps.add(new BasicNameValuePair("email", email));
        nvps.add(new BasicNameValuePair("genre", genre));
        nvps.add(new BasicNameValuePair("questions", questions));
        httpPost.setEntity(new UrlEncodedFormEntity(nvps));
        
        CloseableHttpResponse httpResponse = httpclient.execute(httpPost);
        HttpEntity entity = null;
        try {
            entity = httpResponse.getEntity();
            StringWriter writer = new StringWriter();
            InputStream readingStream = entity.getContent();
            IOUtils.copy(readingStream, writer, "UTF-8");
            String responseString = writer.toString();
            int statusCode = httpResponse.getStatusLine().getStatusCode();
            switch (statusCode){
                case 200:
                    return;
                case 400:
                    session.setAttribute("error", "Invalid quiz genre, please contact the administrator");
                    response.sendRedirect("/index.jsp");
                    return;
                case 401:
                default:
                    session.setAttribute("error", "An error has occurred, please contact the administrator");
                    response.sendRedirect("/index.jsp");
                    return;
            }
        } finally {
            EntityUtils.consume(entity);
            httpResponse.close();
        }
    }
}