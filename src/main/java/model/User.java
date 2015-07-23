package model;

public class User {
    private int id;
    private String username;
    private String email;
    private String companyName;
    private String accountType;
    private String authenticationToken;

    public User(int id, String username, String email, String companyName, String accountType, String authenticationToken) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.companyName = companyName;
        this.accountType = accountType;
        this.authenticationToken = authenticationToken;
    }

    public User(int id, String username, String email, String accountType, String authenticationToken) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.accountType = accountType;
        companyName = null;
        this.authenticationToken = authenticationToken;
    }

    public User(String email, String accountType) {
        this.email = email;
        this.accountType = accountType;
        username = null;
        companyName = null;
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

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
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
