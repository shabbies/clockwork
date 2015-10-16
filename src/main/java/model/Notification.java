package model;

public class Notification {
    private int id;
    private int postId;
    private int senderId;
    private int receiverId;
    private String content;
    private String status;
    private String avatarPath;

    public Notification(int id, int postId, int senderId, int receiverId, String content, String status, String avatarPath) {
        this.id = id;
        this.postId = postId;
        this.senderId = senderId;
        this.receiverId = receiverId;
        this.content = content;
        this.status = status;
        this.avatarPath = avatarPath;
    }

    public int getId() {
        return id;
    }

    public int getPostId() {
        return postId;
    }

    public int getSenderID() {
        return senderId;
    }

    public int getReceiverID() {
        return receiverId;
    }

    public String getContent() {
        return content;
    }

    public String getStatus() {
        return status;
    }

    public String getAvatarPath() {
        return avatarPath;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    @Override
    public boolean equals(Object other){
        if (other == null) return false;
        if (other == this) return true;
        if (!(other instanceof Notification))return false;
        Notification other2 = (Notification)other;
        if (other2.id == id){
            return true;
        } else {
            return false;
        }
    }

    @Override
    public int hashCode() {
        int hash = 3;
        hash = 59 * hash + this.id;
        return hash;
    }
}
