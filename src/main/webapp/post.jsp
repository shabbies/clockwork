<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>

<%@ page import="model.User"%>
<%@ page import="model.Post"%>

<header class="main">
<div class="header-full-content">
<div class="header-content-inner">

<%  String postID = request.getParameter("id");
    String formURL = "/GetPostServlet?id=" + postID + "&location=post";
    Post post = (Post)session.getAttribute("post");
    if (post == null){%>
        <jsp:forward page="<%=formURL%>" />
    <%} else { 
        session.removeAttribute("post");
    }%>
    <%@include file="_message.jsp"%>

<h2 class="text-center"><strong><%=post.getHeader()%></strong> @ <%=post.getCompany()%></h2>

<div class="row">
<div class="col-md-12">
<div class="panel panel-default">
<div class="panel-body  grey">
    
<div class="col-md-7 modal-job-details">
    <div class="col-md-4 text-center">
        <% if (post.getAvatarPath() == null) { %>
        <img src="img/user-placeholder.jpg" alt="" class="db-user-pic img-rounded img-responsive"/>
        <% } else { %>
        <img src="<%=post.getAvatarPath()%>" alt="" class="db-user-pic img-rounded img-responsive"/>
        <% } %>
        <h2 id="modalSalary">$<%=post.getSalary()%> / hr</h2>
    </div>

    <div class="col-md-8 text-left">
        <h5 class="col-md-12 col-lg-12" id="modalHeader"><strong><%=post.getHeader()%></strong></h5>
        <h5 class="col-md-12" id="modalCompany"><%=post.getCompany()%></h5>
        <strong class="col-md-4">Location</strong><h5 class="col-md-8" id="modalLocation"><%=post.getLocation()%></h5>
        <strong class="col-md-4">Start Date</strong><h5 class="col-md-8" id="modalDatePosted"><%=post.getJobDateString()%></h5>
        <strong class="col-md-4">End Date</strong><h5 class="col-md-8" id="modalEndDate"><%=post.getEndDateString()%></h5>
        <strong class="col-md-4">Timing</strong>
        <div class="col-md-8">
            <h5 id="modalStartTime" class="display-inline"><%=post.getStartTime()%></h5>
            <div id="modal_date_splitter" class="display-inline" >    to    </div>
            <h5 id="modalEndTime" class="display-inline"><%=post.getEndTime()%></h5>
        </div>
        <strong class="col-md-12 text-center" style="padding-top: 10px; padding-bottom: 10px;">Job Description</strong>
        <pre><%=post.getDescription()%></pre>
    </div>
</div>
<div class="col-md-5 modal-job-calendar">
    <h4><strong>Schedule for the Month</strong></h4>
    <div id="calendar"></div>
    <h6><span class="label label-default bg-primary">Job Date</span>
        <%  if(currentUser!=null && currentUser.getAccountType().equals("job_seeker")){ %>
        <span class="label label-apply">Your Applied Jobs</span>
        <span class="label label-hire">Your Hired Jobs</span>
        <% } %>
    </h6>
</div>
    
<div class="col-md-12">
<div class="col-md-1">
    <div><button type="button" id="facebook_share" class="btn btn-facebook btn-lg">Share on Facebook</button></div>
</div>
<div class="col-md-11">
    <form action="/ApplyJobServlet" method="POST" class="display-inline"/>
    <input type="text" value="<%=post.getId()%>" name="post_id" hidden />
    <input type="submit" class="btn btn-primary btn-lg" value="Apply For Job"/>
    </form>
    <button type="button" class="btn btn-warning btn-lg hidden">Edit Job</button>
</div>
</div>


</div>
</div>
</div>
</div>


</div>
</div>
</header>


<script>

    $(document).ready(function() {
        
        $('#calendar').fullCalendar({
            editable: false,
            allDayDefault: true,
            contentHeight: 400,
            titleFormat: 'MMMM',
            eventColor: 'grey',
            events: function(start, end, timezone, callback) {
                <% if (currentUser != null){ %>
                $.ajax({
                    url: 'https://clockwork-api.herokuapp.com/api/v1/users/get_calendar_formatted_dates.json',
                    dataType: 'json',
                    data: {
                        id: <%=currentUser.getId()%>
                    },
                    success: function(doc) {
                        var events = [];
                        obj = JSON.parse(doc);
                        $(obj).each(function() {
                            events.push({
                                title: $(this).attr('title'),
                                start: $(this).attr('job_date'), 
                                color: $(this).attr('color')
                            });
                        });
                        callback(events);
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        console.log(textStatus, errorThrown);
                    }
                });
                <% } %>
            },
            eventAfterRender: function(event, element, view) {
                $(element).css('height','30px');
                $(element).css('font-weight','700');
            }
        });
        

        $('#calendar').fullCalendar( 'gotoDate', new Date("<%=post.getJobDateStringForInput()%>"));

        var start_date = new Date("<%=post.getJobDateStringForInput()%>");
        var end_date = new Date("<%=post.getJobEndDateStringForInput()%>");
        start_date.setHours(0);
        while (start_date <= end_date){
            var myevent = {title: "<%=post.getHeader()%>", start: start_date.toString(), color: '#ee4054'};
            $('#calendar').fullCalendar( 'renderEvent', myevent, true);
            start_date.setDate(start_date.getDate() + 1);
        }
    });

$(document).on("click", "#facebook_share", function(e){
    var left = (screen.width - 600) / 2;
    var top = (screen.height - 300) / 4; 
    var host = window.location.origin.toString();
    window.open("http://www.facebook.com/sharer/sharer.php?u=" + host + "/post.jsp?id=" + <%=postID%>, "Share on Facebook!", "menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=300,width=600,top=" + top + ",left=" + left);
});
</script>

<jsp:include page="_anchor.jsp" />
<jsp:include page="_footer.jsp" />
