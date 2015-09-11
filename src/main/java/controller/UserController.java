package controller;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.HashMap;
import model.User;
import model.UserManager;

public class UserController {
    private User currentUser;
    private UserManager userManager;
    
    public UserController(){
        userManager = new UserManager();
        currentUser = userManager.getCurrentUser();
    }
    
    public User getCurrentUser(){
        return currentUser;
    }
    
    public User createUserFromJSON(String JSONString){
        return userManager.createUserFromJSON(JSONString);
    }
    
    public ArrayList<User> createUsersFromJSONArray(String JSONString){
        Gson gson = new Gson();
        Type listType = new TypeToken<ArrayList<HashMap<String, Object>>>(){}.getType();
        ArrayList<HashMap<String, Object>> userRecordList = gson.fromJson(JSONString, listType);
        ArrayList<User> userList = new ArrayList <User>();
        for (HashMap<String, Object> userMap : userRecordList){
            String userString = gson.toJson(userMap);
            User user = createUserFromJSON(userString);
            userList.add(user);
        }
        return userList;
    }
    
    public HashMap<String, ArrayList <User>> loadPostApplicants (String JSONString){
        Gson gson = new Gson();
        Type hashType = new TypeToken<HashMap <String, ArrayList <HashMap>>>(){}.getType();
        HashMap<String, ArrayList<HashMap>> applicantMap = gson.fromJson(JSONString, hashType);
        
        ArrayList<HashMap> pendingMap = applicantMap.get("pending");
        ArrayList<HashMap> offeredMap = applicantMap.get("offered");
        ArrayList<HashMap> hiredMap = applicantMap.get("hired");
        ArrayList<HashMap> reviewingMap = applicantMap.get("reviewing");
        ArrayList<HashMap> completedMap = applicantMap.get("completed");
        
        ArrayList<User> pendingUsers = createUsersFromJSONArray(gson.toJson(pendingMap));
        ArrayList<User> offeredUsers = createUsersFromJSONArray(gson.toJson(offeredMap));
        ArrayList<User> hiredUsers = createUsersFromJSONArray(gson.toJson(hiredMap));
        ArrayList<User> reviewingUsers = createUsersFromJSONArray(gson.toJson(reviewingMap));
        ArrayList<User> completedUsers = createUsersFromJSONArray(gson.toJson(completedMap));
        
        HashMap <String, ArrayList <User>> returnMap = new HashMap <String, ArrayList <User>> ();
        returnMap.put("pending", pendingUsers);
        returnMap.put("offered", offeredUsers);
        returnMap.put("hired", hiredUsers);
        returnMap.put("reviewing", reviewingUsers);
        returnMap.put("completed", completedUsers);
        
        return returnMap;
    }
    
    public String loadUserRatingsList (String ratingsString, String commentsString){
        Gson gson = new Gson();
        Type hashType = new TypeToken<HashMap <String, Object>>(){}.getType();
        HashMap <String, Object> ratingsMap = gson.fromJson(ratingsString, hashType);
        HashMap <String, Object> commentsMap = gson.fromJson(commentsString, hashType);
        
        ArrayList <HashMap <String, Object>> returnList = new ArrayList <HashMap <String, Object>> ();
        for (String userID : ratingsMap.keySet()){
            HashMap <String, Object> userMap = new HashMap <String, Object> ();
            userMap.put("user_id", userID);
            userMap.put("rating", ratingsMap.get(userID));
            userMap.put("comment", commentsMap.get(userID));
            returnList.add(userMap);
        }
        
        return gson.toJson(returnList);
    }
}
