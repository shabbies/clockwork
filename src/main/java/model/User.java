package model;

public class User {
    private int id;
    private String username; //refers to company name if is employer
    private String email;
    private String accountType;
    private String authenticationToken;

    public User(int id, String username, String email, String accountType, String authenticationToken) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.accountType = accountType;
        this.authenticationToken = authenticationToken;
    }

    public User(String email, String accountType) {
        this.email = email;
        this.accountType = accountType;
        username = null;
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
}
