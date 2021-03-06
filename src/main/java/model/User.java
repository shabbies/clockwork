package model;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

public class User {
    private int id;
    private String username; //refers to company name if is employer
    private String email;
    private String accountType;
    private String authenticationToken;
    private String address;
    private int contactNumber;
    private Date dateOfBirth;
    private String avatar;
    private String nationality;
    private char gender;
    private int badRating;
    private int neutralRating;
    private int goodRating;
    private String referralID;
    private int referredUsers;
    private boolean hasConfirmed;
    private HashMap <String, Integer> scoreMap;
    private String qualification;
    private String description;

    public User(int id, String username, String email, String accountType, String authenticationToken, String address, int contactNumber, Date dateOfBirth, String avatar, String nationality, char gender, int badRating, int neutralRating, int goodRating, String referralID, int referredUsers, boolean hasConfirmed, String qualification, String description) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.accountType = accountType;
        this.authenticationToken = authenticationToken;
        this.address = address;
        this.contactNumber = contactNumber;
        this.dateOfBirth = dateOfBirth;
        this.avatar = avatar;
        this.nationality = nationality;
        this.gender = gender;
        this.badRating = badRating;
        this.neutralRating = neutralRating;
        this.goodRating = goodRating;
        this.referralID = referralID;
        this.referredUsers = referredUsers;
        this.hasConfirmed = hasConfirmed;
        scoreMap = null;
        this.qualification = qualification;
        this.description = description;
    }

    public User(int id, String username, String email, String accountType, String authenticationToken, String address, int contactNumber, Date dateOfBirth, String avatar, String nationality, char gender, int badRating, int neutralRating, int goodRating, String referralID, int referredUsers, boolean hasConfirmed, HashMap<String, Integer> scoreMap, String qualification, String description) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.accountType = accountType;
        this.authenticationToken = authenticationToken;
        this.address = address;
        this.contactNumber = contactNumber;
        this.dateOfBirth = dateOfBirth;
        this.avatar = avatar;
        this.nationality = nationality;
        this.gender = gender;
        this.badRating = badRating;
        this.neutralRating = neutralRating;
        this.goodRating = goodRating;
        this.referralID = referralID;
        this.referredUsers = referredUsers;
        this.hasConfirmed = hasConfirmed;
        this.scoreMap = scoreMap;
        this.qualification = qualification;
        this.description = description;
    }

    
    
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAccountType() {
        return accountType;
    }

    public void setAccountType(String accountType) {
        this.accountType = accountType;
    }   
    
    public String getAuthenticationToken(){
        return authenticationToken;
    }
    
    public void setAuthenticationToken(String authenticationToken){
        this.authenticationToken = authenticationToken;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(int contactNumber) {
        this.contactNumber = contactNumber;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }
    
    public String getDateOfBirthString(){
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        return df.format(dateOfBirth);
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getNationality() {
        return nationality;
    }

    public void setNationality(String nationality) {
        this.nationality = nationality;
    }

    public char getGender() {
        return gender;
    }

    public void setGender(char gender) {
        this.gender = gender;
    }

    public int getBadRating() {
        return badRating;
    }

    public void setBadRating(int badRating) {
        this.badRating = badRating;
    }

    public int getNeutralRating() {
        return neutralRating;
    }

    public void setNeutralRating(int neutralRating) {
        this.neutralRating = neutralRating;
    }

    public int getGoodRating() {
        return goodRating;
    }

    public void setGoodRating(int goodRating) {
        this.goodRating = goodRating;
    }

    public String getReferralID() {
        return referralID;
    }

    public int getReferredUsers() {
        return referredUsers;
    }
    
    public boolean getHasConfirmed(){
        return hasConfirmed;
    }

    public HashMap<String, Integer> getScoreMap() {
        return scoreMap;
    }

    public String getQualification() {
        return qualification;
    }

    public void setQualification(String qualification) {
        this.qualification = qualification;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
    
}
