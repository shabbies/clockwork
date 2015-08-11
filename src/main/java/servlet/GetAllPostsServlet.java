package servlet;

import controller.AppController;
import controller.PostController;
import java.io.IOException;
import java.io.InputStream;

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
        
        // preparing variables
        HttpSession session = request.getSession();
        AppController appController = null;
        if (session.getAttribute("appController") == null){
            appController = new AppController();
            session.setAttribute("appController", appController);
        } else {
            appController = (AppController)session.getAttribute("appController");
        }
        PostController postController = appController.getPostController();
        
        // httpget request
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpGet httpGet = new HttpGet("https://clockwork-api.herokuapp.com/api/v1/posts/all.json");
        CloseableHttpResponse httpResponse = httpclient.execute(httpGet);
        ArrayList <Post> postList;
        try {
            HttpEntity entity = httpResponse.getEntity();
            StringWriter writer = new StringWriter();
            InputStream readingStream = entity.getContent();
            IOUtils.copy(readingStream, writer, "UTF-8");
            String theString = writer.toString();
            postList = postController.loadPostList(theString);
            EntityUtils.consume(entity);
            IOUtils.closeQuietly(readingStream);
        } finally {
            httpResponse.close();
        }
        session.setAttribute("postList", postList);
        response.sendRedirect("/index.jsp");
    }
}