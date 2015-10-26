<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>

<%@ page import="model.Question"%>

<%
if (currentUser == null){
session.setAttribute("error", "Please login or register first before answering questions!");
response.sendRedirect("/login.jsp");
return;
} else if (currentUser.getAccountType().equals("employer")){
session.setAttribute("error", "Only a job seeker account can do quizzes!");
response.sendRedirect("/index.jsp");
return;}

int currentQuestion = 0;
int score = 0;
try {
    currentQuestion = Integer.parseInt((String)session.getAttribute("currentQuestion"));
    score = Integer.parseInt((String)session.getAttribute("score"));
} catch (Exception e){
    e.printStackTrace();
    response.sendRedirect("/gamify_categories.jsp");
}
String correctQuestions = (session.getAttribute("correctQuestions") != null ? (String)session.getAttribute("correctQuestions") : "");

if (currentQuestion == 6){
    response.sendRedirect("/quiz_score.jsp");
    return;
}

Question question = (Question)session.getAttribute("question" + currentQuestion);
int id = question.getId();
%>

<header class="main">
<div class="header-content">
<div class="header-content-inner">
<div class="row">
<div class="col-md-12">  
<div class="panel panel-default">
    <div class="panel-body">
        <div class="col-xs-12 text-center"> 
            <img src="img/question58.png" class="quiz-icon col-xs-1"/>
            <h3 id="quiz-question" class="col-xs-11 text-left quiz-question">
                <%=question.getQuestion()%>
            </h3>
        </div>
    </div>
</div>
            
<div id="choice_a" class="panel panel-default col-md-6 quiz-unselected-answer quiz-choice" data-choice="a">
    <div class="panel-body">
        <div class="col-xs-1 quiz-question quiz-answer">A</div>
        <div class="col-xs-11 quiz-question quiz-answer"><small><%=question.getChoiceA()%></small></div>
        <img src="img/green-tick.png" class="green-tick hidden"/>
        <img src="img/red-cross.png" class="red-cross hidden"/>
    </div>
</div>
    
<div id="choice_b" class="panel panel-default col-md-6 quiz-unselected-answer quiz-choice" data-choice="b">
    <div class="panel-body">
        <div class="col-xs-1 quiz-question quiz-answer">B</div>
        <div class="col-xs-11 quiz-question quiz-answer"><small><%=question.getChoiceB()%></small></div>
        <img src="img/green-tick.png" class="green-tick hidden"/>
        <img src="img/red-cross.png" class="red-cross hidden" />
    </div>
</div>
    

<div id="choice_c" class="panel panel-default col-md-6 quiz-unselected-answer quiz-choice" data-choice="c">
    <div class="panel-body">
        <div class="col-xs-1 quiz-question quiz-answer">C</div>
        <div class="col-xs-11 quiz-question quiz-answer"><small><%=question.getChoiceC()%></small></div>
        <img src="img/green-tick.png" class="green-tick hidden"/>
        <img src="img/red-cross.png" class="red-cross hidden"/>
    </div>
</div>
    
<div id="choice_d" class="panel panel-default col-md-6 quiz-unselected-answer quiz-choice" data-choice="d">
    <div class="panel-body">
        <div class="col-xs-1 quiz-question quiz-answer">D</div>
        <div class="col-xs-11 quiz-question quiz-answer"><small><%=question.getChoiceD()%></small></div>
        <img src="img/green-tick.png" class="green-tick hidden"/>
        <img src="img/red-cross.png" class="red-cross hidden"/>
    </div>
</div>
    
<div class="text-right">
    <button id="submit" class="btn btn-lg btn-facebook btn-srad" data-answer="">submit</button>
    <button id="next" class="btn btn-lg btn-facebook btn-srad hidden">next</button>
</div>
    
    
</div>
</div>
</div>
</div>                  
</header>                     

<jsp:include page="_footer.jsp" />

<script>
    var score = <%=score%>;
    var correct_questions = "<%=correctQuestions%>";
    var qid = <%=id%>;
    $(".incomplete").click(function(e){
        e.preventDefault()
        alert("Oops! This is not yet available!")
    });
    
    $(".quiz-unselected-answer").click(function(){
        $(this).removeClass("quiz-unselected-answer");
        $(this).addClass("quiz-selected-answer");
        $("#submit").data("answer", $(this).data("choice").toString());

        var sibling = $(this).siblings(".quiz-selected-answer");
        sibling.removeClass("quiz-selected-answer");
        sibling.addClass("quiz-unselected-answer");
    });
    
    $("#submit").click(function(){
        var selected_answer = $(this).data("answer");
        var correct_answer = "<%=question.getAnswer()%>";
        if (selected_answer !== correct_answer){
            $("#choice_" + correct_answer).addClass("quiz-selected-answer");
            $("#choice_" + correct_answer).removeClass("quiz-unselected-answer");
            $("#choice_" + selected_answer).addClass("wrong-answer");
            $("#choice_" + selected_answer).removeClass("quiz-selected-answer");
            $("#choice_" + selected_answer).children().children(".red-cross").removeClass("hidden");
        } else {
            $("#choice_" + selected_answer).children().children(".green-tick").removeClass("hidden");
            score++;
            correct_questions += qid + ",";
        }
        $("#submit").addClass("hidden");
        $("#next").removeClass("hidden");
    });
    
    $("#next").click(function(){
        $.ajax({
            url: "/StoreSessionVariableServlet",
            method: "POST",
            data: {
                currentQuestion: <%=(currentQuestion + 1)%>,
                score: score,
                correctQuestions: correct_questions
            },
            success: function(){
                location.reload();
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.log(textStatus, errorThrown);
            }
        });
        
        /*
        $("#choice_a").removeClass("quiz-selected-answer");  
        $("#choice_b").removeClass("quiz-selected-answer");
        $("#choice_c").removeClass("quiz-selected-answer");
        $("#choice_d").removeClass("quiz-selected-answer");

        $("#choice_a").addClass("quiz-unselected-answer");
        $("#choice_b").addClass("quiz-unselected-answer");
        $("#choice_c").addClass("quiz-unselected-answer");
        $("#choice_d").addClass("quiz-unselected-answer");

        $("#choice_a").removeClass("wrong-answer");
        $("#choice_b").removeClass("wrong-answer");
        $("#choice_c").removeClass("wrong-answer");
        $("#choice_d").removeClass("wrong-answer");

        $("#choice_a").children().children(".red-cross").addClass("hidden");
        $("#choice_b").children().children(".red-cross").addClass("hidden");
        $("#choice_c").children().children(".red-cross").addClass("hidden");
        $("#choice_d").children().children(".red-cross").addClass("hidden");

        $("#choice_a").children().children(".green-tick").addClass("hidden");
        $("#choice_b").children().children(".green-tick").addClass("hidden");
        $("#choice_c").children().children(".green-tick").addClass("hidden");
        $("#choice_d").children().children(".green-tick").addClass("hidden");

        var q_header = "<%=question.getQuestion()%>";
        var choice_a = "<%=question.getChoiceA()%>";
        var choice_b = "<%=question.getChoiceB()%>";
        var choice_c = "<%=question.getChoiceC()%>";
        var choice_d = "<%=question.getChoiceD()%>";
        
        $("#quiz-question").html(q_header);
        $("#choice_a").children().children(".quiz-answer").children().html(choice_a);
        $("#choice_b").children().children(".quiz-answer").children().html(choice_b);
        $("#choice_c").children().children(".quiz-answer").children().html(choice_c);
        $("#choice_d").children().children(".quiz-answer").children().html(choice_d);
        
        $("#submit").removeClass("hidden");
        $("#next").addClass("hidden");
        */
    });
</script>
