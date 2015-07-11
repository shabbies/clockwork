package model;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.util.HashMap;

public class UserManager {
    private User currentUser;
    
    public User login(int id, String username, String email, String companyName, String accountType){
        User user = new User(id, username, email, companyName, accountType);
        currentUser = user;
        return user;
    }
    
    public User getCurrentUser(){
        return currentUser;
    } 
    
    public User createUserFromJSON(String jsonString){
        Gson gson = new Gson();
        Type hashType = new TypeToken<HashMap<String, Object>>(){}.getType();
        HashMap userHash = gson.fromJson(jsonString, hashType);
        System.out.println("BYE");
        System.out.println(jsonString);
        int id = (Integer)userHash.get("id");
        String username = (String)userHash.get("username");
        String email = (String)userHash.get("email");
        String companyName = (String)userHash.get("company_name");
        String accountType = (String)userHash.get("account_type");
        User user = new User(id, username, email, companyName, accountType);
        return user;
    }
}
