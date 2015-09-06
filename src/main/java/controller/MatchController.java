package controller;

import java.util.HashMap;
import model.Match;
import model.MatchManager;

public class MatchController {
    private MatchManager matchManager;
    
    public MatchController(){
        matchManager = new MatchManager();
    }
    
    public HashMap <Integer, Match> loadMatchMap(String JSONString){
        return matchManager.loadMatchMap(JSONString);
    }
}
