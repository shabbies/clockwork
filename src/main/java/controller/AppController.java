package controller;

import model.APIManager;

public class AppController {
    
    private PostController postController;
    private UserController userController;
    private MatchController matchController;
    private APIManager apiManager;
    
    public AppController(){
        postController = new PostController();
        userController = new UserController();
        matchController = new MatchController();
        apiManager = new APIManager("production");
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
    
    public APIManager getAPIManager(){
        return apiManager;
    }
}