<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>

<%@ page import="java.util.HashMap" %>

<% int score = Integer.parseInt((String)session.getAttribute("score"));
String genre = (String)session.getAttribute("genre");
HashMap <String, String> nameMap = new HashMap <String, String> ();
nameMap.put("clean_up", "Clean Up");

session.removeAttribute("question1");
session.removeAttribute("question2");
session.removeAttribute("question3");
session.removeAttribute("question4");
session.removeAttribute("question5");
session.removeAttribute("currentQuestion");
session.removeAttribute("score");
session.removeAttribute("genre");
%>
<header class="main">
<div class="header-content">
<div class="header-content-inner">
<div class="row">
<div class="col-md-12">  
<div class="panel panel-default">
    <div class="panel-body">
        <h2 style="color: black;">Your total score for the quiz is</h2>
        <h1 class="quiz-score"> <%=score%> / 5 </h1>
        <h3 style="color: black;">A total of <strong style="color: red;"><%=(score * 10)%></strong> points will be added to your score for the category: </h3>
        <h3 class="quiz-score-genre"> <%=nameMap.get(genre)%> </h3>
    </div>
</div>
<a href="/scoreboard.jsp" class="btn btn-warning">Back to Scoreboard </a>
</div>
</div>
</div>
</div>                  
</header>                     
<jsp:include page="_footer.jsp" />

<script>
    $(document).ready(function(){
        $.ajax({
            url: "/RecordScoreServlet",
            method: "POST",
            data: {
                genre: "<%=genre%>",
                questions: "<%=(String)session.getAttribute("correctQuestions")%>"
            },
            success: function(){
                
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.log(textStatus, errorThrown);
            }
        });
    });
</script>