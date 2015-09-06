package model;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.HashMap;

public class MatchManager {
    private HashMap <Integer, Match> matchMap; //userid, match
    
    public MatchManager(){
        matchMap = new HashMap <Integer, Match> ();
    }
    
    public HashMap <Integer, Match> loadMatchMap (String JSONString){
        Gson gson = new Gson();
        Type hashType = new TypeToken<ArrayList<HashMap <String, Object>>>(){}.getType();
        ArrayList<HashMap <String, Object>> matchList = gson.fromJson(JSONString, hashType);
        for (HashMap <String, Object> matchHash : matchList){
            String matchJSON = gson.toJson(matchHash);
            Match match = createMatchFromJSONString(matchJSON);
            matchMap.put(match.getUserId(), match);
        }
        return matchMap;
    }
    
    public Match createMatchFromJSONString(String JSONString){
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
        return new Match(userID, postID, rating, comment, status);
    }
}