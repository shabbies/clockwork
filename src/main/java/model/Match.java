package model;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

public class Match {
    private int userId;
    private int postId;
    private int rating;
    private String comment;
    private String status;
    private Date startTime;
    private Date endTime;

    public Match(int userId, int postId, int rating, String comment, String status, Date startTime, Date endTime) {
        this.userId = userId;
        this.postId = postId;
        this.rating = rating;
        this.comment = comment;
        this.status = status;
        this.startTime = startTime;
        this.endTime = endTime;
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

    public Date getStartTime() {
        return startTime;
    }
    
    public String getFormattedStartTime() {
        DateFormat df = new SimpleDateFormat("h:mm a", Locale.ENGLISH);
        return df.format(startTime);
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }
    
    public String getFormattedEndTime() {
        DateFormat df = new SimpleDateFormat("h:mm a", Locale.ENGLISH);
        return df.format(endTime);
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }
    
    
}
