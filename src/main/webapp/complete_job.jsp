<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>
<%@include file="_only_emp.jsp"%>
<jsp:include page="_user_profile.jsp" />
    
<%@ page import="model.User"%>
<%@ page import="model.Post"%>
<%@ page import="model.Match"%>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>

<%@ page buffer="16kb" %>
<%  String postID = request.getParameter("id");
ArrayList <User> completedList = (ArrayList <User>)session.getAttribute("completedList");
HashMap <Integer, Match> matchMap = (HashMap <Integer, Match>)session.getAttribute("matchMap");
String formURL = "/GetPostServlet?id=" + postID + "&location=completed";
Post post = (Post)session.getAttribute("post");
if (post == null){ %>
<jsp:forward page="<%=formURL%>" />
<% } else { 
session.removeAttribute("post"); 
session.removeAttribute("completedList");
session.removeAttribute("matchMap");
}%>
    
<header class="main">
<div class="header-content">
<%@include file="_message.jsp"%>
<div class="row">
    <div class="col-md-5">
        <div class="panel panel-default">
            <div class="panel-body db-user">
                <div class="text-center">
                    <% if (post.getAvatarPath() == null){%>
                    <img src="http://placehold.it/120x120" alt="" class="db-user-pic col-centered img-rounded img-responsive" />
                    <% } else { %>
                    <img src="<%=post.getAvatarPath()%>" alt="" class="db-user-pic col-centered img-rounded img-responsive" />
                    <% } %>
                </div>

                <div class="db-user-info">
                    <h2><%=post.getHeader()%></h2> 
                    <h5><%=post.getDescription()%></h5>
                </div> 
            </div>
        </div>
    </div>


    <div class="col-md-7">
        <div class="panel panel-default">
            <div class="panel-heading"> 
                <h4>Reviewed Applicants</h4> 
            </div> 
            <table class="table db-job-table review-table table-hover"> 
                <thead> 
                    <tr> 
                        <th>Name</th>
                        <th>Status</th>
                        <th>Rating</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody> 
                    <%  if (completedList.size() > 0){   
                            for (User user : completedList){ 
                                Match match = matchMap.get(user.getId());%>
                                <tr class="open-profileModal" data-name="<%= user.getUsername()%>" data-email="<%= user.getEmail()%>" data-contact="<%= String.valueOf(user.getContactNumber())%>" data-gender="<%=user.getGender()%>" data-nationality="<%=user.getNationality()%>" data-avatar="<%=user.getAvatar()%>" data-good="<%=user.getGoodRating()%>" data-neutral="<%=user.getNeutralRating()%>" data-bad="<%=user.getBadRating()%>"> 
                                    <td><%=user.getUsername()%></td>
                                    <td>Reviewed</td>
                                    <td align="center">
                                        <div id="<%=user.getId()%>" data-score="2">
                                            <% int rating = match.getRating();%>
                                            <% if (rating == -1) { %>
                                            <img class="listing_ratings" id="rating_bad" src="/img/bad.png"/>
                                            <% } else if (rating == 0) { %>
                                            <img class="listing_ratings" id="rating_neutral" src="/img/neutral.png"/>
                                            <% } else { %>
                                            <img class="listing_ratings" id="rating_good" src="/img/good.png"/>
                                            <% } %>
                                        </div>
                                    </td>
                                    <td><%=(match.getComment() == null) ? "No comments" : match.getComment()%></td>
                                </tr>
                            <% } %>
                        <% } else { %>
                            <tr><td colspan="5" class="text-center">There are no reviewed applicants yet!</td></tr>
                        <% } %>   
                </tbody>
            </table>
        </div>
    </div>
</div>
<a href="/dashboard.jsp" class="btn btn-lg btn-warning btn-srad" type="button">Back to Dashboard</a>
</div>
</header>
                
<!-- View Comment Modal -->
<div class="modal fade" id="viewComment" tabindex="-1" role="dialog" aria-labelledby="commentModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>   
            </div>
            <div class="modal-body payment-mode text-center">
                
                <h4 id="comment_header">View your comment</h4>
                <h5 id="view_comment_message">You have already submitted your comments for this person!</h5>
                <textarea id="view_user_comment" class="form-control" style="min-width: 100%" disabled="disabled"></textarea>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).on("click", ".btn-view-comment", function() {
        var comments = $(this).data('comment');
        $('#view_user_comment').val(comments);
        $('#viewComment').modal('show');
    });
</script>
<!-- End of Hire Modal -->
    
    
<jsp:include page="_javascript_checker.jsp" />
<jsp:include page="_anchor.jsp" />
<jsp:include page="_footer.jsp" />