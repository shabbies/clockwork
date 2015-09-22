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

    private ArrayList <Post> postList;                          // all jobs for index page
    private HashMap <String, ArrayList <Post>> publishedMap;    // map of all post sorted by type (listed, applied, reviewing, completed)
    private HashMap <Integer, Post> postMap;                    // hashmap of :id => post
    private HashMap <Integer, String> applicationPostStatus;    // hashmap of postID => post_status
    private HashMap <String, ArrayList <Post>> appliedJobs;     // hashmap of jobs (status, list) (status: pending, offered, hired, completed)
    
    public PostManager(){
        postList = new ArrayList <Post> ();
        publishedMap = new HashMap <String, ArrayList <Post>> ();
        postMap = new HashMap <Integer, Post> ();
        applicationPostStatus = new HashMap <Integer, String> ();
        appliedJobs = new HashMap <String, ArrayList <Post>> ();
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
        String avatarPath = (String)postJSONMap.get("avatar_path");
        Post post = null;
        if (status.equals("completed")){
            int rating = 2;
            if (postJSONMap.get("rating") != null){
                rating = ((Double)postJSONMap.get("rating")).intValue();
            }
            String comment = ((String)postJSONMap.get("comment"));
            post = new Post(id, header, company, salary, description, location, postingDate, jobDate, endDate, status, 0, expiryDate, startTime, endTime, duration, rating, comment, avatarPath);
        } else {
            post = new Post(id, header, company, salary, description, location, postingDate, jobDate, endDate, status, 0, expiryDate, startTime, endTime, duration, avatarPath);
        }
        if (postJSONMap.get("applicant_count") != null){
            post.setApplicantCount(((Double)postJSONMap.get("applicant_count")).intValue());
        }
        postMap.put(post.getId(), post);
        return post;
    }
    
    public ArrayList <Post> createPostArrayFromJSON(String JSONString) throws ParseException {
        ArrayList <Post> newPostList = new ArrayList <Post> ();
        Gson gson = new Gson();
        Type listType = new TypeToken<ArrayList<HashMap<String, Object>>>(){}.getType();
        ArrayList <HashMap<String, Object>> postsHash = gson.fromJson(JSONString, listType);
        for (HashMap <String, Object> postHash : postsHash){
            int id = ((Double)postHash.get("id")).intValue();
            String postString = gson.toJson(postHash);
            Post post = createNewPostFromJSON(postString);
            newPostList.add(post);
        }
        return newPostList;
    }
    
    public ArrayList <Post> loadPublishedPost(String JSONString) throws ParseException {
        ArrayList <Post> fullPostList = createPostArrayFromJSON(JSONString);
        
        ArrayList <Post> listedList = new ArrayList <Post> ();
        ArrayList <Post> appliedList = new ArrayList <Post> ();
        ArrayList <Post> reviewingList = new ArrayList <Post> ();
        ArrayList <Post> completedList = new ArrayList <Post> ();
        ArrayList <Post> expiredList = new ArrayList <Post> ();
 
        for (Post post : fullPostList){
            String status = post.getStatus();
            switch (status){
                case "listed":
                    listedList.add(post);
                    break;
                case "applied":
                    appliedList.add(post);
                    break;
                case "reviewing":
                    reviewingList.add(post);
                    break;
                case "completed":
                    completedList.add(post);
                    break;
                case "expired":
                    expiredList.add(post);
                    break;
            }
        }
        
        publishedMap.put("listed", listedList);
        publishedMap.put("applied", appliedList);
        publishedMap.put("reviewing", reviewingList);
        publishedMap.put("completed", completedList);
        publishedMap.put("expired", expiredList);
        
        ArrayList <Post> returningList = new ArrayList <Post> ();
        returningList.addAll(reviewingList);
        returningList.addAll(appliedList);
        returningList.addAll(listedList);
        returningList.addAll(completedList);
        returningList.addAll(expiredList);
        
        return returningList;
    }
    
    public int getJobApplicantCount(int postID){
        Post post = postMap.get(postID);
        return post.getApplicantCount();
    }
    
    public HashMap <Integer, Post> loadAppliedJobsMap(String JSONString) throws ParseException {
        HashMap <Integer, Post> appliedJobsMap = new HashMap <Integer, Post> ();
        Gson gson = new Gson();
        Type listType = new TypeToken<ArrayList<HashMap<String, Object>>>(){}.getType();
        ArrayList <HashMap<String, Object>> postsHash = gson.fromJson(JSONString, listType);
        for (HashMap <String, Object> postHash : postsHash){
            int postID = ((Double)postHash.get("id")).intValue();
            Post post = postMap.get(postID);
            String applicationStatus = (String)postHash.get("status");
            if (post == null){
                String postString = gson.toJson(postHash);
                post = createNewPostFromJSON(postString);
                appliedJobsMap.put(post.getId(), post);
            }
            applicationPostStatus.put(post.getId(), applicationStatus);
            appliedJobsMap.put(post.getId(), post);
        }
        return appliedJobsMap;
    }
    
    public void loadAppliedJobs(String JSONString) throws ParseException {
        Gson gson = new Gson();
        Type listType = new TypeToken<ArrayList<HashMap<String, Object>>>(){}.getType();
        ArrayList <HashMap<String, Object>> postsHash = gson.fromJson(JSONString, listType);
        
        ArrayList <Post> pendingList = new ArrayList <Post> ();
        ArrayList <Post> offeredList = new ArrayList <Post> ();
        ArrayList <Post> hiredList = new ArrayList <Post> ();
        ArrayList <Post> completedList = new ArrayList <Post> ();
        for (HashMap <String, Object> postHash : postsHash){
            int postID = ((Double)postHash.get("id")).intValue();
            Post post = postMap.get(postID);
            if (post == null){
                String postString = gson.toJson(postHash);
                post = createNewPostFromJSON(postString);
                postMap.put(post.getId(), post);
            }
            String applicationStatus = (String)postHash.get("status");
            switch (applicationStatus){
                case "pending":
                    pendingList.add(post);
                    break;
                case "offered":
                    offeredList.add(post);
                    break;
                case "hired":
                    hiredList.add(post);
                    break;
                case "completed":
                    completedList.add(post);
                    break;
            }
        }
        
        appliedJobs.put("pending", pendingList);
        appliedJobs.put("offered", offeredList);
        appliedJobs.put("hired", hiredList);
        appliedJobs.put("completed", completedList);
    }
    
    public HashMap <String, ArrayList <Post>> getAppliedJobs(){
        HashMap <String, ArrayList <Post>> appliedJobsMap = new HashMap <String, ArrayList <Post>> ();
        appliedJobsMap.put("pending", appliedJobs.get("pending"));
        appliedJobsMap.put("offered", appliedJobs.get("offered"));
        appliedJobsMap.put("hired", appliedJobs.get("hired"));
        return appliedJobsMap;
    }
    
    public ArrayList <Post> getPendingAndOfferedJobs(){
        ArrayList <Post> list = new ArrayList <Post> ();
        list.addAll(appliedJobs.get("offered"));
        list.addAll(appliedJobs.get("pending"));
        return list;
    }
    
    public ArrayList <Post> getHiredJobs(){
        return appliedJobs.get("hired");
    }

    public HashMap<Integer, String> getApplicationPostStatus() {
        return applicationPostStatus;
    }
    
    public ArrayList <Post> getConflictedPosts (ArrayList <Post> postList, Post post){
        ArrayList <Post> returningList = new ArrayList <Post> ();
        Date startDate = post.getJobDate();
        Date endDate = post.getEndDate();
        for (Post retrievedPost : postList){
            if (retrievedPost == post){
                continue;
            }
            Date retrievedStartDate = retrievedPost.getJobDate();
            Date retrievedEndDate = retrievedPost.getEndDate();
            if (startDate.before(retrievedEndDate) && endDate.after(retrievedStartDate)){
                returningList.add(retrievedPost);
            }
        }
        return returningList;
    }
    
    public ArrayList<Post> getCompletedJobs(){
        return appliedJobs.get("completed");
    }
    
    public boolean checkIfJobApplied(Post post){
        ArrayList <Post> pendingList = appliedJobs.get("pending");
        ArrayList <Post> offeredList = appliedJobs.get("offered");
        ArrayList <Post> hiredList = appliedJobs.get("hired");

        return pendingList.contains(post) || offeredList.contains(post) || hiredList.contains(post);
    }
    
    public void removeAppliedPost(int postID){
        Post post = getPostFromHash(postID);
        for (String key : appliedJobs.keySet()){
            ArrayList <Post> retrievedList = appliedJobs.get(key);
            retrievedList.remove(post);
        }
    }
}