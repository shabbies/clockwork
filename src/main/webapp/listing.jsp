<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>
<%@include file="_only_emp.jsp"%>
<jsp:include page="_user_profile.jsp" />
    
<%@ page import="model.User"%>
<%@ page import="model.Post"%>
<%@ page import="model.Match"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.TimeZone" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%@ page buffer="32kb" %>
<%  String postID = request.getParameter("id");
appController = (AppController)session.getAttribute("appController");
ArrayList <User> applicantList = (ArrayList <User>)session.getAttribute("applicantList");
ArrayList <User> offeredList = (ArrayList <User>)session.getAttribute("offeredList");
ArrayList <User> hiredList = (ArrayList <User>)session.getAttribute("hiredList");
ArrayList <Integer> applicantListUID = new ArrayList <Integer> ();
HashMap <Integer, Match> matchMap = (HashMap <Integer, Match>)session.getAttribute("matchMap");
String formURL = "/GetPostServlet?id=" + postID + "&location=listing";
Post post = (Post)session.getAttribute("post");
if (session.getAttribute("post") == null || session.getAttribute("matchMap") == null){ %>
<jsp:forward page="<%=formURL%>" />
<% } else { 
session.removeAttribute("matchMap");
session.removeAttribute("post"); 
session.removeAttribute("applicantList"); 
session.removeAttribute("hiredList"); 
session.removeAttribute("offeredList");}%>
<header class="main">
<div class="header-full-content">
    
<%@include file="_message.jsp"%>

<div class="row">
    
<div class="col-md-4">
    <div class="panel panel-default">
        <div class="panel-body db-user panel-body-listing-info">
            <% appController = (AppController)session.getAttribute("appController");
                if (!appController.getEnvironment().equals("production")){
                    String expirePostURL = appController.getAPIManager().getPrefix() + "/api/v1/posts/dev_expire_post?id=" + post.getId(); %>
                    <button data-expireURL="<%=expirePostURL%>" class="btn btn-primary pull-right expire-post">Expire Post</button>
            <%  } %>
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
    <div class="col-md-12 panel chat-panel">
        <div class="col-md-12 chat-panel-header">
            Chat <small> with your hires </small>
        </div>
        <%@include file="_chat.jsp"%>     
    </div>
</div>


<div class="col-md-8">
    <div class="panel panel-default listing-panel">
        <div class="panel-heading"> 
            <h4>Your Applicants</h4> 
        </div> 
        
        <div class="col-xs-12 header">
            <div class="col-xs-3 header hidden-xs">Name</div>
            <div class="col-xs-3 header hidden-xs">Rating</div>
            <div class="col-xs-3 header hidden-xs">Status</div>
            <div class="col-xs-3 header hidden-xs">Action </div>
            
            <div class="col-xs-4 header visible-xs">Name</div>
            <div class="col-xs-4 header visible-xs">Rating</div>
            <div class="col-xs-4 header visible-xs">Action </div>
        </div>
        <%  if (applicantList != null){
            if (applicantList.size() > 0){   
            for (User user : applicantList){ 
                applicantListUID.add(user.getId());%>
        <div class="open-profileModal col-xs-12 listing-details-bar" data-name="<%= user.getUsername()%>" data-gender="<%=user.getGender()%>" data-nationality="<%=user.getNationality()%>" data-avatar="<%=user.getAvatar()%>" data-good="<%=user.getGoodRating()%>" data-neutral="<%=user.getNeutralRating()%>" data-bad="<%=user.getBadRating()%>" data-qualification="<%=user.getQualification()%>" data-description="<%=user.getDescription()%>" >  
            <div class="col-sm-3 col-xs-4"><%=user.getUsername()%></div>
            <div class="col-sm-3 col-xs-4">
                <div class="ratings">
                    <%=user.getGoodRating()%> <img src="/img/good.png" class="listing_ratings"/>
                    <%=user.getNeutralRating()%> <img src="/img/neutral.png" class="listing_ratings"/>
                    <%=user.getBadRating()%> <img src="/img/bad.png" class="listing_ratings"/>
                </div>
            </div>
            <div class="hidden-xs col-sm-3">Pending</div>
            <div class="col-sm-3 col-xs-4">
                <button id="open_offer_job_modal" class="btn btn-success" data-postid="<%=postID%>" data-userid="<%=user.getId()%>">Offer Job</button>
            </div>
        </div>
        <% } %>
        <% if (applicantList.size() > 0) { %>
        <div class="col-xs-12">
            <button class="btn btn-primary" id="open_offer_all_job_modal" data-postid="<%=post.getId()%>"><span class="badge"><%=applicantList.size()%></span> Offer All </button>
        </div>
        <%}%>
        <% } else { %>
        <div class="col-xs-12 no-applicants-bar">No New Applicants</div>
        <% } %>
        <% } %>   
    </div>

    <div class="panel panel-default listing-panel">
        <div class="panel-heading"> 
            <h4>Your Offered Applicants</h4> 
        </div> 
        
        <div class="col-xs-12 header">
            <div class="col-xs-3 header hidden-xs">Name</div>
            <div class="col-xs-3 header hidden-xs">Rating</div>
            <div class="col-xs-3 header hidden-xs">Status</div>
            <div class="col-xs-3 header hidden-xs">Action </div>
            
            <div class="col-xs-4 header visible-xs">Name</div>
            <div class="col-xs-4 header visible-xs">Rating</div>
            <div class="col-xs-4 header visible-xs">Action </div>
        </div>

        <% if (offeredList != null){ %>
        <% if (offeredList.size() > 0) {%>
        <% for (User user : offeredList){ 
        HashMap <String, Integer> scoreMap = user.getScoreMap();%>

        <div class="open-profileModal listing-details-bar col-xs-12" data-name="<%= user.getUsername()%>" data-gender="<%=user.getGender()%>" data-nationality="<%=user.getNationality()%>" data-avatar="<%=user.getAvatar()%>" data-good="<%=user.getGoodRating()%>" data-neutral="<%=user.getNeutralRating()%>" data-bad="<%=user.getBadRating()%>" >  
            <div class="col-sm-3 col-xs-4"><%=user.getUsername()%></div>
            <div class="col-sm-3 col-xs-4">
                <div class="ratings">
                    <%=user.getGoodRating()%> <img src="/img/good.png" class="listing_ratings"/>
                    <%=user.getNeutralRating()%> <img src="/img/neutral.png" class="listing_ratings"/>
                    <%=user.getBadRating()%> <img src="/img/bad.png" class="listing_ratings"/>
                </div>
            </div>
            <div class="col-sm-3 hidden-xs">Offered</div>
            <div class="col-sm-3 col-xs-4">
                <form action="/WithdrawOfferServlet" method="POST" class="display-inline">
                    <input type="hidden" name="post_id" value="<%=postID%>" />
                    <input type="hidden" name="user_id" value="<%=user.getId()%>" />
                    <input type="submit" value="Cancel" class="btn btn-danger" />
                </form>
            </div>
        </div>
        <% } %>
        <% } else { %>
        <div class="col-xs-12 no-applicants-bar">No Offers Given</div>
        <% }
        } %>
    </div>
    
    <div class="panel panel-default listing-panel">
        <div class="panel-heading"> 
            <h4>Your Hired Applicants</h4> 
        </div> 
        <div class="col-xs-12 header">
            <div class="col-xs-4 header hidden-xs">Name</div>
            <div class="col-xs-4 header hidden-xs">Rating</div>
            <div class="col-xs-4 header hidden-xs">Action </div>
        </div>
        <% if (hiredList != null){ %>
        <% if (hiredList.size() > 0){ %>
        <% for (User user : hiredList){ 
        HashMap <String, Integer> scoreMap = user.getScoreMap();%>
        <div class="open-profileModal listing-details-bar col-xs-12" data-name="<%= user.getUsername()%>" data-gender="<%=user.getGender()%>" data-nationality="<%=user.getNationality()%>" data-email="<%= user.getEmail()%>" data-contact="<%= String.valueOf(user.getContactNumber())%>" data-avatar="<%=user.getAvatar()%>" data-good="<%=user.getGoodRating()%>" data-neutral="<%=user.getNeutralRating()%>" data-bad="<%=user.getBadRating()%>" data-qualification="<%=user.getQualification()%>" data-description="<%=user.getDescription()%>" >
            <div class="col-xs-4"><%=user.getUsername()%></div>
            <div class="col-xs-4">
                <div class="ratings">
                    <%=user.getGoodRating()%> <img src="/img/good.png" class="listing_ratings"/>
                    <%=user.getNeutralRating()%> <img src="/img/neutral.png" class="listing_ratings"/>
                    <%=user.getBadRating()%> <img src="/img/bad.png" class="listing_ratings"/>
                </div>
            </div>
            <div class="col-xs-4">
                <a href="#" id="hire_button" class="btn btn-warning open-profileModal" data-name="<%= user.getUsername()%>" data-gender="<%=user.getGender()%>" data-nationality="<%=user.getNationality()%>" data-email="<%= user.getEmail()%>" data-contact="<%= String.valueOf(user.getContactNumber())%>" data-avatar="<%=user.getAvatar()%>" data-good="<%=user.getGoodRating()%>" data-neutral="<%=user.getNeutralRating()%>" data-bad="<%=user.getBadRating()%>" data-qualification="<%=user.getQualification()%>" data-description="<%=user.getDescription()%>">View</a>
            </div>
        </div>
        <% } %>
        <% } else { %>
        <div class="col-xs-12 no-applicants-bar">No Hired Applicants</div>
        <% } %>
        <% } %>
    </div>
</div>
            
</div>
<a href="/dashboard.jsp" class="btn btn-lg btn-warning btn-srad" type="button">Back to Dashboard</a>
</div>
</header>
    
<script>
    
    $(document).on("click", ".btn-hire", function() {
        var userID = $(this).data("userid");
        var postID = $(this).data("postid");
        
        $("#form_user_id").val(userID);
        $("#form_post_id").val(postID);
        $('#hireModal').modal('show');
    });
    
    $(document).on("click", "#open_offer_job_modal", function() {
        var userID = $(this).data("userid");
        var postID = $(this).data("postid");
        
        $("#offer_user_id").val(userID);
        $("#offer_post_id").val(postID);
        $('#offer_job_modal').modal('show');
    });
    
    function showCompleteJobConfirmation(){
        var userID = $(this).data("userid");
        var postID = $(this).data("postid");
        
        $("#complete_applicant_id").val(userID);
        $("#complete_post_id").val(postID);
        $("#completeJobModal").modal('show');
    };
    
    $(document).on("click", "#open_offer_all_job_modal", function() {
        var postID = $(this).data("postid");
        
        $("#offer_all_post_id").val(postID);
        $("#offer_all_job_modal").modal('show');
    })
</script>
<!-- offer job confirmation modal -->
<div class="modal fade" id="offer_job_modal" tabindex="-1" role="dialog" aria-labelledby="offerJobModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    
            </div>
            <div class="modal-body payment-mode text-center">
                
                <h4>Offer this applicant the job?</h4>
                <form action="/OfferJobServlet" method="POST" class="display-inline">
                    <input type="hidden" id="offer_post_id" name="post_id"/>
                    <input type="hidden" id="offer_user_id" name="user_id"/>
                    <input type="submit" class="btn btn-primary btn-lg" value="Yes"/>
                </form>
                <button class="btn btn-lg btn-primary" data-dismiss="modal">No</button>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<!-- END offer job modal -->
    
<!-- offer all job confirmation modal -->
<div class="modal fade" id="offer_all_job_modal" tabindex="-1" role="dialog" aria-labelledby="offerAllJobModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    
            </div>
            <div class="modal-body payment-mode text-center">
                
                <h4>Offer all applicants the job?</h4>
                <form action="/OfferAllJobServlet" method="POST" class="display-inline">
                    <input type="hidden" name="post_id" id="offer_all_post_id"/>
                    <input type="hidden" name="user_ids" value="<%=applicantListUID%>" />
                    <button class="btn btn-lg btn-primary"><span class="badge"><%=applicantList.size()%></span> Offer All </button>
                </form>
                <button class="btn btn-lg btn-primary" data-dismiss="modal">No</button>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<!-- END offer all job modal -->
    
<!-- Mark as Complete Modal -->
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
                
                <h4>Leave a comment</h4>
                    
                <textarea class="form-control" style="min-width: 100%"></textarea>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Submit</button>
            </div>
        </div>
    </div>
</div>
    
<script>
    
    $(document).on("click", ".btn-comment", function() {
        $('#commentModal').modal('show');
    });
    
    $(document).on("click", "button", function(e){
        e.stopPropagation();
    });
    
    $(document).on("click", "input", function(e){
        e.stopPropagation();
    });
    
    $(document).on("click", "span", function(e){
        e.stopPropagation();
    });
</script>
<!-- End of Hire Modal -->
    
    
<script>
    
    $(document).on("click", ".btn-rate", function() {
        
        var scores = new Array();
        $('.score').each(function() {
            var id = this.id;
            var currentScore = $(this).raty('score');
            scores.push(id+":"+currentScore);
            
        });
        console.log(scores);
        
    });
</script>
    
    
<script>
    $(document).on("click", ".expire-post", function(){
        var expireURL = $(this).data('expireurl');
        $.ajax({
            url: expireURL,
            success: function(doc) {
                window.location.href = "/dashboard.jsp";
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.log(textStatus, errorThrown);
            }
        });
    });
</script>

    
<jsp:include page="_javascript_checker.jsp" />
<jsp:include page="_anchor.jsp" />
<jsp:include page="_footer.jsp" />