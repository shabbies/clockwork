<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>

<%@include file="_job_details.jsp"%>
    
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.User"%>
<%@ page import="model.Notification"%>
<%@ page buffer="16kb" %>
<%
if (currentUser == null){
session.setAttribute("error", "Please login or register first before viewing your job notifications!");
response.sendRedirect("/login.jsp");
return;
}

ArrayList <Notification> readList = (ArrayList <Notification>)session.getAttribute("readList");
ArrayList <Notification> unreadList = (ArrayList <Notification>)session.getAttribute("unreadList");
ArrayList <Notification> allNotifications = new ArrayList <Notification> ();
allNotifications.addAll(unreadList);
allNotifications.addAll(readList);
%>
<header class="main">
<div class="header-full-content">
    
<%@include file="_message.jsp"%>
    
<div class="row">
    <div class="col-md-8">
        <div class="panel panel-default">
            <div class="panel-heading"> 
                <h4>Your Notifications</h4> 
            </div> 

            <table class="table db-job-table db-rating-table"> 

                <thead> 
                    <tr id="header-row"> 
                        <th col-span="2">Recent Notifications</th>
                    </tr>
                </thead>

                <tbody> 
                    <% for (Notification notification : allNotifications) { %>
                    <% String status = notification.getStatus();
                        String image = notification.getAvatarPath();
                        if (image == null){
                            image = "img/user-placeholder.jpg";}%>
                    <% if (status.equals("unread")){ %>
                        <tr class="danger">
                    <% } else { %>
                        <tr class="success">
                    <% } %>
                    <td><img class="col-md-1 notification_content_profile img-rounded img-responsive" src="<%=image%>"/><div class="col-md-11 display-inline"><%=notification.getContent()%></div></td>
                    </tr>
                    <% }
                    if (allNotifications.isEmpty()) { %>
                        <tr class="text-center"><td>You have no notifications!</td></tr>
                        <tr class="text-center">
                            <td>
                                <a href="/index.jsp" class="btn btn-primary"><i class="fa fa-fw fa-plus"></i> Find Job!</a>
                            </td>
                        </tr>
                    <% } %>
                    %>
                </tbody>
            </table>
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
                <a href="/all_ratings.jsp" class="btn btn-primary btn-block"><i class="fa fa-fw fa-star"></i> View my Ratings</a>
                <a href="#" class="btn btn-primary btn-block incomplete"><i class="fa fa-fw fa-book"></i> View my Achived Jobs</a>
            </div>
        </div>
    </div>
<div>
    <a href="/mydashboard.jsp" class="btn btn-lg btn-warning btn-srad" type="button">Back to Dashboard</a>
</div>

</div>

</div>
</header>
<jsp:include page="_footer.jsp" />