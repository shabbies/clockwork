package servlet;

import controller.AppController;
import controller.PostController;
import java.io.IOException;
import javax.servlet.RequestDispatcher;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.http.HttpSession;
import model.Post;

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
            String error = "Invalid Post ID";
            session.setAttribute("error", error);
            response.sendRedirect("/index.jsp");
            return;
        }
        session.setAttribute("post", post);
        if (location.equals("post")){
            response.sendRedirect("/post.jsp?id=" + postID);
            return;
        } else if (location.equals("edit")){
            response.sendRedirect("/edit_post.jsp?id=" + postID);
            return;
        } else if (location.equals("listing") || location.equals("completed") || location.equals("reviewing")){
            RequestDispatcher rd = request.getRequestDispatcher("/GetJobApplicantsServlet?id=" + postID + "&location=" + location);
            rd.forward(request, response);
        }
    }
}