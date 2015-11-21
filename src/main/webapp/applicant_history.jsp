<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>
<%@include file="_only_emp.jsp"%>
<jsp:include page="_user_profile.jsp" />

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="model.ApplicantHistory"%>
<%@ page import="model.User"%>
<%@ page import="model.Post"%>

<%@ page buffer="32kb" %>
<%  ArrayList <ApplicantHistory> applicantHistoryList = (ArrayList <ApplicantHistory>)session.getAttribute("applicantHistoryList"); 
    ArrayList <Post> postList = ((AppController)session.getAttribute("appController")).getPostController().getApplicableJobs();
    if (applicantHistoryList == null){ %>
        <jsp:forward page="/GetAllApplicantsServlet" />
<%  } else { 
        session.removeAttribute("applicantHistoryList");
    } %>

<header class="main">
<div class="header-full-content">
<%@include file="_message.jsp"%>
<div class="alert alert-success" role="alert" style="font-size: 14px;" hidden>
    <span class="glyphicon glyphicon-ok-sign" aria-hidden="true"></span>
    <strong id="message"></strong>
</div>
<div class="row">
<div class="col-md-8">
<div class="panel panel-default">


<div class="panel-heading"> 
    <h4>Your Applicant History </h4> 
</div> 

<table class="table table-users table-hover sortable"> 
<thead> 
    <tr>
        <th data-defaultsort='disabled'></th>
        <th>Name</th>
        <th>Ratings</th>
        <th>Status</th>
        <th data-defaultsort='disabled'>Action</th>
    </tr>
</thead>

<tbody>
    <% for (ApplicantHistory history : applicantHistoryList){ %>
    <% User user = history.getUser();
        HashMap <String, Integer> scoreMap = user.getScoreMap();
        String avatar = user.getAvatar();
        if (avatar == null){ avatar = "img/user-placeholder.jpg";}%>
    <tr class="open-profileModal" data-id="<%=user.getId()%>" data-name="<%= user.getUsername()%>" data-gender="<%=user.getGender()%>" data-nationality="<%=user.getNationality()%>" data-avatar="<%=user.getAvatar()%>" data-good="<%=user.getGoodRating()%>" data-neutral="<%=user.getNeutralRating()%>" data-bad="<%=user.getBadRating()%>" data-cleanup='<%=scoreMap.get("cleanUp")%>' data-ordertaking='<%=scoreMap.get("orderTaking")%>' data-barista='<%=scoreMap.get("barista")%>' data-selling='<%=scoreMap.get("selling")%>' data-kitchen='<%=scoreMap.get("kitchen")%>' data-bartender='<%=scoreMap.get("bartender")%>' data-service='<%=scoreMap.get("service")%>' data-cashier='<%=scoreMap.get("cashier")%>'>  
        <% if (history.isFavourite()){ %>
        <td class="text-center fav-star fav-star-selected">
        <% } else { %>
        <td class="text-center fav-star"><% } %>
            <i class="fa fa-star fa-lg"></i></td>
        <td>
            <img class="notification_content_profile img-rounded img-responsive text-right" src="<%=avatar%>"/>
            <div class="display-inline"><%=user.getUsername()%></div>
        </td>
        <td>
            <div class="ratings">
                <%=user.getGoodRating()%> <img src="/img/good.png" class="listing_ratings"/>
                <%=user.getNeutralRating()%> <img src="/img/neutral.png" class="listing_ratings"/>
                <%=user.getBadRating()%> <img src="/img/bad.png" class="listing_ratings"/>
            </div>
        </td>
        <td>
            <%=history.getStatus()%>
        </td>
        <td>
            <button class="btn btn-accept btn-srad col-md-6 dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Invite to Job 
                <i class="fa fa-arrow-circle-right"></i>
            </button>
            <ul class="dropdown-menu dropdown-menu-right invitejob-dropdown-menu">
                <li class="invitejob-dropdown-text">Select a job below to invite</li>
                <li role="separator" class="divider"></li>
                <% for (Post post : postList) { %>
                <li><a href="#" data-id="<%=post.getId()%>" class="post_id"><%=post.getHeader()%></a></li>
                <% } %>
            </ul>
        </td>
    </tr>
    <% } %>
</tbody>
</table>

</div> 
</div>

<%@include file="_emp_dashboard.jsp"%>
</div>

</div>
</header>
<jsp:include page="_anchor.jsp" />
<jsp:include page="_footer.jsp" />

<script>
    $(document).on("click", ".fav-star", function(e){
        e.stopPropagation();
        if ($(this).hasClass("fav-star-selected")){
            $(this).removeClass("fav-star-selected");
            var user_id = $(this).parent().data("id");
            $.ajax({
                url: "/UnfavouriteUserServlet",
                method: "POST",
                data: {
                    user_id: user_id
                },
                success: function(resultString) {
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.log(textStatus, errorThrown);
                }
            });
        } else {
            $(this).addClass("fav-star-selected");
            var user_id = $(this).parent().data("id");
            $.ajax({
                url: "/FavouriteUserServlet",
                method: "POST",
                data: {
                    user_id: user_id
                },
                success: function(resultString) {
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.log(textStatus, errorThrown);
                }
            });
        }
    });
    
    $(document).on("click", ".post_id", function(e){
        e.stopPropagation();
        var user_id = $(this).parent().parent().parent().parent().data("id");
        var username = $(this).parent().parent().parent().parent().data("name");
        var post_id = $(this).data("id");
        var post_name = $(this).html();
        $.ajax({
            url: "/SendNotificationServlet",
            method: "POST",
            data: {
                user_id: user_id,
                type: "job_invitation",
                post_id: post_id,
                username: username,
                post_name: post_name
            },
            success: function(resultString) {
                $("#message").html(resultString);
                $("#message").parent().show();
                $(".dropdown-menu").hide();
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.log(textStatus, errorThrown);
            }
        });
    });
</script>