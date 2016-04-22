package model;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

public class UserManager {
    private User currentUser;
    private ArrayList <ApplicantHistory> applicantHistoryList;
    
    public UserManager(){
        currentUser = null;
        applicantHistoryList = new ArrayList <ApplicantHistory> ();
    }
    
    public User login(User user){
        currentUser = user;
        return currentUser;
    }
    
    public User getCurrentUser(){
        return currentUser;
    } 
    
    public User createUserFromJSON(String JSONString){
        Gson gson = new Gson();
        Type hashType = new TypeToken<HashMap<String, Object>>(){}.getType();
        HashMap userHash = gson.fromJson(JSONString, hashType);
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
        String referralID = (String)userHash.get("referral_id");
        int referredUsers = ((Double)userHash.get("referred_users")).intValue(); 
        boolean hasConfirmed = (Boolean)userHash.get("verified");
        User user = null;
        if (userHash.get("quiz_score") != null){
            int scoreCleanUp = ((Double)userHash.get("clean_up")).intValue();
            int scoreOrderTaking = ((Double)userHash.get("order_taking")).intValue();
            int scoreBarista = ((Double)userHash.get("barista")).intValue();
            int scoreSelling = ((Double)userHash.get("selling")).intValue();
            int scoreKitchen = ((Double)userHash.get("kitchen")).intValue();
            int scoreBartender = ((Double)userHash.get("bartender")).intValue();
            int scoreService = ((Double)userHash.get("service")).intValue();
            int scoreCashier = ((Double)userHash.get("cashier")).intValue();
            HashMap <String, Integer> scoreMap = new HashMap <String, Integer> ();
            scoreMap.put("cleanUp", scoreCleanUp);
            scoreMap.put("orderTaking", scoreOrderTaking);
            scoreMap.put("barista", scoreBarista);
            scoreMap.put("selling", scoreSelling);
            scoreMap.put("kitchen", scoreKitchen);
            scoreMap.put("bartender", scoreBartender);
            scoreMap.put("service", scoreService);
            scoreMap.put("cashier", scoreCashier);
            user = new User(id, username, email, accountType, authenticationToken, address, contactNumber, dateOfBirth, avatar, nationality, gender, badRating, neutralRating, goodRating, referralID, referredUsers, hasConfirmed, scoreMap);
        } else {
            user = new User(id, username, email, accountType, authenticationToken, address, contactNumber, dateOfBirth, avatar, nationality, gender, badRating, neutralRating, goodRating, referralID, referredUsers, hasConfirmed);
        }
        return user;
    }
    
    public void updateUser(String JSONString){
        User user = createUserFromJSON(JSONString);
        currentUser.setAddress(user.getAddress());
        currentUser.setUsername(user.getUsername());
        currentUser.setAvatar(user.getAvatar());
        currentUser.setContactNumber(user.getContactNumber());
        currentUser.setGender(user.getGender());
        currentUser.setNationality(user.getNationality());
        currentUser.setDateOfBirth(user.getDateOfBirth());
    }
    
    public ArrayList <ApplicantHistory> loadApplicantHistoryList(String JSONString){
        applicantHistoryList.clear();
        Gson gson = new Gson();
        Type listType = new TypeToken<ArrayList<HashMap<String, Object>>>(){}.getType();
        ArrayList <HashMap<String, Object>> historyList = gson.fromJson(JSONString, listType);
        for (HashMap <String, Object> historyHash : historyList){
            String status = (String)historyHash.get("status");
            boolean isFavourite = (Boolean)historyHash.get("is_favourite");
            ArrayList <Integer> ongoingJobs = new ArrayList <Integer> ();
            ArrayList <Double> ongoingJobsFloat = (ArrayList <Double>)historyHash.get("ongoing_jobs");
            for (Double ongoing : ongoingJobsFloat){
                int each = ongoing.intValue();
                ongoingJobs.add(each);
            }
            String historyString = gson.toJson(historyHash);
            User user = createUserFromJSON(historyString);
            ApplicantHistory applicantHistory = new ApplicantHistory(user, status, isFavourite, ongoingJobs);
            applicantHistoryList.add(applicantHistory);
        }
        return applicantHistoryList;
    }
}
