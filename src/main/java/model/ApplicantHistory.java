package model;

public class ApplicantHistory {
    private final User user;
    private final String status;
    private boolean isFavourite;
    
    public ApplicantHistory(User user, String status){
        this.user = user;
        this.status = status;
        isFavourite = false;
    }
    
    public ApplicantHistory(User user, String status, boolean isFavourite){
        this.user = user;
        this.status = status;
        this.isFavourite = isFavourite;
    }

    public User getUser() {
        return user;
    }

    public String getStatus() {
        return status;
    }
    
    public boolean isFavourite(){
        return isFavourite;
    }
    
    public void setFavourite(boolean isFavourite){
        this.isFavourite = isFavourite;
    }
}
