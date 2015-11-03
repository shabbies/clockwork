<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>
<%@include file="_only_js.jsp"%>

<%@include file="_job_details.jsp"%>
    
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="model.User"%>
<%@ page import="model.Post"%>
<%@ page buffer="32kb" %>

<%
HashMap <String, ArrayList <Post>> appliedJobsMap = (HashMap <String, ArrayList <Post>>)session.getAttribute("appliedJobsMap"); 
HashMap <Integer, String> appliedJobsStatusMap = (HashMap <Integer, String>)session.getAttribute("appliedJobsStatusMap"); 
ArrayList <Post> completedJobs = (ArrayList <Post>)session.getAttribute("completedJobsList");
if (appliedJobsMap == null || appliedJobsStatusMap == null || completedJobs == null){ %>
<jsp:forward page="/GetAppliedJobsServlet" />
<%} else { 
session.removeAttribute("appliedJobsMap");
session.removeAttribute("appliedJobsStatusMap");
session.getAttribute("completedJobsList");
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

            <table class="table db-job-table table-hover"> 

                <thead> 
                    <tr id="header-row"> 
                        <th>Job</th>
                        <th>Company</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>

                <tbody> 
                    <%  for (String status : appliedJobsMap.keySet()){
                            ArrayList <Post> postList = appliedJobsMap.get(status);
                            for (Post post : postList){
                                String jobEditStyle = "", jobStyle = "", jobEditColor = "", ownjob = "", currentuserid="";
                                if(currentUser != null){
                                    currentuserid = String.valueOf(currentUser.getId());
                                    if(currentUser.getUsername().equals(post.getCompany())){
                                        jobEditStyle =  "job-edit";
                                        jobStyle =  "job-entry-edit";
                                        jobEditColor = "job-edit-color";
                                        ownjob = "true";
                                    }
                                } 
                                String salary = "" + post.getSalary();
                                
                                if (post.getPayType().equals("hour")){
                                    salary += " / hr";
                                } else {
                                    salary += " / day";
                                } %>
                    <tr class="open-job-modal" data-userid="<%= currentuserid %>" data-jobstatus="<%= post.getStatus() %>" data-ownjob="<%= ownjob %>" data-header="<%= post.getHeader()%>" data-desc="<%=post.getDescription()%>" data-salary="$<%=salary%>" data-company="<%=post.getCompany()%>" data-location="<%=post.getLocation()%>" data-dateposted="<%=post.getJobDateString()%>" data-enddate="<%=post.getEndDateString()%>" data-cdate="<%=post.getJobDateStringForInput()%>" data-id="<%=post.getId()%>" data-applied="true" data-avatar="<%=post.getAvatarPath()%>" data-starttime="<%=post.getStartTime()%>" data-endtime="<%=post.getEndTime()%>" data-cdateend="<%=post.getJobEndDateStringForInput()%>"> 
                        <td><%=post.getHeader()%></td>
                        <td><%=post.getCompany()%></td>
                        <% if (status.equals("pending")) {%>
                            <td><span class="badge db-default-badge">Pending</span></td>
                            <td><a class="btn btn-primary withdraw-job" data-postid="<%=post.getId()%>">Withdraw</a></td>
                        <% } else if (status.equals("offered")){ %>
                            <td><span class="badge db-default-badge offered">Offered</span></td>
                            <td>
                                <div class="btn-group" role="group" aria-label="...">
                                    <a class="btn btn-accept accept-job" style="width: 75px;" data-postid="<%=post.getId()%>">Accept</a>
                                    <a class="btn btn-reject withdraw-job" style="width: 75px;" data-postid="<%=post.getId()%>">Reject</a>
                                </div>
                                <!--<a class="btn btn-success accept-job" data-postid="<%=post.getId()%>">Accept Job Offer</a>-->
                            </td>
                        <% } else {%>
                            <td><span class="badge db-default-badge success">Hired</span></td>
                            <td><button class="btn btn-warning" id="open-jobModal">Job Details</button></td>
                        <% } %>
                    </tr>  
                        <% }
                    }
                    if (appliedJobsMap.isEmpty()){ %>
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

    <%@include file="_js_dashboard.jsp"%>
</div>

</div>
</header>
<jsp:include page="_anchor.jsp" />
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
                <div id="drop-application" class="hidden">
                    <h4 class="drop-application-warning"><i class="fa fa-warning"></i> Warning!</h4>
                    <div>Accepting this job offer will cause the following applications to be dropped!</div>
                    <div id="drop-application-content">

                    </div>
                </div>
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
<!-- END accept job modal -->

<script>
$(".incomplete").click(function(){
    alert("Oops! This is not yet available!")
});

$(".withdraw-job").click(function(){
    var postID = $(this).data("postid");
    $("#withdraw_post_id").val(postID);
    $('#withdraw_job_modal').modal('show');
});

$(document).on("click", "button", function(e){
    if (!$(this).attr("id") === "open-jobModal"){
        e.stopPropagation();
    }
});

$(".accept-job").click(function(){
    var postID = $(this).data("postid");
    $.ajax({
        url: '/CheckJobDateClashServlet',
        dataType: 'json',
        method: "GET",
        data: {
            post_id: postID,
            type: "accept"
        },
        success: function(result) {
            if ((result.toString()) !== ""){
                $("#drop-application").removeClass("hidden");
                var formedHTML = "";
                result.forEach(function(element){
                   var key = Object.keys(element);
                   formedHTML += "<div><strong>" + element[key] + "</strong></div>"
                });
                $("#drop-application-content").html(formedHTML);
            } else {
                $("#drop-application").addClass("hidden");
            }
        },
        error: function(jqXHR, textStatus, errorThrown) {
          console.log(textStatus, errorThrown);
        }
    });
    $("#accept_post_id").val(postID);
    $('#accept_job_modal').modal('show');
});
</script>