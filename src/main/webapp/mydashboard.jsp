<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>
<%@include file="_job_details.jsp"%>
    
<%@ page import="java.util.HashMap" %>
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

boolean appliedJob = true;    
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
<%session.removeAttribute("message");}%>
    
    
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
                    <%  String jobEditStyle = "", jobStyle = "", jobEditColor = "", ownjob = "", currentuserid="";
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
                        <td>
                            <form action="/WithdrawJobApplicationServlet" method="POST" class="display-inline"/>
                            <input type="text" value="<%=post.getId()%>" name="post_id" hidden />
                            <input type="submit" class="btn btn-primary" value="Withdraw"/>
                            </form>
                        </td>
                        <% } else if ((appliedJobsStatusMap.get(post.getId()).equals("offered"))){ %>
                        <td><span class="badge db-default-badge">Offered</span></td>
                        <td>
                            <form action="/AcceptJobOfferServlet" method="POST" class="display-inline"/>
                            <input type="hidden" value="<%=post.getId()%>" name="post_id" />
                            <input type="submit" class="btn btn-success" value="Accept Job Offer"/>
                            </form>
                        </td>
                        <% } else if ((appliedJobsStatusMap.get(post.getId()).equals("completed"))){ %>
                        <td><span class="badge db-default-badge complete">Completed</span></td>
                        <td>
                            <a href="#" class="btn btn-info">View Ratings</a>
                        </td>
                        <% } else {%>
                        <td><span class="badge db-default-badge success">Hired</span></td>
                        <td><button class="btn btn-warning" id="open-jobModal" data-userid="<%= currentuserid %>" data-jobstatus="<%= post.getStatus() %>" data-ownjob="<%= ownjob %>" data-header="<%= post.getHeader()%>" data-desc="<%=post.getDescription()%>" data-salary="$<%=post.getSalary()%>/hr" data-company="<%=post.getCompany()%>" data-location="<%=post.getLocation()%>" data-dateposted="<%=post.getJobDateString()%>" data-cdate="<%=post.getJobDateStringForInput()%>" data-id="<%=post.getId()%>" data-applied="true">Job Details</button></td>
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
                <h4 data-toggle="collapse" data-target="#pastJobs" aria-expanded="true" class="cursorpointer">Past Jobs</h4>
            </div>
            <div id="pastJobs" class="panel-collapse collapse" aria-expanded="true">
                <table class="table db-job-table"> 

                    <thead> 
                        <tr> 
                            <th>Job</th>
                            <th>Company</th>
                            <th>Status</th>
                        </tr>
                    </thead>

                    <tbody> 
                        <tr> 
                            <td>Bellboy</td>
                            <td>ABC Company</td>
                            <td><span class="badge db-default-badge success">Completed</span></td>
                        </tr>
                        <tr> 
                            <td>Bellboy</td>
                            <td>CDE Company</td>
                            <td><span class="badge db-default-badge success">Completed</span></td>

                        </tr>
                    </tbody>

                </table>
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
                    <span>What would you like to do today?</span>
                </div>
                <%if (currentUser.getContactNumber() == 0 || currentUser.getDateOfBirth() == null || currentUser.getGender() == '\u0000' || currentUser.getNationality() == null){%>
                <a href="/complete_profile.jsp" class="btn btn-primary btn-block"><i class="fa fa-fw fa-plus"></i> Complete my Profile</a>
                <% } else { %> 
                <a href="/edit_profile.jsp" class="btn btn-primary btn-block"><i class="fa fa-fw fa-plus"></i> Update my Profile</a><% } %>
            </div>
        </div>
    </div>
</div>

</div>
</header>
<jsp:include page="_footer.jsp" />