package controller;

import java.util.ArrayList;
import model.Post;
import model.PostManager;
import model.User;

public class PostController {

    private PostManager postManager;
    
    public PostController(){
        postManager = new PostManager();
    }
    
    public ArrayList <Post> loadPostList(String JSONString){
        ArrayList <Post> postList = postManager.createPostArrayFromJSON(JSONString);
        postManager.setPostList(postList);
        return postList;
    }
    
    public ArrayList <Post> loadPublishedPostList(String JSONString){
        ArrayList <Post> postList = postManager.createPostArrayFromJSON(JSONString);
        postManager.setPublishedList(postList);
        return postList;
    }
    
    public Post getPost(int postID){
        return postManager.getPostFromHash(postID);
    }
    
    public int getJobApplicantCount(int postID){
        return postManager.getJobApplicantCount(postID);
    }
    
    public ArrayList <Post> loadAppliedJobsList(String JSONString){
        return null;
    }
}
