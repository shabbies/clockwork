package servlet;

import com.google.gson.Gson;
import com.google.gson.internal.LinkedTreeMap;
import com.google.gson.reflect.TypeToken;
import java.io.IOException;
import java.io.InputStream;
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
import java.util.HashMap;
import javax.servlet.ServletConfig;
import org.apache.commons.io.IOUtils;
import org.apache.http.client.methods.HttpGet;

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
            HashMap dataHash = gson.fromJson(((LinkedTreeMap)fullHash.get("data")).toString(), hashType);
            String retrievedAppID = ((Double)dataHash.get("app_id")).toString();
            String retrievedUserID = ((Double)dataHash.get("user_id")).toString();
            if (!retrievedAppID.equals(appID) || !retrievedUserID.equals(userID)){
                System.out.println(!retrievedAppID.equals(appID));
                System.out.println(!retrievedUserID.equals(userID));
                response.sendRedirect("/index.jsp");
                return;
            }
            EntityUtils.consume(entity);
        } finally {
            httpResponse.close();
        }
        
        // Grabbing user profile from FB
        System.out.println("BYE1");
        CloseableHttpClient httpclient2 = HttpClients.createDefault();
        HttpGet httpGet2 = new HttpGet("https://graph.facebook.com/me?" + accessToken + "&access_token=" + appID + "|" + appSecret);
        CloseableHttpResponse httpResponse2 = httpclient2.execute(httpGet2);
        System.out.println("BYE2");
        try {
            HttpEntity entity = httpResponse2.getEntity();
            StringWriter writer = new StringWriter();
            InputStream readingStream = entity.getContent();
            IOUtils.copy(readingStream, writer, "UTF-8");
            String responseString = writer.toString();
            Gson gson = new Gson();
            Type hashType = new TypeToken<HashMap<String, Object>>(){}.getType();
            HashMap fullHash = gson.fromJson(responseString, hashType);
            System.out.println("BYE");
            System.out.println((String)fullHash.get("email"));
            
            EntityUtils.consume(entity);
        } finally {
            httpResponse.close();
        }
    }

}
