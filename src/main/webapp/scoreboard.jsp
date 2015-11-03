<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>
<%@include file="_only_js.jsp"%>
<%@ page buffer="32kb" %>

<%@ page import="java.util.HashMap" %>
<%
HashMap <String, Integer> scoreMap = (HashMap <String, Integer>)session.getAttribute("scoreMap");
if (scoreMap == null){ %>
<jsp:forward page="/GetScoreServlet" />
<% } else {
session.removeAttribute("scoreMap");}%>

<header class="main">
<div class="header-full-content">
    
<%@include file="_message.jsp"%>
    
<div class="row">
    <div class="col-md-8">
        <div class="panel panel-default center-panel-content">
            <div class="panel-heading"> 
                <h4>Your Scores</h4> 
            </div> 

            <table class="table table-hover"> 

                <thead> 
                    <tr id="header-row"> 
                        <th>Type</th>
                        <th>Score</th>
                        <th></th>
                    </tr>
                </thead>

                <tbody> 
                    <% for (String key : scoreMap.keySet()) {%>
                    <tr>
                        <td><%=key%></td>
                        <td><%=scoreMap.get(key)%></td>
                        <td>
                            <a href="/improve.jsp" class="btn btn-primary incomplete"> Improve </a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <div>
                <a href="/gamify_categories.jsp" class="btn btn-primary"><i class="fa fa-fw fa-plus"></i> Improve your Score!</a>
                <a href="/badges.jsp" class="btn btn-warning"> <i class="fa fa-fw fa-trophy"></i>View My Badges </a>
            </div>
        </div> 
    </div>
    <%@include file="_js_dashboard.jsp"%>
</div>

</div>
</header>
<jsp:include page="_anchor.jsp" />
<jsp:include page="_footer.jsp" />

<script>
    $(".incomplete").click(function(e){
        e.preventDefault();
        alert("Oops! This is not yet available!")
    });
</script>