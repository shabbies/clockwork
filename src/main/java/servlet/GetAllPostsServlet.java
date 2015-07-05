package servlet;

import controller.PostController;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import java.io.StringWriter;
import java.util.ArrayList;
import javax.servlet.http.HttpSession;
import model.Post;
import org.apache.commons.io.IOUtils;

public class GetAllPostsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpGet httpGet = new HttpGet("https://clockwork-api.herokuapp.com/api/v1/posts/all.json");
        CloseableHttpResponse response1 = httpclient.execute(httpGet);
        ArrayList <Post> postList;
        try {
            HttpEntity entity1 = response1.getEntity();
            StringWriter writer = new StringWriter();
            IOUtils.copy(entity1.getContent(), writer, "UTF-8");
            String theString = writer.toString();
            PostController postController = new PostController();
            postList = postController.createPostFromJSON(theString);
            EntityUtils.consume(entity1);
        } finally {
            response1.close();
        }
        session.setAttribute("postList", postList);
        response.sendRedirect("/posts.jsp");

        
        /*CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost("http://targethost/login");
        List <NameValuePair> nvps = new ArrayList <NameValuePair>();
        nvps.add(new BasicNameValuePair("username", "vip"));
        nvps.add(new BasicNameValuePair("password", "secret"));
        httpPost.setEntity(new UrlEncodedFormEntity(nvps));
        CloseableHttpResponse response2 = httpclient.execute(httpPost);

        try {
            System.out.println(response2.getStatusLine());
            HttpEntity entity2 = response2.getEntity();
            // do something useful with the response body
            // and ensure it is fully consumed
            EntityUtils.consume(entity2);
        } finally {
            response2.close();
        }*/
    }

}
