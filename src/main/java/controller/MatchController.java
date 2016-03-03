package controller;

import java.text.ParseException;
import java.util.HashMap;
import model.Match;
import model.MatchManager;

public class MatchController {
    private MatchManager matchManager;
    
    public MatchController(){
        matchManager = new MatchManager();
    }
    
    public HashMap <Integer, Match> loadMatchMap(String JSONString) throws ParseException{
        return matchManager.loadMatchMap(JSONString);
    }
    
    public HashMap <Integer, Match> getPostMatchMap(int postID){
        return matchManager.getPostMatchMap(postID); //userID, match
    }
}
