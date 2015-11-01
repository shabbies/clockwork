package servlet;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import controller.AppController;
import controller.UserController;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.lang.reflect.Type;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletConfig;
import javax.servlet.http.HttpSession;
import model.APIManager;
import model.User;
import org.apache.commons.io.IOUtils;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

public class FacebookLoginServlet extends HttpServlet {

    private String appID = null;
    private String appSecret = null;
    private String stagingAppID = null;
    private String stagingAppSecret = null;
    
    @Override
    public void init(ServletConfig servletConfig) throws ServletException{
        appID = servletConfig.getInitParameter("facebookAppID");
        appSecret = servletConfig.getInitParameter("facebookAppSecret");
        stagingAppID = servletConfig.getInitParameter("staging-facebookAppID");
        stagingAppSecret = servletConfig.getInitParameter("staging-facebookAppSecret");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        AppController appController = (AppController)session.getAttribute("appController");
        APIManager apiManager = appController.getAPIManager();
        String URL = apiManager.getEPNewUser();
        PrintWriter out = response.getWriter();
        
        String shortAccessToken = request.getParameter("access_token");
        String userID = request.getParameter("user_id");
        String referrer = request.getParameter("referrer");
        String longAccessToken = null;
        String facebookAppID = null;
        String fullname = null;
        String email = null;
        String accountType = "job_seeker";
        
        Gson gson = new Gson();
        Type hashType = new TypeToken<HashMap<String, Object>>(){}.getType();
        
        // Extending access token
        CloseableHttpClient httpclient = HttpClients.createDefault();
        String accessTokenExtensionURL = "https://graph.facebook.com/oauth/access_token?grant_type=fb_exchange_token&client_id=" + URLEncoder.encode(appID, "UTF-8") + "&client_secret=" + URLEncoder.encode(appSecret, "UTF-8") + "&fb_exchange_token=" + URLEncoder.encode(shortAccessToken, "UTF-8");
        if (appController.getEnvironment().equals("staging")){
            accessTokenExtensionURL = "https://graph.facebook.com/oauth/access_token?grant_type=fb_exchange_token&client_id=" + URLEncoder.encode(stagingAppID, "UTF-8") + "&client_secret=" + URLEncoder.encode(stagingAppSecret, "UTF-8") + "&fb_exchange_token=" + URLEncoder.encode(shortAccessToken, "UTF-8");
        }
        
        HttpGet httpGet = new HttpGet(accessTokenExtensionURL);
        CloseableHttpResponse httpResponse = httpclient.execute(httpGet);
        try {
            HttpEntity entity = httpResponse.getEntity();
            StringWriter writer = new StringWriter();
            InputStream readingStream = entity.getContent();
            IOUtils.copy(readingStream, writer, "UTF-8");
            String responseString = writer.toString();
            longAccessToken = responseString.substring(responseString.indexOf("=") + 1, responseString.indexOf("&"));
            session.setAttribute("accessToken", longAccessToken);
            EntityUtils.consume(entity);
        } finally {
            httpResponse.close();
        }
        
        // Getting user profile
        httpGet = new HttpGet("https://graph.facebook.com/me?fields=id,name,email&access_token=" + URLEncoder.encode(longAccessToken, "UTF-8"));
        CloseableHttpResponse httpResponse2 = httpclient.execute(httpGet);
        try {
            HttpEntity entity = httpResponse2.getEntity();
            StringWriter writer = new StringWriter();
            InputStream readingStream = entity.getContent();
            IOUtils.copy(readingStream, writer, "UTF-8");
            String responseString = writer.toString();
            HashMap userHash = gson.fromJson(responseString, hashType);
            facebookAppID = (String)userHash.get("id");
            fullname = (String)userHash.get("name");
            email = (String)userHash.get("email");
            EntityUtils.consume(entity);
        } finally {
            httpResponse2.close();
        }
        
        // Registering user
        HttpPost httpPost = new HttpPost(URL);
        httpPost.setHeader("Accept", "application/json");
        List <NameValuePair> nvps = new ArrayList <NameValuePair>();
        nvps.add(new BasicNameValuePair("user[email]", email));
        nvps.add(new BasicNameValuePair("user[username]", fullname));
        nvps.add(new BasicNameValuePair("user[account_type]",accountType));
        nvps.add(new BasicNameValuePair("user[facebook_id]", facebookAppID));
        nvps.add(new BasicNameValuePair("user[referred_by]", referrer));
        nvps.add(new BasicNameValuePair("user[avatar_path]", "http://graph.facebook.com/" + facebookAppID + "/picture?type=large"));
        
        httpPost.setEntity(new UrlEncodedFormEntity(nvps));
        CloseableHttpResponse response3 = httpclient.execute(httpPost);
        User user = null;
        try {
            HttpEntity entity = response3.getEntity();  
            StringWriter writer = new StringWriter();
            IOUtils.copy(entity.getContent(), writer, "UTF-8");
            String responseString = writer.toString();
            UserController userController = appController.getUserController();
            user = userController.createUserFromJSON(responseString);
            user = userController.login(user);
            EntityUtils.consume(entity);
        } finally {
            response3.close();
        }
        session.setAttribute("currentUser", user);
        if (user.getContactNumber() == 0 || user.getDateOfBirth() == null || user.getGender() == '\u0000' || user.getNationality() == null){
            session.setAttribute("message", "Please complete your profile to enter the competition!");
            out.println("/complete_profile.jsp");
        } else {
            out.println("/mydashboard.jsp");
        }
    }
}