package servlet;

import com.google.gson.Gson;
import controller.AppController;
import controller.PostController;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.StringWriter;

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
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.TimeUnit;
import javax.servlet.http.HttpSession;
import model.Post;
import model.User;
import org.apache.commons.io.IOUtils;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.message.BasicNameValuePair;

public class CheckJobDateClashServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        AppController appController = (AppController)session.getAttribute("appController");
        PostController postController = appController.getPostController();
        ArrayList <Post> postList = (ArrayList <Post>)session.getAttribute("pendingAcceptanceJobs");
        int postID = Integer.parseInt(request.getParameter("post_id"));
        session.removeAttribute("pendingAcceptance");
        
        ArrayList<Post> conflictedPosts = postController.identifyConflictedPosts(postList, postID);
        Gson gson = new Gson();
        ArrayList<HashMap <Integer, String>> conflictedPostsList = new ArrayList <HashMap <Integer, String>> ();
        for (Post post : conflictedPosts){
            HashMap <Integer, String> postMap = new HashMap <Integer, String> ();
            postMap.put(post.getId(), post.getHeader());
            conflictedPostsList.add(postMap);
        }
        out.println(gson.toJson(conflictedPostsList));
    }
}
