package model;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

public class MessageManager {
    
    public Message createMessageFromJSON(String JSONString) throws ParseException {
        Gson gson = new Gson();
        Type hashType = new TypeToken<HashMap<String, Object>>(){}.getType();
        HashMap userHash = gson.fromJson(JSONString, hashType);
        Double idDouble = (Double)userHash.get("id");
        int id = idDouble.intValue();
        String sender = (String)userHash.get("sender_name");
        Double senderIDDouble = (Double)userHash.get("sender_id");
        int senderID = senderIDDouble.intValue();
        String avatar = null;
        if (userHash.get("sender_avatar") != null){
            avatar = (String)userHash.get("sender_avatar");
        }
        Double chatroomIDDouble = (Double)userHash.get("sender_id");
        int chatroomID = chatroomIDDouble.intValue();
        String content = (String)userHash.get("content");
        
        String dateString = (String)userHash.get("created_at");
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSXXX");
        Date createdDate = df.parse(dateString);
        df = new SimpleDateFormat("d MMM");
        String dateOnly = df.format(createdDate);
        df = new SimpleDateFormat("h:mm a");
        String timeOnly = df.format(createdDate);
        Message message = new Message(id, sender, senderID, avatar, chatroomID, content, createdDate, dateOnly, timeOnly);
        return message;
    }
    
    public ArrayList <Message> createMessageArrayFromJSON(String JSONString) throws ParseException {
        ArrayList <Message> messageList = new ArrayList <Message> ();
        Gson gson = new Gson();
        Type listType = new TypeToken<ArrayList<HashMap<String, Object>>>(){}.getType();
        ArrayList <HashMap<String, Object>> messagesHash = gson.fromJson(JSONString, listType);
        for (HashMap <String, Object> messageHash : messagesHash){
            String postString = gson.toJson(messageHash);
            Message message = createMessageFromJSON(postString);
            messageList.add(message);
        }
        return messageList;
    }
}
