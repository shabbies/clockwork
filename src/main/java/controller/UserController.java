package controller;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.HashMap;
import model.Post;
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
        Type listType = new TypeToken<ArrayList<User>>(){}.getType();
        ArrayList<User> userList = gson.fromJson(jsonString, listType);
        return userList;
    }
}
