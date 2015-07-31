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
        
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpGet httpGet = new HttpGet("https://graph.facebook.com/oauth/access_token?grant_type=fb_exchange_token&client_id=" + URLEncoder.encode(appID, "UTF-8") + "&client_secret=" + URLEncoder.encode(appSecret, "UTF-8") + "&fb_exchange_token=" + URLEncoder.encode(accessToken, "UTF-8"));
        CloseableHttpResponse httpResponse = httpclient.execute(httpGet);
        try {
            HttpEntity entity = httpResponse.getEntity();
            StringWriter writer = new StringWriter();
            InputStream readingStream = entity.getContent();
            IOUtils.copy(readingStream, writer, "UTF-8");
            String responseString = writer.toString();
            System.out.println(responseString);
            HashMap fullHash = gson.fromJson(responseString, hashType);
            
        } finally {
            httpResponse.close();
        }
    }
}