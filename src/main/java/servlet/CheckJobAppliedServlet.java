package servlet;

import controller.AppController;
import controller.PostController;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.http.HttpSession;

public class CheckJobAppliedServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        AppController appController = (AppController)session.getAttribute("appController");
        PostController postController = appController.getPostController();
        int postID = Integer.parseInt(request.getParameter("post_id"));
        boolean hasApplied = postController.checkIfJobApplied(postID);
        if (!hasApplied){
            RequestDispatcher rd = request.getRequestDispatcher("/CheckJobDateClashServlet?type=apply&post_id=" + postID);
            rd.forward(request, response);
        } else {
            out.println(hasApplied);
        }
    }
}
