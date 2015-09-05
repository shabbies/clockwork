package model;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;

public class PostManager {

    private ArrayList <Post> postList;              // all jobs for index page
    private ArrayList <Post> publishedList;         // list of listed posts
    private HashMap <Integer, Post> postMap;        // hashmap of :id => post
    private HashMap <Integer, String> applicationPostStatus;   //hashmap of postID => post_status
    
    public PostManager(){
        postList = new ArrayList <Post> ();
        publishedList = new ArrayList <Post> ();
        postMap = new HashMap <Integer, Post> ();
        applicationPostStatus = new HashMap <Integer, String> ();
    }
    
    public Post getPostFromHash(int postID){
        return postMap.get(postID);
    }
    
    public void setPostList(ArrayList <Post> postList){
        this.postList = postList;
    }
    
    public ArrayList <Post> getPostList (){
        return postList;
    }
    
    public void setPublishedList (ArrayList <Post> publishedList){
        this.publishedList = publishedList;
    }
    
    public ArrayList <Post> getPublishedList (){
        return publishedList;
    }
    
    public Post createNewPostFromJSON(String jsonString) throws ParseException {
        Gson gson = new Gson();
        Type listType = new TypeToken<HashMap<String, Object>>(){}.getType();
        HashMap <String, Object> postJSONMap = gson.fromJson(jsonString, listType);
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
        int id = ((Double)postJSONMap.get("id")).intValue();
        String header = (String)postJSONMap.get("header");
        String company = (String)postJSONMap.get("company");
        double salary = (Double)postJSONMap.get("salary");
        String description = (String)postJSONMap.get("description");
        String location = (String)postJSONMap.get("location");
        Date jobDate = df.parse((String)postJSONMap.get("job_date"));        
        Date endDate = df.parse((String)postJSONMap.get("end_date"));
        Date postingDate = df.parse((String)postJSONMap.get("posting_date"));
        Date expiryDate = df.parse((String)postJSONMap.get("expiry_date"));
        String status = (String)postJSONMap.get("status");
        String startTime = (String)postJSONMap.get("start_time");
        String endTime = (String)postJSONMap.get("end_time");
        int duration = ((Double)postJSONMap.get("duration")).intValue();
        Post post = null;
        if (status.equals("completed")){
            int rating = 2;
            if (postJSONMap.get("rating") != null){
                rating = ((Double)postJSONMap.get("rating")).intValue();
            }
            String comment = ((String)postJSONMap.get("comment"));
            post = new Post(id, header, company, salary, description, location, postingDate, jobDate, endDate, status, 0, expiryDate, startTime, endTime, duration, rating, comment);
        } else {
            post = new Post(id, header, company, salary, description, location, postingDate, jobDate, endDate, status, 0, expiryDate, startTime, endTime, duration);
        }
        if (postJSONMap.get("applicant_count") != null){
            post.setApplicantCount(((Double)postJSONMap.get("applicant_count")).intValue());
        }
        return post;
    }
    
    public ArrayList <Post> createPostArrayFromJSON(String JSONString){
        ArrayList <Post> newPostList = new ArrayList <Post> ();
        Gson gson = new Gson();
        Type listType = new TypeToken<ArrayList<HashMap<String, Object>>>(){}.getType();
        ArrayList <HashMap<String, Object>> postsHash = gson.fromJson(JSONString, listType);
        for (HashMap <String, Object> postHash : postsHash){
            String postString = gson.toJson(postHash);
            Post post = null;
            try {
                post = createNewPostFromJSON(postString);
            } catch (ParseException ex){
                ex.printStackTrace();
            }
            newPostList.add(post);
            postMap.put(post.getId(), post);
        }
        return newPostList;
    }
    
    public int getJobApplicantCount(int postID){
        Post post = postMap.get(postID);
        return post.getApplicantCount();
    }
    
    public HashMap <Integer, Post> loadAppliedJobsMap(String JSONString){
        HashMap <Integer, Post> appliedJobsMap = new HashMap <Integer, Post> ();
        Gson gson = new Gson();
        Type listType = new TypeToken<ArrayList<HashMap<String, Object>>>(){}.getType();
        ArrayList <HashMap<String, Object>> postsHash = gson.fromJson(JSONString, listType);
        for (HashMap <String, Object> postHash : postsHash){
            int postID = ((Double)postHash.get("id")).intValue();
            Post post = postMap.get(postID);
            String applicationStatus = (String)postHash.get("status");
            if (post == null){
                try {
                    String postString = gson.toJson(postHash);
                    post = createNewPostFromJSON(postString);
                } catch (ParseException ex){
                    ex.printStackTrace();
                }
                appliedJobsMap.put(post.getId(), post);
                postMap.put(post.getId(), post);
            }
            applicationPostStatus.put(post.getId(), applicationStatus);
            appliedJobsMap.put(post.getId(), post);
        }
        return appliedJobsMap;
    }

    public HashMap<Integer, String> getApplicationPostStatus() {
        return applicationPostStatus;
    }
}