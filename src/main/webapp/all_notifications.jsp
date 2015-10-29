<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>

<%@include file="_job_details.jsp"%>
<%@include file="_only_registered.jsp"%>

<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.User"%>
<%@ page import="model.Notification"%>
<%@ page buffer="32kb" %>

<%
ArrayList <Notification> readList = (ArrayList <Notification>)session.getAttribute("readList");
ArrayList <Notification> unreadList = (ArrayList <Notification>)session.getAttribute("unreadList");

if (unreadList == null || readList == null){
%> <jsp:forward page="/GetNotificationsServlet?location=page" /><%
}

ArrayList <Notification> allNotifications = new ArrayList <Notification> ();
allNotifications.addAll(unreadList);
allNotifications.addAll(readList);

session.removeAttribute("readList");
session.removeAttribute("unreadList");
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

    <% if (currentUser.getAccountType().equals("job_seeker")){ %>
        <%@include file="_js_dashboard.jsp"%>
    <% } else { %>
        <%@include file="_emp_dashboard.jsp"%>
    <% } %>
<div>
    <a href="/mydashboard.jsp" class="btn btn-lg btn-warning btn-srad" type="button">Back to Dashboard</a>
</div>

</div>

</div>
</header>
<jsp:include page="_footer.jsp" />