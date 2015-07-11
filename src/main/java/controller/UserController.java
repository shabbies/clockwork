package controller;

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
}
