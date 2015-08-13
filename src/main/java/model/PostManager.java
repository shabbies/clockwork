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

    private ArrayList <Post> postList;          // all jobs for index page
    private ArrayList <Post> publishedList;     // list of listed posts
    private HashMap <Integer, Post> postMap;    // hashmap of :id => post
    
    public PostManager(){
        postList = new ArrayList <Post> ();
        publishedList = new ArrayList <Post> ();
        postMap = new HashMap <Integer, Post> ();
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
    
    public Post createNewPostFromJSON(String jsonString){
        Gson gson = new Gson();
        Post post = gson.fromJson(jsonString, Post.class);
        return post;
    }
    
    public ArrayList <Post> createPostArrayFromJSON(String jsonString){
        ArrayList <Post> newPostList = new ArrayList <Post> ();
        Gson gson = new Gson();
        Type listType = new TypeToken<ArrayList<HashMap<String, Object>>>(){}.getType();
        ArrayList <HashMap<String, Object>> postsHash = gson.fromJson(jsonString, listType);
        for (HashMap <String, Object> postHash : postsHash){
            DateFormat df = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
            Date jobDate = null;
            Date postingDate = null;
            try {
                jobDate = df.parse((String)postHash.get("job_date"));
                postingDate = df.parse((String)postHash.get("posting_date"));
            } catch (ParseException ex){
                ex.printStackTrace();
            }
            String postString = gson.toJson(postHash);
            Post post = createNewPostFromJSON(postString);
            post.setJobDate(jobDate);
            post.setPostingDate(postingDate);
            if (postHash.get("applicant_count") != null){
                post.setApplicantCount(((Double)postHash.get("applicant_count")).intValue());
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
}
