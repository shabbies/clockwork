package model;

import java.util.ArrayList;

public class ApplicantHistory {
    private final User user;
    private final String status;
    private boolean isFavourite;
    private ArrayList <Integer> ongoingJobs;
    
    public ApplicantHistory(User user, String status, ArrayList <Integer> ongoingJobs){
        this.user = user;
        this.status = status;
        isFavourite = false;
        this.ongoingJobs = ongoingJobs;
    }
    
    public ApplicantHistory(User user, String status, boolean isFavourite, ArrayList <Integer> ongoingJobs){
        this.user = user;
        this.status = status;
        this.isFavourite = isFavourite;
        this.ongoingJobs = ongoingJobs;
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

    public ArrayList <Integer> getOngoingJobs() {
        return ongoingJobs;
    }
}
