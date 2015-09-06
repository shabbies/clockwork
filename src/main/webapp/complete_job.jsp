<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>
    
<%@ page import="model.User"%>
<%@ page import="model.Post"%>
<%@ page import="model.Match"%>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>

    
<%  String postID = request.getParameter("id");
ArrayList <User> hiredList = (ArrayList <User>)session.getAttribute("hiredList");
ArrayList <User> completedList = (ArrayList <User>)session.getAttribute("completedList");
HashMap <Integer, Match> matchMap = (HashMap <Integer, Match>)session.getAttribute("matchMap");
String formURL = "/GetPostServlet?id=" + postID + "&location=complete";
Post post = (Post)session.getAttribute("post");
if (post == null){ %>
<jsp:forward page="<%=formURL%>" />
<% } else { 
session.removeAttribute("post"); 
session.removeAttribute("hiredList");
session.removeAttribute("completedList");
session.removeAttribute("matchMap");
}%>
    
<header class="main">
<div class="header-content">
<% if (session.getAttribute("error") != null){%>
    <div class="alert alert-danger" role="alert">
        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
        <span class="sr-only">Error:</span>
        <%=session.getAttribute("error")%>
    </div>
    <%session.removeAttribute("error");}%>
    <% if (session.getAttribute("message") != null){%>
    <div class="alert alert-success" role="alert">
        <span class="glyphicon glyphicon-ok-sign" aria-hidden="true"></span>
        <%=session.getAttribute("message")%>
    </div>
    <% session.removeAttribute("message");}
%>
<div class="row">
    <div class="col-md-5">
        <div class="panel panel-default">
            <div class="panel-body db-user">
                <div class="text-center">
                    <% if (post.getAvatarPath() == null){%>
                    <img src="http://placehold.it/120x120" alt="" class="col-centered img-rounded img-responsive" />
                    <% } else { %>
                    <img src="<%=post.getAvatarPath()%>" alt="" class="col-centered img-rounded img-responsive" />
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
                <h4>Your Hired Help</h4> 
            </div> 
            <table class="table db-job-table"> 
                <thead> 
                    <tr> 
                        <th>Name</th>
                        <th>Status</th>
                        <th>Choose Rating</th>
                        <th>Leave a Review</th>
                    </tr>
                </thead>
                <tbody> 
                    <%  if (hiredList.size() > 0){   
                            for (User user : hiredList){ %>
                                <tr> 
                                    <td><%=user.getUsername()%></td>
                                    <td>Hired</td>
                                    <td><div id="<%=user.getId()%>" class="score" data-score="4"></div></td>
                                    <td><button class="btn btn-info btn-complete" data-userid="<%=user.getId()%>" data-postid="<%=post.getId()%>">Mark as Complete</button></td>
                                    <td><a href="#" class="btn btn-warning open-profileModal" data-name="<%= user.getUsername()%>" data-email="<%= user.getEmail()%>" data-contact="<%= String.valueOf(user.getContactNumber())%>" data-avatar="<%=user.getAvatar()%>" data-rating="4">View Profile</a></td>
                                </tr>
                            <% } %>
                        <% } else { %>
                            <tr><td colspan="4" class="text-center">No Hired Help</td></tr>
                        <% } %>   
                </tbody>
            </table>
        </div>
                
        <div class="panel panel-default">
            <div class="panel-heading"> 
                <h4>Your Completed Help</h4> 
            </div> 
            <table class="table db-job-table"> 
                <thead> 
                    <tr> 
                        <th>Name</th>
                        <th>Status</th>
                        <th>Choose Rating</th>
                        <th>Leave a Review</th>
                    </tr>
                </thead>
                <tbody> 
                    <%  if (completedList.size() > 0){   
                            for (User user : completedList){ 
                                Match match = matchMap.get(user.getId());%>
                                <tr> 
                                    <% if (match.getRating() == 2){ %>
                                        <td><%=user.getUsername()%></td>
                                        <td>Completed</td>
                                        <td align="center">
                                            <div id="<%=user.getId()%>" data-score="2">
                                                <img class="ratings_icon" id="rating_bad" src="/img/bad.png"/>
                                                <img class="ratings_icon" id="rating_neutral" src="/img/neutral.png"/>
                                                <img class="ratings_icon" id="rating_good" src="/img/good.png"/>
                                            </div>
                                        </td>
                                        <td><button class="btn btn-success btn-comment" data-id="<%=user.getId()%>" data-rating="<%=match.getRating()%>" data-comment="<%=match.getComment()%>" data-enabled="enabled">Leave Comment</button></td>
                                        <td><a href="#" class="btn btn-warning open-profileModal" data-name="<%= user.getUsername()%>" data-email="<%= user.getEmail()%>" data-contact="<%= String.valueOf(user.getContactNumber())%>" data-avatar="<%=user.getAvatar()%>">View Profile</a></td>
                                    <% } else { %>
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
                                        <td><button class="btn btn-success btn-view-comment" data-id="<%=user.getId()%>" data-rating="<%=match.getRating()%>" data-comment="<%=match.getComment()%>" data-enabled="disabled">View Comments</button></td>
                                        <td><a href="#" class="btn btn-warning open-profileModal" data-name="<%= user.getUsername()%>" data-email="<%= user.getEmail()%>" data-contact="<%= String.valueOf(user.getContactNumber())%>" data-avatar="<%=user.getAvatar()%>">View Profile</a></td>
                                    <% } %>
                                </tr>
                            <% } %>
                        <% } else { %>
                            <tr><td colspan="4" class="text-center">No Completed Help</td></tr>
                        <% } %>   
                </tbody>
            </table>
            <form id="rate_user_form" action="/RateUserServlet" method="POST" class="display-inline"/>
                <input type="hidden" name="ratings" id="form_ratings"/>
                <input type="hidden" name="comments" id="form_comments" />
                <input type="hidden" name="post_id" value="<%=postID%>" />
                <input type="submit" class="btn btn-primary btn-lg btn-rate" value="Submit My Ratings" />
            </form>
        </div>
    </div>
</div>
</div>
</header>
<!-- Profile Modal -->
<div class="modal fade" id="profileModal" tabindex="-1" role="dialog" aria-labelledby="profileModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    
            </div>
            <div class="modal-body">
                
                <div class="col-md-12 modal-job-details">
                    <div class="col-md-4 text-center">
                        <img id="hiring_avatar" src="http://placehold.it/120x120" alt="" class="db-user-pic img-rounded img-responsive"/>
                    </div>
                        
                    <div class="col-md-8">
                        <h4 id="modalName"></h4>
                        <h5 id="modalContact"></h5>
                        <h5 id="modalEmail"></h5>
                        <div id="modalRating"></div>
                    </div>
                </div>
                    
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
    
<!-- Hire Modal -->
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
</script>
<!-- End of Hire Modal -->
    
    
<script>
    $(document).on("click", ".btn-rate", function(event) {
        event.preventDefault();
        var scores = {};
        $('.score').each(function() {
            var id = this.id;
            var currentScore = $(this).raty('score');
            scores[id] = currentScore;
            
        });
        $("#form_ratings").val(JSON.stringify(scores));
        $("#form_comments").val(JSON.stringify(comments));
        $("#rate_user_form").submit();
    });
</script>
    
    
<script>
    $.fn.raty.defaults.path = '../rating/images';
    $(function() {
        $('.score').raty({
            score: function() {
                return $(this).attr('data-score');
            }
        });
        $('.ratings').raty({
            score: function() {
                return $(this).attr('data-score');
            },readOnly: true
        });
        
        
    });
</script>
    
<script>
    $(document).on("click", ".open-profileModal", function() {
        var nameText = $(this).data('name');
        var contactText = $(this).data('contact');
        var emailText = $(this).data('email');
        var ratingText = $(this).data('rating');
        var avatarText = $(this).data('avatar');
        
        $('#modalName').html("<strong>"+nameText+"</strong>");
        if (typeof contactText === 'undefined'){
            $('#modalContact').html("Phone number: Phone number has been hidden");
        } else {
            $('#modalContact').html("Phone number: " + contactText);
        }
        if (typeof emailText === 'undefined'){
            $('#modalEmail').html("Email: Email has been hidden");
        } else {
            $('#modalEmail').html("Email: " + emailText);
        }
        if (avatarText !== null){
            $('#hiring_avatar').attr("src", avatarText); 
        } else {
            $('#hiring_avatar').attr("src", "img/user-placeholder.jpg"); 
        }
        
        $('#modalRating').raty({
            score: ratingText,readOnly: true
        });
        
        $('#profileModal').modal('show');
    });
    
    $(document).on("click", ".btn-complete", function() {
        var userID = $(this).data("userid");
        var postID = $(this).data("postid");
        
        $("#complete_applicant_id").val(userID);
        $("#complete_post_id").val(postID);
        $("#completeJobModal").modal('show');
    });
    
    $(document).on("click", ".ratings_icon", function() {
        if ($(this).hasClass("ratings_icon_selected")){
            $(this).removeClass("ratings_icon_selected");
            $(this).parent().data("score", "2"); // 2 is set when no ratings
        } else {
            $(this).addClass("ratings_icon_selected");
            var image = $(this).attr("src");
            if (image.indexOf("bad") !== -1){
                $(this).parent().data("score", "-1");
                $("#rating_good").removeClass("ratings_icon_selected");
                $("#rating_neutral").removeClass("ratings_icon_selected");
            } else if (image.indexOf("good") !== -1){
                $(this).parent().data("score", "1");
                $("#rating_bad").removeClass("ratings_icon_selected");
                $("#rating_neutral").removeClass("ratings_icon_selected");
            } else {
                $(this).parent().data("score", "0");
                $("#rating_good").removeClass("ratings_icon_selected");
                $("#rating_bad").removeClass("ratings_icon_selected");
            }  
        }
    });
</script>
    
    
<jsp:include page="_javascript_checker.jsp" />
<jsp:include page="_footer.jsp" />