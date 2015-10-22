package servlet;

import controller.AppController;
import java.io.IOException;

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
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.message.BasicNameValuePair;

public class ContestRegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        AppController appController = (AppController)session.getAttribute("appController");
        APIManager apiManager = appController.getAPIManager();
        String URL = apiManager.getEPContestRegister();
        
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost(URL);
        List <NameValuePair> nvps = new ArrayList <NameValuePair>();
        nvps.add(new BasicNameValuePair("email", email));
        nvps.add(new BasicNameValuePair("name", name));

        httpPost.setEntity(new UrlEncodedFormEntity(nvps));
        CloseableHttpResponse httpResponse = httpclient.execute(httpPost);
        HttpEntity entity = httpResponse.getEntity();
        try {
            int statusCode = httpResponse.getStatusLine().getStatusCode();
            String error = null;
            switch (statusCode){
                case 200:
                    String message = "You have successfully sent your email!";
                    session.setAttribute("message", message);
                    response.sendRedirect("/campaign.jsp");
                    return;
                case 400:
                    error = "You have entered an invalid email!";
                    session.setAttribute("error", error);
                    response.sendRedirect("/campaign.jsp");
                    return;
                default:
                    error = "A system error has occurred, please inform the administrator";
                    session.setAttribute("error", error);
                    response.sendRedirect("/index.jsp");
            }
        } finally {
            EntityUtils.consume(entity);
            httpResponse.close();
        }
        
    }
}
