package model;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.HashMap;

public class NotificationManager {
    private HashMap <String, ArrayList <Notification>> notificationsMap; //map of status and notifications
    
    public NotificationManager(){
        notificationsMap = new HashMap <String, ArrayList <Notification>> ();
    }
    
    public Notification createNotificationFromJSONString(String JSONString){
        Gson gson = new Gson();
        Type hashType = new TypeToken<HashMap<String, Object>>(){}.getType();
        HashMap responseHash = gson.fromJson(JSONString, hashType);
        int ID = ((Double)responseHash.get("id")).intValue();
        int postID = ((Double)responseHash.get("sender_id")).intValue();
        int senderID = ((Double)responseHash.get("sender_id")).intValue();
        int receiverID = ((Double)responseHash.get("sender_id")).intValue();
        String content = (String)responseHash.get("content");
        String status = (String)responseHash.get("status");
        String avatarPath = (String)responseHash.get("avatar_path");
        
        Notification notification = new Notification(ID, postID, senderID, receiverID, content, status, avatarPath);
        return notification;
    }
    
    public void loadNotificationsFromJSONArray(String JSONString){
        Gson gson = new Gson();
        Type listType = new TypeToken<ArrayList<HashMap<String, Object>>>(){}.getType();
        ArrayList <HashMap <String, Object>> responseList = gson.fromJson(JSONString, listType);
        ArrayList <Notification> readList = new ArrayList <Notification> ();
        ArrayList <Notification> unreadList = new ArrayList <Notification> ();
        for (HashMap<String, Object> map : responseList){
            String notificationString = gson.toJson(map);
            Notification notification = createNotificationFromJSONString(notificationString);
            if (notification.getStatus().equals("read")){
                readList.add(notification);
            } else {
                unreadList.add(notification);
            }
        }
        notificationsMap.put("read", readList);
        notificationsMap.put("unread", unreadList);
    }
    
    public ArrayList <Notification> getUnreadList(){
        return notificationsMap.get("unread");
    }
    
    public ArrayList <Notification> getReadList(){
        return notificationsMap.get("read");
    }
}
