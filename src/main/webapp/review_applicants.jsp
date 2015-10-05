<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>
<jsp:include page="_user_profile.jsp" />
    
<%@ page import="model.User"%>
<%@ page import="model.Post"%>
<%@ page import="model.Match"%>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>

<%@ page buffer="16kb" %>
<%  String postID = request.getParameter("id");
ArrayList <User> hiredList = (ArrayList <User>)session.getAttribute("hiredList");
ArrayList <User> completedList = (ArrayList <User>)session.getAttribute("completedList");
HashMap <Integer, Match> matchMap = (HashMap <Integer, Match>)session.getAttribute("matchMap");
String formURL = "/GetPostServlet?id=" + postID + "&location=reviewing";
Post post = (Post)session.getAttribute("post");
if (post == null){ %>
<jsp:forward page="<%=formURL%>" />
<% } else { 
session.removeAttribute("post"); 
session.removeAttribute("hiredList");
session.removeAttribute("reviewingList");
session.removeAttribute("completedList");
session.removeAttribute("matchMap");
}%>
    
<header class="main">
<div class="header-full-content">
<jsp:include page="_message.jsp" />

<div id="review-error" class="alert alert-danger" role="alert" style="font-size: 14px;" hidden>
  <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
  <span class="sr-only">Error:</span>
  <strong>Please rate all the job seekers before submitting</strong>
</div>

<div class="row">
    <div class="col-md-4">
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

    <div class="col-md-8">
        <div class="panel panel-default">
            <div class="panel-heading"> 
                <h4>Applicants Pending Reviews</h4> 
            </div> 
            <table class="table db-job-table table-hover review-table"> 
                <thead> 
                    <tr style="cursor: default;"> 
                        <th>Name</th>
                        <th>Status</th>
                        <th style="text-align: center;">Rating</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody> 
                    <%  if (hiredList.size() > 0){   
                            for (User user : hiredList){ 
                                Match match = matchMap.get(user.getId());%>
                                <tr class="open-profileModal" data-name="<%= user.getUsername()%>" data-email="<%= user.getEmail()%>" data-contact="<%= String.valueOf(user.getContactNumber())%>" data-avatar="<%=user.getAvatar()%>" data-good="<%=user.getGoodRating()%>" data-neutral="<%=user.getNeutralRating()%>" data-bad="<%=user.getBadRating()%>"> 
                                    <td><%=user.getUsername()%></td>
                                    <td>Completed</td>
                                    <td align="center">
                                        <div id="<%=user.getId()%>" class="score" data-score="2">
                                            <img class="ratings_icon" id="rating_bad" src="/img/bad.png"/>
                                            <img class="ratings_icon" id="rating_neutral" src="/img/neutral.png"/>
                                            <img class="ratings_icon" id="rating_good" src="/img/good.png"/>
                                        </div>
                                    </td>
                                    <td>
                                        <textarea data-userid="<%=user.getId()%>" class="form-control user_comment" style="min-width: 100%"></textarea>
                                    </td>
                                </tr> 
                            <% } %>
                            <tr style="cursor: default; background-color: white;">
                                <td colspan="4" class="text-center">
                                    <input type="button" class="btn btn-primary btn-lg btn-rate" value="Submit" />
                                </td>
                            </tr>
                        <% } else { %>
                            <tr style="cursor: default; background-color: white;"><td colspan="5" class="text-center">There are no applicants awaiting ratings!</td></tr>
                        <% } %>   
                </tbody>
            </table>
        </div>
                
        <div class="panel panel-default">
            <div class="panel-heading"> 
                <h4>Reviewed Applicants</h4> 
            </div> 
            <table class="table db-job-table table-hover review-table"> 
                <thead> 
                    <tr style="cursor: default;"> 
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
                                <tr class="open-profileModal" data-name="<%= user.getUsername()%>" data-email="<%= user.getEmail()%>" data-contact="<%= String.valueOf(user.getContactNumber())%>" data-avatar="<%=user.getAvatar()%>" data-good="<%=user.getGoodRating()%>" data-neutral="<%=user.getNeutralRating()%>" data-bad="<%=user.getBadRating()%>"> 
                                    <td><%=user.getUsername()%></td>
                                    <td>Reviewed</td>
                                    <td align="center">
                                        <div id="<%=user.getId()%>">
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
                                    <td><button class="btn btn-success btn-view-comment" data-id="<%=user.getId()%>" data-rating="<%=match.getRating()%>" data-comment="<%=match.getComment()%>" data-enabled="disabled">View Comments</button></td>
                                </tr>
                            <% } %>
                        <% } else { %>
                            <tr style="cursor: default; background-color: white;"><td colspan="4" class="text-center">There are no reviewed applicants yet!</td></tr>
                        <% } %>   
                </tbody>
            </table>
        </div>
    </div>
</div>
<a href="/dashboard.jsp" class="btn btn-lg btn-warning btn-srad" type="button">Back to Dashboard</a>
</div>
</header>

<!-- Comment Modal -->
<div class="modal fade" id="commentModal" tabindex="-1" role="dialog" aria-labelledby="commentModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    
            </div>
            <div class="modal-body payment-mode text-center">
                
                <h4 id="comment_header">Leave a comment</h4>
                <h5 id="view_comment_message">You have already submitted your comments for this person!</h5>
                <input type="hidden" name="userid" id="comment_userid" />
                <input type="hidden" name="user_comments" id="user_comments" />
                <textarea id="user_comment" class="form-control" style="min-width: 100%"></textarea>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal">Submit</button>
            </div>
        </div>
    </div>
</div>
    
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

<!-- Mark as complete confirmation modal -->
<div class="modal fade" id="completeJobModal" tabindex="-1" role="dialog" aria-labelledby="hireModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    
            </div>
            <div class="modal-body payment-mode text-center">
                
                <h4>Mark this job as complete?</h4>
                    
                <form action="/CompleteJobServlet" method="POST" class="display-inline"/>
                    <input type="text" id="complete_applicant_id" name="applicant_id" hidden />
                    <input type="text" id="complete_post_id" name="post_id" hidden />
                    <input type="submit" class="btn btn-lg btn-primary" value="Yes" />
                </form>
                <button class="btn btn-lg btn-primary" data-dismiss="modal">No</button>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<!-- END Complete confirmation modal -->

<!-- submit ratings confirmation modal -->
<div class="modal fade" id="submit_rating_modal" tabindex="-1" role="dialog" aria-labelledby="submitRatingModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    
            </div>
            <div class="modal-body payment-mode text-center">
                
                <h4>Submit your ratings?</h4>
                    
                <form id="rate_user_form" action="/RateUserServlet" method="POST" class="display-inline" />
                    <input type="hidden" name="ratings" id="form_ratings"/>
                    <input type="hidden" name="comments" id="form_comments" />
                    <input type="hidden" name="post_id" value="<%=postID%>" />
                    <input type="submit" class="btn btn-primary btn-lg" value="Yes" />
                </form>
                <button class="btn btn-lg btn-primary" data-dismiss="modal">No</button>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<!-- END submit ratings modal -->

<script>
    var comments = {};
    
    $(document).on("click", ".btn-comment", function() {
        var id = $(this).data("id");
        $('#commentModal').modal('show');
        $("#view_comment_message").attr("hidden", "hidden");
        $("#comment_header").html("Leave a comment");
        $("#comment_userid").val(id);
        if (typeof comments[id] === "undefined"){
            $("#user_comment").val("");
        } else {
            $("#user_comment").val(comments[id]);
        }
    });
    
    $(document).on("click", ".btn-view-comment", function() {
        var comments = $(this).data('comment');
        $('#view_user_comment').val(comments);
        $('#viewComment').modal('show');
    });
    
    $("#commentModal").on('hidden.bs.modal', function(){
       comments[$("#comment_userid").val()] = $("#user_comment").val();
    });
    
    $(".user_comment").focusout(function(){
       var user_id = $(this).data("userid");
       var comment = $(this).val();
       comments[user_id] = comment;
    });
    
    $(document).on("click", "button", function(e){
        e.stopPropagation();
    });
    
    $(document).on("click", "textarea", function(e){
        e.stopPropagation();
    });
</script>
<!-- End of Hire Modal -->
    
    
<script>
    $(document).on("click", ".btn-rate", function(event) {
        var scores = {};
        $("#review-error").attr("hidden", true);
        var cont = true;
        $('.score').each(function() {
            $(this).parent().parent().removeClass("rate-error");
            var id = $(this).attr("id");
            var score = $(this).data('score');
            if(score === 2){
                $(this).parent().parent().addClass("rate-error");
                cont = false;
            }
            scores[id] = score;
        });
        
        if (cont){
        $("#form_ratings").val(JSON.stringify(scores));
        $("#form_comments").val(JSON.stringify(comments));
        $('#submit_rating_modal').modal('show');
        } else {
            $("#review-error").attr("hidden", false);
            return false;
        } 
    });
</script>
    
<script>
    $(document).on("click", ".btn-complete", function() {
        var userID = $(this).data("userid");
        var postID = $(this).data("postid");
        
        $("#complete_applicant_id").val(userID);
        $("#complete_post_id").val(postID);
        $("#completeJobModal").modal('show');
    });
    
    $(document).on("click", ".ratings_icon", function(e) {
        e.stopPropagation();
        if ($(this).hasClass("ratings_icon_selected")){
            $(this).removeClass("ratings_icon_selected");
            $(this).parent().data("score", "2"); // 2 is set when no ratings
        } else {
            $(this).addClass("ratings_icon_selected");
            $(this).removeClass("ratings_icon_unselected");
            var image = $(this).attr("src");
            if (image.indexOf("bad") !== -1){
                $(this).parent().data("score", "-1");
                $("#rating_good").removeClass("ratings_icon_selected");
                $("#rating_good").addClass("ratings_icon_unselected");
                $("#rating_neutral").removeClass("ratings_icon_selected");
                $("#rating_neutral").addClass("ratings_icon_unselected");
            } else if (image.indexOf("good") !== -1){
                $(this).parent().data("score", "1");
                $("#rating_bad").removeClass("ratings_icon_selected");
                $("#rating_bad").addClass("ratings_icon_unselected");
                $("#rating_neutral").removeClass("ratings_icon_selected");
                $("#rating_neutral").addClass("ratings_icon_unselected");
            } else {
                $(this).parent().data("score", "0");
                $("#rating_good").removeClass("ratings_icon_selected");
                $("#rating_good").addClass("ratings_icon_unselected");
                $("#rating_bad").removeClass("ratings_icon_selected");
                $("#rating_bad").addClass("ratings_icon_unselected");
            }  
        }
    });
</script>
    
    
<jsp:include page="_javascript_checker.jsp" />
<jsp:include page="_footer.jsp" />