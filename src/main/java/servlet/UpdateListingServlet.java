package servlet;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import controller.AppController;
import controller.MatchController;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.HashMap;
import javax.servlet.http.HttpSession;
import model.Match;

public class UpdateListingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // preparing variables
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        AppController appController = (AppController)session.getAttribute("appController");
        MatchController matchController = appController.getMatchController();
        int postID = Integer.parseInt(request.getParameter("post_id"));
        String date = request.getParameter("date");
        Gson gson = new Gson();
        Type hashType = new TypeToken<HashMap <String, String>>(){}.getType();
        
        HashMap <Integer, Match> matchMap = matchController.getPostMatchMap(postID);
        HashMap <String, String> returnMap = new HashMap <String, String> (); // serialised userID, checkin,checkout,day_wage
        for (int key : matchMap.keySet()){
            Match match = matchMap.get(key);
            HashMap <String, String> checkHash = gson.fromJson(gson.toJson(match.getTimings().get(date)), hashType);
            String checkIn = checkHash.get("check_in").equals("") ? "null" : checkHash.get("check_in");
            String checkOut = checkHash.get("check_out").equals("") ? "null" : checkHash.get("check_out");
            String dailyWage = checkHash.get("day_wage");
            returnMap.put(Integer.toString(key), checkIn + "," + checkOut + "," + dailyWage);
        }
        
        out.println(gson.toJson(returnMap));
    }

}
