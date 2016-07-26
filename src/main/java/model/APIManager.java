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
    String EPUnreadNotifications = "/api/v1/users/get_unread_notifications";
    String EPAllNotifications = "/api/v1/users/get_all_notifications";
    String EPReadNotifications = "/api/v1/users/read_notifications";
    String EPScore = "/api/v1/gamify/get_score";
    String EPContestRegister = "/api/v1/competition/competition_register";
    String EPBadges = "/api/v1/gamify/get_badges";
    String EPQuiz = "/api/v1/gamify/get_quiz";
    String EPRecordQuiz = "/api/v1/gamify/record_quiz";
    String EPSendConfirmationEmail = "/api/v1/users/send_confirmation_email";
    String EPAllApplicants = "/api/v1/users/get_applicants";
    String EPFavouriteUser = "/api/v1/users/favourite";
    String EPUnfavouriteUser = "/api/v1/users/unfavourite";
    String EPSendNotification = "/api/v1/notifications/send_notification";
    String EPCheckIn = "/api/v1/posts/check_in";
    String EPCheckOut = "/api/v1/posts/check_out";
    String EPUpdateWage = "/api/v1/posts/update_salary";
    String EPGetChatMessages = "/api/v1/chat/get_messages";
    String EPNewChatMessage = "/api/v1/chat/new_message";
    String EPGetJSChatrooms = "/api/v1/chat/get_js_chatrooms";
    
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

    public String getEPUnreadNotifications() {
        return prefix + EPUnreadNotifications;
    }
    
    public String getEPAllNotifications() {
        return prefix + EPAllNotifications;
    }

    public String getEPReadNotifications() {
        return prefix + EPReadNotifications;
    }
    
    public String getEPScore() {
        return prefix + EPScore;
    }
    
    public String getEPContestRegister(){
        return prefix + EPContestRegister;
    }
    
    public String getEPBadges(){
        return prefix + EPBadges;
    }
    
    public String getEPQuiz(){
        return prefix + EPQuiz;
    }
    
    public String getEPRecordQuiz(){
        return prefix + EPRecordQuiz;
    }
    
    public String getEPSendConfirmationEmail(){
        return prefix + EPSendConfirmationEmail;
    }
    
    public String getEPAllApplicants(){
        return prefix + EPAllApplicants;
    }
    
    public String getEPFavouriteUser(){
        return prefix + EPFavouriteUser;
    }
    
    public String getEPUnfavouriteUser(){
        return prefix + EPUnfavouriteUser;
    }
    
    public String getEPSendNotification(){
        return prefix + EPSendNotification;
    }
    
    public String getEPCheckIn(){
        return prefix + EPCheckIn;
    }
    
    public String getEPCheckOut(){
        return prefix + EPCheckOut;
    }
    
    public String getEPUpdateWage(){
        return prefix + EPUpdateWage;
    }
    
    public String getEPGetChatMessages(){
        return prefix + EPGetChatMessages;
    }
    
    public String getEPNewChatMessage(){
        return prefix + EPNewChatMessage;
    }
    
    public String getEPGetJSChatrooms(){
        return prefix + EPGetJSChatrooms;
    }
    
    public String getPrefix(){
        return prefix;
    }
}