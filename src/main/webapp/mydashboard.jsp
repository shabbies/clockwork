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
session.setAttribute("error", "Only a job seeker account can view job applications!");
response.sendRedirect("/index.jsp");
return;}

ArrayList <Post> completedJobs = new ArrayList <Post> ();
HashMap <Integer, Post> appliedJobsMap = (HashMap <Integer, Post>)session.getAttribute("appliedJobsMap"); 
HashMap <Integer, String> appliedJobsStatusMap = (HashMap <Integer, String>)session.getAttribute("appliedJobsStatusMap"); 
if (appliedJobsMap == null || appliedJobsStatusMap == null){ %>
<jsp:forward page="/GetAppliedJobsServlet" />
<%} else { 
session.removeAttribute("appliedJobsMap");
session.removeAttribute("appliedJobsStatusMap");
}%>
<header class="main">
<div class="header-full-content">
    
<%@include file="_message.jsp"%>
    
<div class="row">
    <div class="col-md-8">
        <div class="panel panel-default">
            <div class="panel-heading"> 
                <h4>Jobs you have applied for</h4> 
            </div> 

            <table class="table db-job-table"> 

                <thead> 
                    <tr> 
                        <th>Job</th>
                        <th>Company</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>

                <tbody> 
                    <% for (Post post : appliedJobsMap.values()) { %>
                    <%  if (appliedJobsStatusMap.get(post.getId()).equals("completed")){
                            completedJobs.add(post);
                            continue;
                        }
                        String jobEditStyle = "", jobStyle = "", jobEditColor = "", ownjob = "", currentuserid="";
                        if(currentUser != null){
                            currentuserid = String.valueOf(currentUser.getId());
                                if(currentUser.getUsername().equals(post.getCompany())){
                                jobEditStyle =  "job-edit";
                                jobStyle =  "job-entry-edit";
                                jobEditColor = "job-edit-color";
                                ownjob = "true";
                            }
                        } %> 
                    <tr> 
                        <td><%=post.getHeader()%></td>
                        <td><%=post.getCompany()%></td>
                        <% if (appliedJobsStatusMap.get(post.getId()).equals("pending")) {%>
                        <td><span class="badge db-default-badge">Pending</span></td>
                        <td><input type="button" class="btn btn-primary withdraw-job" data-postid="<%=post.getId()%>" value="Withdraw"/></td>
                        <% } else if ((appliedJobsStatusMap.get(post.getId()).equals("offered"))){ %>
                        <td><span class="badge db-default-badge offered">Offered</span></td>
                        <td><input type="button" class="btn btn-success accept-job" data-postid="<%=post.getId()%>" value="Accept Job Offer"/></td>
                        <% } else {%>
                        <td><span class="badge db-default-badge success">Hired</span></td>
                        <td><button class="btn btn-warning" id="open-jobModal" data-userid="<%= currentuserid %>" data-jobstatus="<%= post.getStatus() %>" data-ownjob="<%= ownjob %>" data-header="<%= post.getHeader()%>" data-desc="<%=post.getDescription()%>" data-salary="$<%=post.getSalary()%>/hr" data-company="<%=post.getCompany()%>" data-location="<%=post.getLocation()%>" data-dateposted="<%=post.getJobDateString()%>" data-enddate="<%=post.getEndDateString()%>" data-cdate="<%=post.getJobDateStringForInput()%>" data-id="<%=post.getId()%>" data-applied="true" data-avatar="<%=post.getAvatarPath()%>" data-starttime="<%=post.getStartTime()%>" data-endtime="<%=post.getEndTime()%>">Job Details</button></td>
                        <% } %>
                    </tr>
                    <%}
                if(appliedJobsMap.isEmpty()){ %>
                    <tr class="text-center"><td colspan="4">You have not applied for any jobs</td></tr>
                    <% } %>
                    %>
                </tbody>
            </table>

            <div>
                <a href="/index.jsp" class="btn btn-primary"><i class="fa fa-fw fa-plus"></i> Search for a Job</a>
            </div>
        </div> 

        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 data-toggle="collapse" data-target="#pastJobs" aria-expanded="true" class="cursorpointer">Completed Jobs</h4>
            </div>
            <div id="pastJobs" class="panel-collapse" aria-expanded="true">
                <% if (!completedJobs.isEmpty()){ %>
                <table class="table db-job-table"> 

                    <thead> 
                        <tr> 
                            <th>Job</th>
                            <th>Company</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>

                    <tbody>  
                        <% for (Post post : completedJobs){%>
                        <tr>
                            <td><%=post.getHeader()%></td>
                            <td><%=post.getCompany()%></td>
                            <td><span class="badge db-default-badge complete">Completed</span></td>
                            <td>
                                <button class="btn btn-info" id="open-ratingsModal" data-header="<%=post.getHeader()%>" data-company="<%=post.getCompany()%>" data-rating="<%=post.getRating()%>" data-comment="<%=post.getComment()%>">View Ratings</button>
                            </td>
                        </tr>
                        <%}%>
                    </tbody>

                </table>
                <% } else { %>
                <p style="color:black; padding-top: 10px;">You have not completed any jobs! Try finishing a job first!</p>
                <% } %>
            </div>
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
                <a href="#" class="btn btn-primary btn-block incomplete"><i class="fa fa-fw fa-star"></i> View my Ratings</a>
                <a href="#" class="btn btn-primary btn-block incomplete"><i class="fa fa-fw fa-book"></i> View my Achived Jobs</a>
            </div>
        </div>
    </div>
</div>

</div>
</header>
<jsp:include page="_footer.jsp" />

<script>
    $(document).on("click", "#open-ratingsModal", function() {
        var header = $(this).data('header');
        var company = $(this).data('company');
        var rating = $(this).data('rating');
        var comment = $(this).data('comment');
        
        $("#company_name").html(company);
        $("#job_name").html(header);
        $("#comments").html(comment);
        
        if (rating === 2){
            $("#job_rating").attr("hidden", "hidden");
            $("#comments").attr("hidden", "hidden");
            $("#no_comments").attr("hidden", "hidden");
            $("#no_rating").removeAttr("hidden");
        } else {
            $("no_rating").attr("hidden", "hidden");
            $("#no_comments").attr("hidden", "hidden");
            $("#no_rating").attr("hidden", "hidden");
            $("#comments").removeAttr("hidden");
            $("#job_rating").removeAttr("hidden");
            if (comment === null){
                $("#no_comments").removeAttr("hidden");
            }
            if (rating === -1){
                $("#job_rating").attr("src", "img/bad.png");
            } else if (rating === 0){
                $("#job_rating").attr("src", "img/neutral.png");
            } else {
                $("#job_rating").attr("src", "img/good.png");
            }
        }
        
        $("#ratingModal").modal("show");
    });
</script>

<!-- Ratings Modal -->
<div class="modal fade" id="ratingModal" tabindex="-1" role="dialog" aria-labelledby="ratingModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    
            </div>
            <div class="modal-body payment-mode text-center">
                
                <h4>Below are your ratings for this job</h4>
                    
                <p><strong id="company_name">Company Name</strong></p>
                <p><strong id="job_name">Job Name</strong></p>
                
                <p><img src="img/bad.png" id="job_rating" /></p>
                <p id="comments"> This is bad </p>
                <p id="no_comments" hidden="hidden"> You did not receive any comments </p>
                <p id="no_rating" hidden="hidden"> You have not received any ratings yet! </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!-- withdraw job confirmation modal -->
<div class="modal fade" id="withdraw_job_modal" tabindex="-1" role="dialog" aria-labelledby="withdrawJobModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    
            </div>
            <div class="modal-body payment-mode text-center">
                
                <h4>Withdraw this job application?</h4>
                    
                <form action="/WithdrawJobApplicationServlet" method="POST" class="display-inline"/>
                    <input type="text" id="withdraw_post_id" value="" name="post_id" hidden />
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
<!-- END withdraw job modal -->

<!-- accept job confirmation modal -->
<div class="modal fade" id="accept_job_modal" tabindex="-1" role="dialog" aria-labelledby="acceptJobModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    
            </div>
            <div class="modal-body payment-mode text-center">
                
                <h4>Accept this job application?</h4>
                    
                <form action="/AcceptJobOfferServlet" method="POST" class="display-inline"/>
                    <input type="hidden" id="accept_post_id" name="post_id" />
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
<!-- END withdraw job modal -->

<script>
$(".incomplete").click(function(){
    alert("Oops! This is not yet available!")
});

$(".withdraw-job").click(function(){
    var postID = $(this).data("postid");
    $("#withdraw_post_id").val(postID);
    $('#withdraw_job_modal').modal('show');
});

$(".accept-job").click(function(){
    var postID = $(this).data("postid");
    $("#accept_post_id").val(postID);
    $('#accept_job_modal').modal('show');
});
</script>