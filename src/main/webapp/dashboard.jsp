<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>
<%@include file="_only_emp.jsp"%>

<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Post"%>

<%@include file="_job_details.jsp"%>
<%@ page buffer="32kb" %>
<%  
ArrayList <Post> publishedList = (ArrayList <Post>)session.getAttribute("publishedList"); 
if (publishedList == null){ %>
<jsp:forward page="/GetAllListedJobsServlet" />
<%} else { 
session.removeAttribute("publishedList");
}%>

<header class="main">
    <div class="header-full-content">
        <%@include file="_message.jsp"%>

        <div class="row">
            <div class="col-md-8">
                <div class="panel panel-default">


                    <div class="panel-heading"> 
                        <h4>Your Job Listings</h4> 
                    </div> 

                    <table class="table db-job-table table-hover"> 

                        <thead> 
                            <tr> 
                                <th>Job</th>
                                <th class="hidden-xs">Date</th>
                                <th class="hidden-xs">Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>

                        <tbody>
                            <% for (Post post : publishedList){%>
                            <%  String salary = "" + post.getSalary();
                                if (post.getPayType().equals("hour")){
                                    salary += " / hr";
                                } else {
                                    salary += " / day";
                                }%>
                            <tr class="open-job-modal" data-userid="0" data-jobstatus="<%= post.getStatus() %>" data-ownjob="" data-header="<%= post.getHeader()%>" data-desc="<%=post.getDescription()%>" data-salary="$<%=salary%>" data-company="<%=post.getCompany()%>" data-location="<%=post.getLocation()%>" data-dateposted="<%=post.getJobDateString()%>" data-enddate="<%=post.getEndDateString()%>" data-cdate="<%=post.getJobDateStringForInput()%>" data-id="<%=post.getId()%>" data-applied="true" data-avatar="<%=post.getAvatarPath()%>" data-starttime="<%=post.getStartTime()%>" data-endtime="<%=post.getEndTime()%>" data-cdateend="<%=post.getJobEndDateStringForInput()%>"> 
                                <td><%=post.getHeader()%></td>
                                <td class="hidden-xs"><%=post.getJobDateString()%></td>   
                                <% if (post.getStatus().equals("listed")){
                                    String redirectURL = "/edit_post.jsp?id=" + post.getId(); %>
                                    <td class="hidden-xs"><span class="badge db-default-badge">No Applicant</span></td>
                                    <td><a href="<%=redirectURL%>" class="btn btn-warning">Edit Job</a></td>
                                <% } else if (post.getStatus().equals("applied")) {
                                    String redirectURL = "GetPostServlet?id=" + post.getId() + "&location=listing"; %>
                                    <td class="hidden-xs"><span class="badge db-default-badge">Hiring</span></td>
                                    <% int appCount = post.getApplicantCount(); 
                                    if(appCount > 0) { 
                                        if (appCount == 1){%>
                                            <td><a href="<%=redirectURL%>" class="btn btn-primary"> <span class="badge"><%=post.getApplicantCount()%></span> Applicant</a></td>
                                            <% } else { %>
                                                <td><a href="<%=redirectURL%>" class="btn btn-primary"> <span class="badge"><%=post.getApplicantCount()%></span> Applicants</a></td>
                                            <% } %>
                                    <% } else { %>
                                        <td><a href="<%=redirectURL%>" class="btn btn-primary"> Click to View</a></td>
                                    <% } %>
                                <% } else if (post.getStatus().equals("expired")){ %>
                                    <td class="hidden-xs"><span class="badge db-default-badge">Expired</span></td>
                                    <td><button class="btn btn-danger incomplete" disabled> Archive</button></td>
                                <% } else if (post.getStatus().equals("reviewing")){ %>
                                    <td class="hidden-xs"><span class="badge db-default-badge">Pending Review</span></td>
                                    <% String formedURL = "review_applicants.jsp?id=" + post.getId();%>
                                    <td><a href="<%=formedURL%>" class="btn btn-info"> Rate Applicants</a></td> 
                                <% } else if (post.getStatus().equals("ongoing")){%>    
                                    <td class="hidden-xs"><span class="badge db-default-badge">Ongoing</span></td>
                                    <% String formedURL = "manage_workers.jsp?id=" + post.getId();%>
                                    <td><a href="<%=formedURL%>" class="btn btn-facebook"> Manage</a></td> 
                                <% } else {%>
                                    <td class="hidden-xs"><span class="badge db-default-badge">Completed</span></td>
                                    <% String formedURL = "complete_job.jsp?id=" + post.getId();%>
                                    <td><a href="<%=formedURL%>" class="btn btn-success"> View Feedback</a></td>
                                <% } %>
                            </tr>
                            <%}%>
                            <% if(publishedList.isEmpty()){ %>
                            <tr class="text-center"><td colspan="4">You have not created any jobs</td></tr>
                            <% } %>
                            
                        </tbody>
                    </table>

                    <div>
                        <a href="/create_post.jsp" class="btn btn-primary"><i class="fa fa-fw fa-plus"></i> Post a new Job</a>
                    </div>
                </div> 
            </div>

            <%@include file="_emp_dashboard.jsp"%>
        </div>

    </div>
</header>
<jsp:include page="_anchor.jsp" />
<jsp:include page="_footer.jsp" />
