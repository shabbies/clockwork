package model;

public class Match {
    private int userId;
    private int postId;
    private int rating;
    private String comment;
    private String status;

    public Match(int userId, int postId, int rating, String comment, String status) {
        this.userId = userId;
        this.postId = postId;
        this.rating = rating;
        this.comment = comment;
        this.status = status;
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
    
    
}
