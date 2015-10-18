package controller;

import java.util.ArrayList;
import model.Notification;
import model.NotificationManager;

public class NotificationController {
    private NotificationManager notificationManager;
    
    public NotificationController(){
        notificationManager = new NotificationManager();
    }
    
    public void loadNotifications(String JSONString){
        notificationManager.loadNotificationsFromJSONArray(JSONString);
    }
    
    public ArrayList <Notification> getUnreadList(){
        return notificationManager.getUnreadList();
    }
    
    public ArrayList <Notification> getReadList(){
        return notificationManager.getReadList();
    }
    
    public void readNotifications(String notificationIDs){
        notificationManager.readNotifications(notificationIDs);
    }
}
