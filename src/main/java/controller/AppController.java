package controller;

public class AppController {
    
    private PostController postController;
    private UserController userController;
    
    public AppController(){
        postController = new PostController();
        userController = new UserController();
    }

    public PostController getPostController() {
        return postController;
    }

    public UserController getUserController() {
        return userController;
    }   
}