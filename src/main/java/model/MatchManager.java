package model;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;

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
        DateFormat df = new SimpleDateFormat("h:mm a", Locale.ENGLISH);
        Date startTime = (matchHash.get("job_start_time") == null) ? null : df.parse((String)matchHash.get("job_start_time"));
        Date endTime = (matchHash.get("job_end_time") == null) ? null : df.parse((String)matchHash.get("job_end_time"));
        return new Match(userID, postID, rating, comment, status, startTime, endTime);
    }
    
    public HashMap <Integer, Match> getPostMatchMap (int postID){
        HashMap <Integer, Match> returnMap = new HashMap <Integer, Match> ();
        ArrayList <Match> matchList = postMatchMap.get(postID);
        for (Match match : matchList){
            returnMap.put(match.getUserId(), match);
        }
        return returnMap;
    }
}