package controller;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import model.Post;
import model.PostManager;

public class PostController {

    private PostManager postManager;
    
    public PostController(){
        postManager = new PostManager();
    }
    
    public ArrayList <Post> loadPostList(String JSONString) throws ParseException {
        ArrayList <Post> postList = postManager.createPostArrayFromJSON(JSONString);
        postManager.setPostList(postList);
        return postList;
    }
    
    public ArrayList <Post> loadPublishedPostList(String JSONString) throws ParseException {
        ArrayList <Post> postList = postManager.loadPublishedPost(JSONString);
        return postList;
    }
    
    public Post getPost(int postID){
        return postManager.getPostFromHash(postID);
    }
    
    public int getJobApplicantCount(int postID){
        return postManager.getJobApplicantCount(postID);
    }
    
    public HashMap <String, ArrayList <Post>> loadAppliedJobs(String JSONString) throws ParseException {
        postManager.loadAppliedJobs(JSONString);
        return postManager.getAppliedJobs();
    }
    
    public ArrayList <Post> getPendingAndOfferedJobs(){
        return postManager.getPendingAndOfferedJobs();
    }
    
    public HashMap <Integer, String> getApplicationPostStatus(){
        return postManager.getApplicationPostStatus();
    }
    
    public ArrayList <Post> getCompletedJobs(){
        return postManager.getCompletedJobs();
    }
    
    public ArrayList <Post> identifyConflictedPosts(ArrayList <Post> postList, int postID){
        Post post = getPost(postID);
        return postManager.getConflictedPosts(postList, post);
    }
}
