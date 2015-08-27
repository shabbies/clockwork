package controller;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
    
    public User createUserFromJSON(String jsonString){
        return userManager.createUserFromJSON(jsonString);
    }
    
    public ArrayList<User> createUsersFromJSONArray(String jsonString){
        Gson gson = new Gson();
        Type listType = new TypeToken<ArrayList<HashMap<String, Object>>>(){}.getType();
        ArrayList<HashMap<String, Object>> userRecordList = gson.fromJson(jsonString, listType);
        ArrayList<User> userList = new ArrayList <User>();
        for (HashMap<String, Object> userMap : userRecordList){
            String userString = gson.toJson(userMap);
            User user = createUserFromJSON(userString);
            userList.add(user);
        }
        return userList;
    }
}
