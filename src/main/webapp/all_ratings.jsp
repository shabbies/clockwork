<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>

<%@include file="_job_details.jsp"%>
    
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.User"%>
<%@ page import="model.Post"%>
<%@ page buffer="16kb" %>
<%
if (currentUser == null){
session.setAttribute("error", "Please login or register first before viewing your job applications!");
response.sendRedirect("/login.jsp");
return;
} else if (currentUser.getAccountType().equals("employer")){
session.setAttribute("error", "Only a job seeker account can view his own ratings!");
response.sendRedirect("/index.jsp");
return;}

ArrayList <Post> completedJobs = (ArrayList <Post>)session.getAttribute("completedJobs");
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
                        <tr class="negative">
                    <% } else if (rating == 0) { %>
                        <tr class="neutral">
                    <% } else { %>
                        <tr class="positive">
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
                        <tr class="text-center"><td colspan="5">You have not completed any jobs yet! Try doing a job first!</td></tr>
                        <tr class="text-center"><td colspan="5">
                            <a href="/index.jsp" class="btn btn-primary"><i class="fa fa-fw fa-plus"></i> Search for a Job</a>
                            </td></tr>
                    <% } %>
                    %>
                </tbody>
            </table>
        </div> 
    </div>

    <div class="col-md-4">
        <div class="panel panel-default">
            <div class="panel-body db-user">

                <div class="text-center">
                    <% if (currentUser.getAvatar() == null){%>
                    <img src="img/user-placeholder.jpg" alt="" class="db-user-pic col-centered img-rounded img-responsive" />
                    <% } else { %>
                    <img src="<%=currentUser.getAvatar()%>" alt="" class="db-user-pic col-centered img-rounded img-responsive" />
                    <%}%>
                </div>

                <div class="db-user-info">
                    <h2>Hi <%= currentUser.getUsername()%>!</h2>
                    <div class="text-center ratings_info">
                        <div>My ratings:</div>
                        <%=currentUser.getGoodRating()%> <img src="/img/good.png" class="listing_ratings"/>
                        <%=currentUser.getNeutralRating()%> <img src="/img/neutral.png" class="listing_ratings"/>
                        <%=currentUser.getBadRating()%> <img src="/img/bad.png" class="listing_ratings"/>
                    </div>
                    <span>What would you like to do today?</span>
                </div>
                <%if (currentUser.getContactNumber() == 0 || currentUser.getDateOfBirth() == null || currentUser.getGender() == '\u0000' || currentUser.getNationality() == null){%>
                <a href="/complete_profile.jsp" class="btn btn-primary btn-block"><i class="fa fa-fw fa-plus"></i> Complete my Profile</a>
                <% } else { %> 
                <a href="/edit_profile.jsp" class="btn btn-primary btn-block"><i class="fa fa-fw fa-plus"></i> Update my Profile</a><% } %>
                <a href="/all_ratings.jsp" class="btn btn-primary btn-block"><i class="fa fa-fw fa-star"></i> View my Ratings</a>
                <a href="#" class="btn btn-primary btn-block incomplete"><i class="fa fa-fw fa-book"></i> View my Achived Jobs</a>
            </div>
        </div>
    </div>
<div>
    <a href="/mydashboard.jsp" class="btn btn-lg btn-warning btn-srad" type="button">Back to Dashboard</a>
</div>

</div>

</div>
</header>
<jsp:include page="_footer.jsp" />