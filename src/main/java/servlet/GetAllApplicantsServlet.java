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
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpSession;
import model.APIManager;
import model.ApplicantHistory;
import model.User;
import org.apache.commons.io.IOUtils;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.message.BasicNameValuePair;

public class GetAllApplicantsServlet extends HttpServlet {

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
        String URL = apiManager.getEPAllApplicants();
        UserController userController = appController.getUserController();
        
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost(URL);
        httpPost.setHeader("Authentication-Token", token);
        List <NameValuePair> nvps = new ArrayList <NameValuePair>();
        nvps.add(new BasicNameValuePair("email", email));

        httpPost.setEntity(new UrlEncodedFormEntity(nvps));
        CloseableHttpResponse httpResponse = httpclient.execute(httpPost);

        HttpEntity entity = null;
        ArrayList <ApplicantHistory> applicantHistoryList = null;
        entity = httpResponse.getEntity();
        StringWriter writer = new StringWriter();
        InputStream readingStream = entity.getContent();
        IOUtils.copy(readingStream, writer, "UTF-8");
        String responseString = writer.toString();
        if(httpResponse.getStatusLine().getStatusCode() == 200){
            applicantHistoryList = userController.loadApplicantHistoryList(responseString);
        } else {
            String error = "A system error has occurred, please try again";
            session.setAttribute("error", error);
            response.sendRedirect("/index.jsp");
            return;
        }
        session.setAttribute("applicantHistoryList", applicantHistoryList);
        response.sendRedirect("/applicant_history.jsp");
    }

}
