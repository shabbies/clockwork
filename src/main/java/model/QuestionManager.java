package model;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.HashMap;

public class QuestionManager {
    private ArrayList <Question> questionList;
    
    public QuestionManager(){
        questionList = new ArrayList <Question> ();
    }
    
    public ArrayList <Question> loadQuestionsList(String JSONString){
        questionList.clear();
        
        Gson gson = new Gson();
        Type arrayType = new TypeToken<ArrayList <HashMap>>(){}.getType();
        ArrayList <HashMap> overallMap = gson.fromJson(JSONString, arrayType);
        
        for (HashMap <String, Object> questionMap : overallMap){
            int id = ((Double)questionMap.get("id")).intValue();
            String ask = (String)questionMap.get("question");
            String choiceA = (String)questionMap.get("choice_a");
            String choiceB = (String)questionMap.get("choice_b");
            String choiceC = (String)questionMap.get("choice_c");
            String choiceD = (String)questionMap.get("choice_d");
            char answer = ((String)questionMap.get("answer")).charAt(0);
            Question question = new Question(id, ask, choiceA, choiceB, choiceC, choiceD, answer);
            questionList.add(question);
        }
        
        return questionList;
    }
}
