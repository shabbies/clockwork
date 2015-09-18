package model;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

public class UserManager {
    private User currentUser;
    
    public UserManager(){
        currentUser = null;
    }
    
    public User login(User user){
        currentUser = user;
        return currentUser;
    }
    
    public User getCurrentUser(){
        return currentUser;
    } 
    
    public User createUserFromJSON(String jsonString){
        Gson gson = new Gson();
        Type hashType = new TypeToken<HashMap<String, Object>>(){}.getType();
        HashMap userHash = gson.fromJson(jsonString, hashType);
        Double idDouble = (Double)userHash.get("id");
        int id = idDouble.intValue();
        String username = (String)userHash.get("username");
        String email = (String)userHash.get("email");
        String accountType = (String)userHash.get("account_type");
        String authenticationToken = (String)userHash.get("authentication_token");
        String address = null;
        if (userHash.get("address") != null){
            address = (String)userHash.get("address");
        }
        int contactNumber = 0;
        if (userHash.get("contact_number") != null){
            contactNumber = ((Double)userHash.get("contact_number")).intValue();
        }
        Date dateOfBirth = null;
        if (userHash.get("date_of_birth") != null){
            String dateOfBirthString = (String)userHash.get("date_of_birth");
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            try {
                dateOfBirth = df.parse(dateOfBirthString);
            } catch (ParseException ex){
                ex.printStackTrace();
            }
        }
        String avatar = (String)userHash.get("avatar_path");
        String nationality = (String)userHash.get("nationality");
        char gender = '\u0000';
        if (userHash.get("gender") != null){
            gender = ((String)userHash.get("gender")).charAt(0);
        }
        int badRating = ((Double)userHash.get("bad_rating")).intValue();        
        int neutralRating = ((Double)userHash.get("neutral_rating")).intValue();
        int goodRating = ((Double)userHash.get("good_rating")).intValue();

        User user = new User(id, username, email, accountType, authenticationToken, address, contactNumber, dateOfBirth, avatar, nationality, gender, badRating, neutralRating, goodRating);
        return user;
    }
    
    public void updateUser(String JSONString){
        User user = createUserFromJSON(JSONString);
        if (currentUser == null){
            currentUser = user;
        } else {
            currentUser.setAddress(user.getAddress());
            currentUser.setUsername(user.getUsername());
            currentUser.setAvatar(user.getAvatar());
            currentUser.setContactNumber(user.getContactNumber());
            currentUser.setGender(user.getGender());
            currentUser.setNationality(user.getNationality());
            currentUser.setDateOfBirth(user.getDateOfBirth());
        }
    }
}
