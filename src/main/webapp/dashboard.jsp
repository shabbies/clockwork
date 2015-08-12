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
                                    <td><span class="badge db-default-badge">No Applicants</span></td>
                                    <td><a href="<%=redirectURL%>" class="btn btn-warning">Edit Job</a></td>
                                <% } else if (post.getStatus().equals("applied")){%>
                                    <td><span class="badge db-default-badge">Ongoing</span></td>
                                    <td><a href="/listing.jsp" class="btn btn-primary"> <span class="badge">4</span> Click to Hire</a></td>
                                <% } else { %>
                                    <td><span class="badge db-default-badge">Completed</span></td>
                                    <td><a href="/listing.jsp?completed=true" class="btn btn-success"> Click to Review</a></td>
                                <%}%>
                            </tr>
                            <%}%>
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
                            <img src="http://placehold.it/120x120" alt="" class="db-user-pic col-centered img-rounded img-responsive" />
                        </div>

                        <div class="db-user-info">
                            <h2>Hi <%=currentUser.getUsername()%>!</h2> 
                            <span>What would you like to do today?</span>
                        </div>
                        <a href="/edit_profile.jsp" class="btn btn-primary btn-block"><i class="fa fa-fw fa-plus"></i> Complete my Profile</a>
                    </div>
                </div>
            </div>
        </div>

    </div>
</header>
<jsp:include page="_footer.jsp" />