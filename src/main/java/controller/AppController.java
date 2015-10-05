package controller;

import model.APIManager;

public class AppController {
    
    private PostController postController;
    private UserController userController;
    private MatchController matchController;
    private APIManager apiManager;
    private String environment;
    
    public AppController(){
        String env = "staging";
        postController = new PostController();
        userController = new UserController();
        matchController = new MatchController();
        apiManager = new APIManager(env);
        environment = env;
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
    
    public String getEnvironment(){
        return environment;
    }
}
