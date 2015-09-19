package servlet;

import controller.AppController;
import controller.PostController;
import java.io.IOException;
import java.io.InputStream;
import java.io.StringWriter;
import java.text.ParseException;
import javax.servlet.RequestDispatcher;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.http.HttpSession;
import model.Post;
import org.apache.commons.io.IOUtils;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

public class GetPostServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // preparing variables
        String location = request.getParameter("location");
        String postID = request.getParameter("id");
        HttpSession session = request.getSession();
        AppController appController = (AppController)session.getAttribute("appController");
        PostController postController = appController.getPostController();
        
        // retrieve stored data
        Post post = postController.getPost(Integer.parseInt(postID));
        if (post == null){
            CloseableHttpClient httpclient = HttpClients.createDefault();
            HttpGet httpGet = new HttpGet("https://clockwork-api.herokuapp.com/api/v1/posts/get_post?post_id=" + postID);
            CloseableHttpResponse httpResponse = httpclient.execute(httpGet);
            HttpEntity entity = null;
            try {
                entity = httpResponse.getEntity();
                if (httpResponse.getStatusLine().getStatusCode() == 200){
                    StringWriter writer = new StringWriter();
                    InputStream readingStream = entity.getContent();
                    IOUtils.copy(readingStream, writer, "UTF-8");
                    String responseString = writer.toString();
                    post = postController.getPostFromJSON(responseString);
                    IOUtils.closeQuietly(readingStream);
                } else {
                    String error = "The post ID is invalid!";
                    session.setAttribute("error", error);
                    response.sendRedirect("/index.jsp");
                    return;
                }
            } catch (ParseException e){
                session.setAttribute("error", "An error has occurred, please contact the administrator");
                response.sendRedirect("/index.jsp");
                return;
            } finally {
                EntityUtils.consume(entity);
                httpResponse.close();
            }
        }
        session.setAttribute("post", post);
        RequestDispatcher rd = null;
        switch (location) {
            case "post":
                request.setAttribute("facebookURL", "http://clockworksmu.herokuapp.com/post.jsp?id=" + postID);
                request.setAttribute("facebookTitle", post.getHeader() + " at " + post.getCompany());
                rd = request.getRequestDispatcher("/post.jsp?id=" + postID);
                rd.forward(request, response);
                break;
            case "edit":
                response.sendRedirect("/edit_post.jsp?id=" + postID);
                return;
            case "listing":
            case "completed":
            case "reviewing":
                rd = request.getRequestDispatcher("/GetJobApplicantsServlet?id=" + postID + "&location=" + location);
                rd.forward(request, response);
                break;
        }
    }
}