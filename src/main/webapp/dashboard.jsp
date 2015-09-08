<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Post"%>

<%  
if (currentUser == null){
session.setAttribute("error", "Please login or register first before viewing your job applications!");
response.sendRedirect("/login.jsp");
return;
} else if (!currentUser.getAccountType().equals("employer")){
session.setAttribute("error", "Only employers can view job applications!");
response.sendRedirect("/index.jsp");
return;
}

ArrayList <Post> publishedList = (ArrayList <Post>)session.getAttribute("publishedList"); 
if (publishedList == null){ %>
<jsp:forward page="/GetAllListedJobsServlet" />
<%} else { 
session.removeAttribute("publishedList");
}       
if (currentUser == null){
session.setAttribute("error", "Please login or register first before viewing your job applications!");
response.sendRedirect("/login.jsp");
return;
} else if (!currentUser.getAccountType().equals("employer")){
session.setAttribute("error", "Only employers can view job applications!");
response.sendRedirect("/index.jsp");
return;
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
                        <h4>Your Job Listings</h4> 
                    </div> 

                    <table class="table db-job-table"> 

                        <thead> 
                            <tr> 
                                <th>Job</th>
                                <th>Date</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>

                        <tbody>
                            <% for (Post post : publishedList){%>
                            <tr> 
                                <td><%=post.getHeader()%></td>
                                <td><%=post.getJobDateString()%></td>
                                <% if (post.getStatus().equals("listed")){
                                    String redirectURL = "/edit_post.jsp?id=" + post.getId(); %>
                                    <td><span class="badge db-default-badge">No Applicant</span></td>
                                    <td><a href="<%=redirectURL%>" class="btn btn-warning">Edit Job</a></td>
                                <% } else if (post.getStatus().equals("applied")){
                                    String redirectURL = "/listing.jsp?id=" + post.getId(); %>
                                    <td><span class="badge db-default-badge">Ongoing</span></td>
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
                                    <td><span class="badge db-default-badge">Expired</span></td>
                                    <td><a href="#" class="btn btn-danger"> Archive</a></td>
                                <% } else { %>
                                    <td><span class="badge db-default-badge">Completed</span></td>
                                    <% String formedURL = "complete_job.jsp?id=" + post.getId();%>
                                    <td><a href="<%=formedURL%>" class="btn btn-success"> Click to Review</a></td>
                                <%}%>
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
                            <h2>Hi <%=currentUser.getUsername()%>!</h2> 
                            <span>What would you like to do today?</span>
                        </div>
                        <a href="/edit_profile.jsp" class="btn btn-primary btn-block"><i class="fa fa-fw fa-plus"></i> Update My Profile</a>
                        <a href="#" class="btn btn-primary btn-block incomplete"><i class="fa fa-fw fa-male"></i> View my past employees</a>
                        <a href="#" class="btn btn-primary btn-block incomplete"><i class="fa fa-fw fa-book"></i> View my Achived Jobs</a>
                    </div>
                </div>
            </div>
        </div>

    </div>
</header>
<jsp:include page="_footer.jsp" />

<script>
$(".incomplete").click(function(){
    alert("Oops! This is not yet available!")
});
</script>