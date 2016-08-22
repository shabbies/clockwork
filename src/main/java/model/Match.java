package model;

import java.util.HashMap;

public class Match {
    private int userId;
    private int postId;
    private int rating;
    private String comment;
    private String status;
    private HashMap <String, HashMap <String, String>> timings;

    public Match(int userId, int postId, int rating, String comment, String status, HashMap timings) {
        this.userId = userId;
        this.postId = postId;
        this.rating = rating;
        this.comment = comment;
        this.status = status;
        this.timings = timings;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public HashMap <String, HashMap <String, String>> getTimings(){
        return timings;
    }
    
    public String getStartTime(String date) {
        return timings.get(date).get("check_in");
    }

    public void setStartTime(String date, String startTime) {
        timings.get(date).put("check_in", startTime);
    }

    public String getEndTime(String date) {
        return timings.get(date).get("check_out");
    }

    public void setEndTime(String date, String endTime) {
        timings.get(date).put("check_out", endTime);
    }
}
