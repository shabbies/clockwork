package model;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;

public class MatchManager {
    private HashMap <Integer, Match> matchMap;                  // userid, match
    private HashMap <Integer, ArrayList <Match>> postMatchMap;  // postID, match
    
    public MatchManager(){
        matchMap = new HashMap <Integer, Match> ();
        postMatchMap = new HashMap <Integer, ArrayList <Match>> ();
    }
    
    public HashMap <Integer, Match> loadMatchMap (String JSONString) throws ParseException {
        Gson gson = new Gson();
        Type hashType = new TypeToken<ArrayList<HashMap <String, Object>>>(){}.getType();
        ArrayList<HashMap <String, Object>> matchList = gson.fromJson(JSONString, hashType);
        for (HashMap <String, Object> matchHash : matchList){
            String matchJSON = gson.toJson(matchHash);
            Match match = createMatchFromJSONString(matchJSON);
            matchMap.put(match.getUserId(), match);
            ArrayList <Match> list = (postMatchMap.get(match.getPostId()) == null) ? new ArrayList <Match> () : postMatchMap.get(match.getPostId());
            list.add(match);
            postMatchMap.put(match.getPostId(), list);
        }
        return matchMap;
    }
    
    public Match createMatchFromJSONString(String JSONString) throws ParseException {
        Gson gson = new Gson();
        Type hashType = new TypeToken<HashMap <String, Object>>(){}.getType();
        HashMap <String, Object> matchHash = gson.fromJson(JSONString, hashType);
        int userID = ((Double)matchHash.get("applicant_id")).intValue();
        int postID = ((Double)matchHash.get("post_id")).intValue();
        String status = (String)matchHash.get("status");
        int rating = 2;
        if (matchHash.get("user_rating") != null){
            rating = ((Double)matchHash.get("user_rating")).intValue();
        }
        String comment = (String)matchHash.get("comments");
        HashMap <String, Object> timingsHash = gson.fromJson(gson.toJson(matchHash.get("job_timings")), hashType);
        return new Match(userID, postID, rating, comment, status, timingsHash);
    }
    
    public HashMap <Integer, Match> getPostMatchMap (int postID){
        HashMap <Integer, Match> returnMap = new HashMap <Integer, Match> ();
        ArrayList <Match> matchList = postMatchMap.get(postID);
        if (matchList != null){
            for (Match match : matchList){
                returnMap.put(match.getUserId(), match);
            }
        }
        return returnMap;
    }
}