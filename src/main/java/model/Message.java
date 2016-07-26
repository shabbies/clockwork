package model;

import java.util.Date;

public class Message {
    private int id;
    private String sender;
    private int senderID;
    private String avatar;
    private int chatroomID;
    private String content;
    private Date createdDate;
    private String dateOnly;
    private String timeOnly;

    public Message(int id, String sender, int senderID, String avatar, int chatroomID, String content, Date createdDate, String dateOnly, String timeOnly) {
        this.id = id;
        this.sender = sender;
        this.senderID = senderID;
        this.avatar = avatar;
        this.chatroomID = chatroomID;
        this.content = content;
        this.createdDate = createdDate;
        this.dateOnly = dateOnly;
        this.timeOnly = timeOnly;
    }

    public int getId() {
        return id;
    }

    public String getSender() {
        return sender;
    }

    public int getSenderID() {
        return senderID;
    }

    public String getAvatar() {
        return avatar;
    }

    public int getChatroomID() {
        return chatroomID;
    }

    public String getContent() {
        return content;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public String getDateOnly() {
        return dateOnly;
    }

    public String getTimeOnly() {
        return timeOnly;
    }
}