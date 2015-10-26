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
import model.Question;
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

public class GetQuizServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // preparing variables
        HttpSession session = request.getSession();
        AppController appController = (AppController)session.getAttribute("appController");
        UserController userController = appController.getUserController();
        APIManager apiManager = appController.getAPIManager();
        String URL = apiManager.getEPQuiz();
        User currentUser = (User)session.getAttribute("currentUser");
        String email = currentUser.getEmail();
        String token = currentUser.getAuthenticationToken();
        String genre = request.getParameter("type");
        
        // retrieve stored data
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost(URL);
        httpPost.setHeader("Authentication-Token", token);
        List <NameValuePair> nvps = new ArrayList <NameValuePair>();
        nvps.add(new BasicNameValuePair("email", email));
        nvps.add(new BasicNameValuePair("genre", genre));
        httpPost.setEntity(new UrlEncodedFormEntity(nvps));
        
        CloseableHttpResponse httpResponse = httpclient.execute(httpPost);
        HttpEntity entity = null;
        ArrayList <Question> questionList = null;
        try {
            entity = httpResponse.getEntity();
            StringWriter writer = new StringWriter();
            InputStream readingStream = entity.getContent();
            IOUtils.copy(readingStream, writer, "UTF-8");
            String responseString = writer.toString();
            int statusCode = httpResponse.getStatusLine().getStatusCode();
            switch (statusCode){
                case 200:
                    questionList = userController.loadQuestionList(responseString);
                    break;
                case 400:
                    session.setAttribute("error", "Invalid quiz genre, please contact the administrator");
                    response.sendRedirect("/index.jsp");
                    return;
                case 403:
                    session.setAttribute("error", "There are no more quizzes available! Try working instead!");
                    response.sendRedirect("/scoreboard.jsp");
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
        
        session.setAttribute("question1", questionList.get(0));
        session.setAttribute("question2", questionList.get(1));
        session.setAttribute("question3", questionList.get(2));
        session.setAttribute("question4", questionList.get(3));
        session.setAttribute("question5", questionList.get(4));
        session.setAttribute("currentQuestion", "1");
        session.setAttribute("score", "0");
        session.setAttribute("genre", genre);
        response.sendRedirect("/quiz.jsp");
    }
}