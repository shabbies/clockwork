package model;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.HashMap;

public class BadgeManager {
    private ArrayList <Badge> badgeList;
    
    public BadgeManager(){
        badgeList = new ArrayList <Badge> ();
    }
    
    public ArrayList <Badge> loadBadgeList(String JSONString){
        if (!badgeList.isEmpty()){
            return badgeList;
        }
        
        Gson gson = new Gson();
        Type arrayType = new TypeToken<ArrayList <HashMap>>(){}.getType();
        ArrayList <HashMap> overallMap = gson.fromJson(JSONString, arrayType);
        
        for (HashMap <String, Object> badgeMap : overallMap){
            String name = (String)badgeMap.get("name");
            String criteria = (String)badgeMap.get("criteria");
            String link = (String)badgeMap.get("badge_image_link");
            String status = (String)badgeMap.get("status");
            Badge badge = new Badge(name, criteria, link, status);
            badgeList.add(badge);
        }
        
        return badgeList;
    }
}
