package servlet;

import controller.AppController;
import controller.NotificationController;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

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
import java.util.List;
import javax.servlet.http.HttpSession;
import model.APIManager;
import model.User;
import org.apache.commons.io.IOUtils;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.message.BasicNameValuePair;

public class ReadNotificationsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // preparing variables
        HttpSession session = request.getSession();
        User currentUser = (User)session.getAttribute("currentUser");
        String email = currentUser.getEmail();
        String token = currentUser.getAuthenticationToken();
        String notificationIDs = request.getParameter("notification_ids");
        AppController appController = (AppController)session.getAttribute("appController");
        NotificationController notificationController = appController.getNotificationController();
        APIManager apiManager = appController.getAPIManager();
        String URL = apiManager.getEPReadNotifications();
        
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost(URL);
        httpPost.setHeader("Authentication-Token", token);
        List <NameValuePair> nvps = new ArrayList <NameValuePair>();
        nvps.add(new BasicNameValuePair("email", email));
        nvps.add(new BasicNameValuePair("notification_ids", notificationIDs));

        httpPost.setEntity(new UrlEncodedFormEntity(nvps));
        CloseableHttpResponse httpResponse = httpclient.execute(httpPost);

        HttpEntity entity = null;
        try {
            entity = httpResponse.getEntity();
            int statusCode = httpResponse.getStatusLine().getStatusCode();
            StringWriter writer = new StringWriter();
            InputStream readingStream = entity.getContent();
            IOUtils.copy(readingStream, writer, "UTF-8");
            PrintWriter out = response.getWriter();
            switch (statusCode){
                case 200:
                    notificationController.readNotifications(notificationIDs);
                    session.setAttribute("readList", notificationController.getReadList());
                    session.setAttribute("unreadList", notificationController.getUnreadList());
                    out.println("success");
                default:
                    String error = "A system error has occurred, please contact the administrator";
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