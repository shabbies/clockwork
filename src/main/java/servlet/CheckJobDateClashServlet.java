package servlet;

import com.google.gson.Gson;
import controller.AppController;
import controller.PostController;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.http.HttpSession;
import model.Post;

public class CheckJobDateClashServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        AppController appController = (AppController)session.getAttribute("appController");
        PostController postController = appController.getPostController();
        ArrayList <Post> postList = null;
        String type = request.getParameter("type");
        int postID = Integer.parseInt(request.getParameter("post_id"));
        
        if (type.equals("accept")){
            postList = postController.getPendingAndOfferedJobs();
        } else {
            postList = postController.getHiredJobs();
        }
        
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
