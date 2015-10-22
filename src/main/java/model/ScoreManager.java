package model;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.HashMap;

public class ScoreManager {
    private HashMap <String, Integer> scoreMap;
    
    public ScoreManager(){
        scoreMap = new HashMap <String, Integer> ();
    }
    
    public HashMap <String, Integer> loadScoreMap(String JSONString){
        Gson gson = new Gson();
        Type arrayType = new TypeToken<HashMap <String, ArrayList <HashMap>>>(){}.getType();
        HashMap<String, ArrayList<HashMap>> overallMap = gson.fromJson(JSONString, arrayType);
        ArrayList<HashMap> fullScoreMap = overallMap.get("scores");
        
        for (HashMap <String, Object> score : fullScoreMap){
            String type = (String)score.get("type");
            int value = ((Double)score.get("score")).intValue();
            scoreMap.put(type, value);
        }
        
        return scoreMap;
    }
}