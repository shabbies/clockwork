package model;

public class APIManager {
    String prefix = "";
    String EPAccept = "/api/v1/users/accept";
    String EPApply = "/api/v1/users/apply";
    String EPComplete = "/api/v1/users/complete";
    String EPCompleteProfile = "/api/v1/users/complete_profile";
    String EPNewPost = "/api/v1/posts/new";
    String EPDeletePost = "/api/v1/posts/delete";
    String EPEditPost = "/api/v1/posts/update";
    String EPNewUser = "/users.json";
    String EPListedJobs = "/api/v1/users/get_jobs";
    String EPAllPosts = "/api/v1/posts/all.json";
    String EPAppliedJobs = "/api/v1/users/get_applied_jobs";
    String EPCompletedApplicants = "/api/v1/posts/get_completed";
    String EPApplicants = "/api/v1/posts/get_all_applicants";
    String EPPost = "/api/v1/posts/get_post?post_id=";
    String EPHired = "/api/v1/posts/get_hired";
    String EPHire = "/api/v1/users/hire";
    String EPLogin = "/users/sign_in.json";
    String EPLogout = "/users/sign_out.json";
    String EPOfferAll = "/api/v1/users/offer_all";
    String EPOffer = "/api/v1/users/offer";
    String EPRate = "/api/v1/posts/rate";
    String EPSearch = "/api/v1/posts/search?query=";
    String EPUpdate = "/api/v1/users/update";
    String EPWithdraw = "/api/v1/users/withdraw";
    String EPWithdrawOffer = "/api/v1/users/withdraw_offer";
    String EPCalendarFormatDates = "/api/v1/users/get_calendar_formatted_dates.json";
    
    public APIManager(String mode){
        if (mode.equals("production")){
            prefix = "https://clockwork-api.herokuapp.com";
        } else if (mode.equals("development")){
            prefix = "http://localhost:3000";
        } else {
            prefix = "https://staging-clockwork-api.herokuapp.com";
        }
    }
    
    public APIManager(){
        prefix = "https://staging-clockwork-api.herokuapp.com";
    }

    public String getEPAccept() {
        return prefix + EPAccept;
    }
    
    public String getEPApply() {
        return prefix + EPApply;
    }
    
    public String getEPComplete() {
        return prefix + EPComplete;
    }
    
    public String getEPCompleteProfile() {
        return prefix + EPCompleteProfile;
    }
    
    public String getEPNewPost() {
        return prefix + EPNewPost;
    }
    
    public String getEPDeletePost() {
        return prefix + EPDeletePost;
    }
    
    public String getEPEditPost() {
        return prefix + EPEditPost;
    }
    
    public String getEPNewUser() {
        return prefix + EPNewUser;
    }
    
    public String getEPListedJobs() {
        return prefix + EPListedJobs;
    }
    
    public String getEPAllPosts() {
        return prefix + EPAllPosts;
    }

    public String getEPAppliedJobs() {
        return prefix + EPAppliedJobs;
    }

    public String getEPCompletedApplicants() {
        return prefix + EPCompletedApplicants;
    }

    public String getEPApplicants() {
        return prefix + EPApplicants;
    }

    public String getEPPost() {
        return prefix + EPPost;
    }

    public String getEPHired() {
        return prefix + EPHired;
    }

    public String getEPHire() {
        return prefix + EPHire;
    }

    public String getEPLogin() {
        return prefix + EPLogin;
    }

    public String getEPLogout() {
        return prefix + EPLogout;
    }

    public String getEPOfferAll() {
        return prefix + EPOfferAll;
    }

    public String getEPOffer() {
        return prefix + EPOffer;
    }

    public String getEPRate() {
        return prefix + EPRate;
    }

    public String getEPSearch() {
        return prefix + EPSearch;
    }

    public String getEPUpdate() {
        return prefix + EPUpdate;
    }

    public String getEPWithdraw() {
        return prefix + EPWithdraw;
    }

    public String getEPWithdrawOffer() {
        return prefix + EPWithdrawOffer;
    }

    public String getEPCalendarFormatDates() {
        return prefix + EPCalendarFormatDates;
    }
}