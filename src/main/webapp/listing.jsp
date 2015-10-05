<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>
<jsp:include page="_user_profile.jsp" />
    
<%@ page import="model.User"%>
<%@ page import="model.Post"%>
<%@ page import="java.util.ArrayList" %>
<%@ page buffer="16kb" %>
<%  String postID = request.getParameter("id");
appController = (AppController)session.getAttribute("appController");
ArrayList <User> applicantList = (ArrayList <User>)session.getAttribute("applicantList");
ArrayList <User> offeredList = (ArrayList <User>)session.getAttribute("offeredList");
ArrayList <User> hiredList = (ArrayList <User>)session.getAttribute("hiredList");
ArrayList <Integer> applicantListUID = new ArrayList <Integer> ();
String formURL = "/GetPostServlet?id=" + postID + "&location=listing";
Post post = (Post)session.getAttribute("post");
if (post == null){ %>
<jsp:forward page="<%=formURL%>" />
<% } else { 
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
        <div class="panel-body db-user">
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
</div>


<div class="col-md-8">
    <div class="panel panel-default">
        <div class="panel-heading"> 
            <h4>Your Applicants</h4> 
        </div> 
        <table class="table db-job-table"> 
            <thead> 
                <tr> 
                    <th>Name</th>
                    <th>Rating</th>
                    <th>Status</th>
                    <th>Action</th>
                    <th></th>
                </tr>
            </thead>
            <tbody> 
                <%  if (applicantList != null){
                        if (applicantList.size() > 0){   
                            for (User user : applicantList){ 
                                applicantListUID.add(user.getId());%>
                <tr> 
                    <td><%=user.getUsername()%></td>
                    <td>
                        <div class="ratings">
                            <%=user.getGoodRating()%> <img src="/img/good.png" class="listing_ratings"/>
                            <%=user.getNeutralRating()%> <img src="/img/neutral.png" class="listing_ratings"/>
                            <%=user.getBadRating()%> <img src="/img/bad.png" class="listing_ratings"/>
                        </div>
                    </td>
                    <td>Pending</td>
                    <td><button id="open_offer_job_modal" class="btn btn-success" data-postid="<%=postID%>" data-userid="<%=user.getId()%>">Offer Job</button>
                    </td>
                    <td><a href="#" id="view_profile" class="btn btn-warning open-profileModal" data-name="<%= user.getUsername()%>" data-avatar="<%=user.getAvatar()%>" data-good="<%=user.getGoodRating()%>" data-neutral="<%=user.getNeutralRating()%>" data-bad="<%=user.getBadRating()%>">View Profile</a></td>
                </tr>
                <% } %>
                <% if (applicantList.size() > 0) { %>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td><button class="btn btn-lg btn-primary" id="open_offer_all_job_modal" data-postid="<%=post.getId()%>"><span class="badge"><%=applicantList.size()%></span> Offer All </button></td>
                    <td>
                </tr>
                <%}%>
                <% } else { %>
                <tr><td colspan="4" class="text-center">No New Applicants</td></tr>
                <% } %>
                <% } %>    
            </tbody>

        </table>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading"> 
            <h4>Your Offered Applicants</h4> 
        </div> 
        <table class="table db-job-table"> 
            <thead> 
                <tr> 
                    <th>Name</th>
                    <th>Rating</th>
                    <th>Status</th>
                    <th>Action</th>
                    <th></th>
                </tr>
            </thead>
            <tbody> 

                <% if (offeredList != null){ %>
                <% if (offeredList.size() > 0) {%>
                <% for (User user : offeredList){ %>

                <tr> 
                    <td><%=user.getUsername()%></td>
                    <td>
                        <div class="ratings">
                            <%=user.getGoodRating()%> <img src="/img/good.png" class="listing_ratings"/>
                            <%=user.getNeutralRating()%> <img src="/img/neutral.png" class="listing_ratings"/>
                            <%=user.getBadRating()%> <img src="/img/bad.png" class="listing_ratings"/>
                        </div>
                    </td>
                    <td>Offered</td>
                    <td><form action="/WithdrawOfferServlet" method="POST" class="display-inline">
                            <input type="hidden" name="post_id" value="<%=postID%>" />
                            <input type="hidden" name="user_id" value="<%=user.getId()%>" />
                            <input type="submit" value="Withdraw Offer" class="btn btn-danger" />
                        </form>
                    </td>
                    <td><a href="#" id="hire_button" class="btn btn-warning open-profileModal" data-name="<%= user.getUsername()%>" data-avatar="<%=user.getAvatar()%>" data-good="<%=user.getGoodRating()%>" data-neutral="<%=user.getNeutralRating()%>" data-bad="<%=user.getBadRating()%>">View Profile</a></td>
                </tr>
                <% } %>
                <% } else { %>
                <tr><td colspan="4" class="text-center">No Offers Given</td></tr>
                <% }
        } %>
            </tbody>

        </table>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading"> 
            <h4>Your Hired Applicants</h4> 
        </div> 
        <table class="table db-job-table"> 
            <thead> 
                <tr> 
                    <th>Name</th>
                    <th>Rating</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>

            <tbody> 
                <% if (hiredList != null){ %>
                <% if (hiredList.size() > 0){ %>
                <% for (User user : hiredList){ %>

                <tr> 
                    <td><%=user.getUsername()%></td>
                    <td>
                        <div class="ratings">
                            <%=user.getGoodRating()%> <img src="/img/good.png" class="listing_ratings"/>
                            <%=user.getNeutralRating()%> <img src="/img/neutral.png" class="listing_ratings"/>
                            <%=user.getBadRating()%> <img src="/img/bad.png" class="listing_ratings"/>
                        </div>
                    </td>
                    <td>Hired</td>
                    <td><a href="#" id="hire_button" class="btn btn-warning open-profileModal" data-name="<%= user.getUsername()%>" data-email="<%= user.getEmail()%>" data-contact="<%= String.valueOf(user.getContactNumber())%>" data-avatar="<%=user.getAvatar()%>" data-good="<%=user.getGoodRating()%>" data-neutral="<%=user.getNeutralRating()%>" data-bad="<%=user.getBadRating()%>">View Profile</a></td>
                </tr>
                <% } %>
                <% } else { %>
                <tr><td colspan="4" class="text-center">No Hired Applicants</td></tr>
                <% } %>
                <% } %>
            </tbody>

        </table>
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
<jsp:include page="_footer.jsp" />