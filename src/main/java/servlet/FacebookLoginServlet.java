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
import javax.servlet.http.HttpSession;
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
        
        Gson gson = new Gson();
        Type hashType = new TypeToken<HashMap<String, Object>>(){}.getType();
        
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
            HashMap fullHash = gson.fromJson(responseString, hashType);
            HashMap dataHash = gson.fromJson(((LinkedTreeMap)fullHash.get("data")).toString(), hashType);
            String retrievedUserAppID = String.valueOf(((Double)dataHash.get("app_id")).intValue());
            String retrievedUserID = String.valueOf(((Double)dataHash.get("user_id")).intValue());
            if (!retrievedUserID.equals(userID)){
                System.out.println(userID);
                System.out.println(retrievedUserID);
                String errorMessage = "There is a problem with your Facebook login, please try again.";
                response.sendError(500, errorMessage);
            }
            response.setStatus(200);
        } finally {
            httpResponse.close();
        }
    }
}