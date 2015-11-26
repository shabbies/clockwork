package controller;

import model.APIManager;

public class AppController {
    
    private PostController postController;
    private UserController userController;
    private MatchController matchController;
    private NotificationController notificationController;
    private APIManager apiManager;
    private String environment;
    
    public AppController(){
        String env = "staging";
        postController = new PostController();
        userController = new UserController();
        matchController = new MatchController();
        notificationController = new NotificationController();
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
    
    public NotificationController getNotificationController(){
        return notificationController;
    }
    
    public APIManager getAPIManager(){
        return apiManager;
    }
    
    public String getEnvironment(){
        return environment;
    }
}
