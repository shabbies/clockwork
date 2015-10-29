<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>

<%@include file="_job_details.jsp"%>
<%@include file="_only_js.jsp"%>
    
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.User"%>
<%@ page import="model.Post"%>
<%@ page buffer="32kb" %>
<%
ArrayList <Post> completedJobs = (ArrayList <Post>)session.getAttribute("completedJobsList");
%>
<header class="main">
<div class="header-full-content">
    
<%@include file="_message.jsp"%>
    
<div class="row">
    <div class="col-md-8">
        <div class="panel panel-default">
            <div class="panel-heading"> 
                <h4>Completed Jobs</h4> 
            </div> 

            <table class="table db-job-table db-rating-table"> 

                <thead> 
                    <tr id="header-row"> 
                        <th>Job</th>
                        <th>Company</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Rating</th>
                        <th>Comments</th>
                    </tr>
                </thead>

                <tbody> 
                    <% for (Post post : completedJobs) { %>
                    <% int rating = post.getRating();%>
                    <% if (rating == -1){ %>
                        <tr class="danger">
                    <% } else if (rating == 0) { %>
                        <tr class="warning">
                    <% } else { %>
                        <tr class="success">
                    <% } %>
                            <td><%=post.getHeader()%></td>
                            <td><%=post.getCompany()%></td>
                            <td><%=post.getJobDateString()%></td>
                            <td><%=post.getEndDateString()%></td>
                            <td>
                                <% if (rating == -1){ %>
                                    <img src="img/bad.png" class="listing_ratings" />
                                <% } else if (rating == 0) { %>
                                    <img src="img/neutral.png" class="listing_ratings" />
                                <% } else { %>
                                    <img src="img/good.png" class="listing_ratings" />
                                <% } %>
                            </td>
                            <td>
                                <% if (post.getComment() == null){ %>
                                    You did not receive a comment!
                                <% } else { %>
                                    <%=post.getComment()%>
                                <% } %>
                            </td>
                    </tr>
                    <% }
                    if (completedJobs.isEmpty()) { %>
                        <tr class="text-center"><td colspan="6">You have not completed any jobs yet! Try doing a job first!</td></tr>
                        <tr class="text-center">
                            <td colspan="6">
                                <a href="/index.jsp" class="btn btn-primary"><i class="fa fa-fw fa-plus"></i> Find Job!</a>
                            </td>
                        </tr>
                    <% } %>
                    %>
                </tbody>
            </table>
        </div> 
    </div>

    <%@include file="_js_dashboard.jsp"%>
<div>
    <a href="/mydashboard.jsp" class="btn btn-lg btn-warning btn-srad" type="button">Back to Dashboard</a>
</div>

</div>

</div>
</header>
<jsp:include page="_footer.jsp" />