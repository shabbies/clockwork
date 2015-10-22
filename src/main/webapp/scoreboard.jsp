<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>
<%@ page buffer="32kb" %>

<%@ page import="java.util.HashMap" %>
<%
if (currentUser == null){
session.setAttribute("error", "Please login or register first before viewing your job scores!");
response.sendRedirect("/login.jsp");
return;
} else if (currentUser.getAccountType().equals("employer")){
session.setAttribute("error", "Only a job seeker account can view his scores!");
response.sendRedirect("/index.jsp");
return;}

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
                            <a href="/improve.jsp" class="btn btn-primary"> Improve </a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div> 
    </div>
    <%@include file="_js_dashboard.jsp"%>
</div>

</div>
</header>
<jsp:include page="_footer.jsp" />
