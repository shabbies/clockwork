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

    private ArrayList postList;
    
    public PostManager(){
        postList = new ArrayList <Post> ();
    }
    
    public Post createNewPostFromJSON(String jsonString){
        Gson gson = new Gson();
        Post post = gson.fromJson(jsonString, Post.class);
        return post;
    }
    
    public ArrayList createPostArrayFromJSON(String jsonString){
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
            postList.add(post);
        }
        return postList;
    }
}
