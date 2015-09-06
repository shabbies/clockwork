package controller;

public class AppController {
    
    private PostController postController;
    private UserController userController;
    private MatchController matchController;
    
    public AppController(){
        postController = new PostController();
        userController = new UserController();
        matchController = new MatchController();
    }

    public PostController getPostController() {
        return postController;
    }

    public UserController getUserController() {
        return userController;
    }

    public MatchController getMatchController() {
        return matchController;
    }
}