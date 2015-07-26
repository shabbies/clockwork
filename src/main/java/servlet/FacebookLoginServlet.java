package servlet;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import controller.PostController;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.lang.reflect.Type;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletConfig;
import javax.servlet.http.HttpSession;
import model.Post;
import model.User;
import org.apache.commons.io.IOUtils;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.message.BasicNameValuePair;

public class FacebookLoginServlet extends HttpServlet {

    private String appID = null;
    private String appSecret = null;
    
    @Override
    public void init(ServletConfig servletConfig) throws ServletException{
        appID = servletConfig.getInitParameter("facebookAppID");
        appSecret = servletConfig.getInitParameter("facebookAppSecret");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accessToken = request.getParameter("access_token");
        String userID = request.getParameter("user_id");
        
        // Checking validity of accessToken
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpGet httpGet = new HttpGet("https://graph.facebook.com/debug_token?input_token=" + accessToken + "&access_token=" + appID + URLEncoder.encode("|", "UTF-8") + appSecret);
        CloseableHttpResponse httpResponse = httpclient.execute(httpGet);
        try {
            HttpEntity entity = httpResponse.getEntity();
            StringWriter writer = new StringWriter();
            InputStream readingStream = entity.getContent();
            IOUtils.copy(readingStream, writer, "UTF-8");
            String responseString = writer.toString();
            Gson gson = new Gson();
            Type hashType = new TypeToken<HashMap<String, Object>>(){}.getType();
            HashMap fullHash = gson.fromJson(responseString, hashType);
            HashMap dataHash = gson.fromJson((String)fullHash.get("data"), hashType);
            String retrievedAppID = (String)dataHash.get("app_id");
            String retrievedUserID = (String)dataHash.get("user_id");
            if (!retrievedAppID.equals(appID) || !retrievedUserID.equals(userID)){
                response.sendRedirect("/index.jsp");
                return;
            }
            EntityUtils.consume(entity);
        } finally {
            httpResponse.close();
        }
        
        // Grabbing user profile from FB
        httpGet = new HttpGet("https://graph.facebook.com/me?" + accessToken + "&access_token=" + appID + "|" + appSecret);
        httpResponse = httpclient.execute(httpGet);
        try {
            HttpEntity entity = httpResponse.getEntity();
            StringWriter writer = new StringWriter();
            InputStream readingStream = entity.getContent();
            IOUtils.copy(readingStream, writer, "UTF-8");
            String responseString = writer.toString();
            Gson gson = new Gson();
            Type hashType = new TypeToken<HashMap<String, Object>>(){}.getType();
            HashMap fullHash = gson.fromJson(responseString, hashType);
            System.out.println((String)fullHash.get("email"));
            
            EntityUtils.consume(entity);
        } finally {
            httpResponse.close();
        }
    }

}
