package servlet;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import controller.AppController;
import controller.PostController;
import java.io.IOException;
import java.io.InputStream;
import java.io.StringWriter;
import java.lang.reflect.Type;

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
import model.User;
import org.apache.commons.io.IOUtils;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.message.BasicNameValuePair;

public class AcceptJobOfferServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        AppController appController = (AppController)session.getAttribute("appController");
        PostController postController = appController.getPostController();
        APIManager apiManager = appController.getAPIManager();
        String URL = apiManager.getEPAccept();
        User currentUser = (User)session.getAttribute("currentUser");
        int postID = Integer.parseInt(request.getParameter("post_id"));
        String email = currentUser.getEmail();
        String token = currentUser.getAuthenticationToken();
        
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
            String message = null;
            switch (statusCode){
                case 200:
                    message = "You have accepted the job offer!";
                    session.setAttribute("message", message);
                    break;
                case 401:
                    error = "A system error has occurred, please try again";
                    session.setAttribute("error", error);
                    response.sendRedirect("/index.jsp");
                    return;
                case 400:
                    error = "An error has occurred, please contact the administrator";
                    session.setAttribute("error", error);
                    break;
                case 201:
                    StringWriter writer = new StringWriter();
                    InputStream readingStream = entity.getContent();
                    IOUtils.copy(readingStream, writer, "UTF-8");
                    String responseString = writer.toString();
                    Gson gson = new Gson();
                    Type listType = new TypeToken<ArrayList<String>>(){}.getType();
                    ArrayList <String> postList = gson.fromJson(responseString, listType);
                    message = "You have accepted the job, but withdrawn your applications for the following:  ";
                    for (String postDropped : postList){
                        String[] valuesSplit = postDropped.split("\\|");
                        message += "<strong>" + valuesSplit[1] + ", </strong>";
                        postController.removeAppliedPost(Integer.parseInt(valuesSplit[0]));
                    }
                    message = message.substring(0, message.lastIndexOf(","));
                    session.setAttribute("message", message);
                    break;
            }
            response.sendRedirect("/mydashboard.jsp");
        } finally {
            httpResponse.close();
            EntityUtils.consume(entity);
        }
    }

}
