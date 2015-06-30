package model;

/*import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.util.ArrayList;

public class PostManager {

    private ArrayList postList;
    
    public Post createNewPostFromJSON(String jsonString){
        Gson gson = new Gson();
        Post post = gson.fromJson(jsonString, Post.class);
        return post;
    }
    
    public ArrayList createPostArrayFromJSON(String jsonString){
        Gson gson = new Gson();
        Type listType = new TypeToken <ArrayList<String>> ().getType();
        ArrayList <Post> returnList = new ArrayList <Post> ();
        String[] stringArr = (String[])((Object)jsonString);
        for (String postString : stringArr){
            Post post = createNewPostFromJSON(postString);
            returnList.add(post);
        }
        return returnList;
    }
}
*/