<%@include file="_header.jsp"%>

<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Post"%>
<%@ page import="java.util.Date"%>

<%  ArrayList <Post> postList = (ArrayList <Post>)session.getAttribute("postList"); 
if (postList == null){ %><jsp:forward page="/GetAllPostsServlet" /><%} else { session.removeAttribute("postList"); }%>

<%@include file="_nav.jsp"%>
<jsp:include page="_hero.jsp" />

<section id="jobs" ng-controller="jobListCtrl">
    <div class="job-search text-center">

        <div class="container">
            <form id="searchForm">
                <div class="input-group input-group-lg stylish-input-group">
                    <input type="text" class="form-control" id="searchText" autocomplete="off" placeholder="search keyword...">
                    <span class="input-group-btn">
                        <button class="btn btn-primary" type="button"> FIND JOBS <span class="glyphicon glyphicon-search"></span></button>
                    </span>
                </div>
            </form>
        </div>
    </div>
    <div class="container">

        <div class="col-lg-12 search-label"> 
            <h3 class="hidden">Search Results for "<span>goodie bag</span>"</h3>                             
        </div>

        <%for (Post post : postList){%>
        <%  Date jobDate = post.getJobDate(); 
        String jobDateString = jobDate.toString();
        %>

        <div class="col-lg-4">

            <% 
            String jobEditStyle = "", jobStyle = "", jobEditColor = "", ownjob = "", currentuserid="";
            
            if(currentUser!=null){
            currentuserid = String.valueOf(currentUser.getId());
            if(currentUser.getUsername().equals(post.getCompany())){
            jobEditStyle =  "job-edit";
            jobStyle =  "job-entry-edit";
            jobEditColor = "job-edit-color";
            ownjob = "true";
        }
    } 
    %> 

    <div class="job-entry <%=jobEditStyle%>">
        <div class="job-entry-desc">
            <div class="row">
                <div class="col-xs-9">
                    <h4><strong><%=post.getHeader()%></strong></h4>
                    <h5><%=post.getCompany()%>
                    </h5>
                    <h5>
                        <i class="fa fa-map-marker primary"></i> 
                        <%=post.getLocation()%>
                    </h5>
                </div>
                <span class="job-entry-price pull-right primary <%= jobEditColor %>"><strong>$<%=post.getSalary()%>/hr</strong></span>
            </div>

            <div class="row">
                <div class="col-xs-12">
                    <h5 class="font-normal"><%=post.getDescription()%></h5>
                </div>
            </div>
        </div>


        <div class="row job-entry-apply <%=jobStyle%>" id="open-jobModal" data-userid="<%= currentuserid %>" data-jobstatus="<%= post.getStatus() %>" data-ownjob="<%= ownjob %>" data-header="<%= post.getHeader()%>" data-desc="<%=post.getDescription()%>" data-salary="$<%=post.getSalary()%>/hr" data-company="<%=post.getCompany()%>" data-location="<%=post.getLocation()%>" data-dateposted="<%=post.getJobDateString()%>" data-cdate="<%=post.getJobDateStringForInput()%>" data-id="<%=post.getId()%>">
            <!--
            <div class="col-xs-6"> 
                <div class="detailIconsDiv">
                    <ul class="list-inline text-left">
                        <li class="detailIcons"><a href="#" class="whitelink"><i class="fa fa-dollar"></i></a></li>
                        <li class="detailIcons"><a href="#" class="whitelink"><i class="fa fa-cutlery"></i></a></li>
                        <li class="detailIcons"><a href="#" class="whitelink"><i class="fa fa-compass"></i></a></li>
                    </ul>
                </div>
            </div>
        -->

        <div class="col-xs-12">

            <% if(currentUser==null){ %>
            <a href="#"  class="btn btn-primary btnnohover pull-right">Apply now</a>
            <%} else { %>
            <% if(!currentUser.getUsername().equals(post.getCompany())){ 
            if(currentUser.getAccountType().equals("job_seeker")){%>

            <a href="#"  class="btn btn-primary btnnohover pull-right">Apply now</a>
            <% }else{ %>

            <%  } %>

            <% } else { 
            if(post.getStatus().equals("listed")){%>
            <a href="/edit_post.jsp?id=<%= post.getId() %>" class="btn btn-warning btnnohover pull-right">Edit Job</a>

            <% }
        } %>
        <% } %>

    </div>

</div>




</div>

</div>

<%}%>

</div>

</section>

<hr class="grey">
<footer>
    <div class="container">
        <div class="row">
            <div class="col-md-4 col-xs-4">
                <span class="copyright">Copyright © Clockwork 2015</span>
            </div>
            <div class="col-md-4 col-xs-4">
                <ul class="list-inline social-buttons text-center">
                    <li><a href="#"><i class="fa fa-twitter"></i></a>
                    </li>
                    <li><a href="#"><i class="fa fa-facebook"></i></a>
                    </li>
                    <li><a href="#"><i class="fa fa-linkedin"></i></a>
                    </li>
                </ul>
            </div>
            <div class="col-md-4 col-xs-4">
                <ul class="list-inline quicklinks pull-right">
                    <li><a href="#">Privacy Policy</a>
                    </li>
                    <li><a href="#">Terms of Use</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</footer>



<!-- Job Modal -->
<div class="modal fade" id="jobModal" tabindex="-1" role="dialog" aria-labelledby="jobModalLabel">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>

    </div>
    <div class="modal-body">

       <div class="col-md-7 modal-job-details">
           <div class="col-md-4 text-center">
            <img src="http://placehold.it/120x120" alt="" class="db-user-pic img-rounded img-responsive"/>
            
            <h2 id="modalSalary">$10/hr</h2>
        </div>

        <div class="col-md-8">
            <h4 id="modalHeader"><strong>Bellboy</strong> @ HardRock Hotel</h4>
            <h5 id="modalLocation">Resort World Singapore</h5>
            <h5 id="modalDatePosted">21/08/2015</h5>

            <h5 id="modalDesc">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Fuga repellat corrupti nam provident praesentium vel! Nobis vel distinctio deserunt similique, nemo, voluptate a rem excepturi cumque ut quam quia minima.</br></br>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Fuga repellat corrupti nam provident praesentium vel! Nobis vel distinctio deserunt similique, nemo, voluptate a rem excepturi cumque ut quam quia minima.
            </h5>
        </div>

    </div>

    <div class="col-md-5 modal-job-calendar">
        <h4><strong>Schedule for the Month</strong></h4>
        <div id="calendar"></div>
        <h6><span class="label label-default bg-primary">Company</span>
            <%  if(currentUser!=null && currentUser.getAccountType().equals("job_seeker")){ %>
            <span class="label label-default">Your Schedule</span></h6>
            <% } %>
        </div>
    </div>
    <div class="modal-footer">
       <div class="pull-right" style="padding-right: 15px;">
        <button type="button" class="btn btn-default btn-lg" data-dismiss="modal">Close</button>
        <form action="/ApplyJobServlet" method="POST" class="display-inline">
            <input type="text" id="hiddenJobID" hidden value="" name="post_id"/>
            <%  if(!(currentUser!=null && currentUser.getAccountType().equals("employer"))){ %>
            <input type="submit" class="btn btn-primary btn-lg" value="Apply for Job"/>
            <% } %>
        </form>
    </div>
</div>
</div>
</div>
</div>

<script>

$(document).on("click", "#open-jobModal", function() {
    if( $(this).data("ownjob") == ''){
        var headerText = $(this).data('header');
        var descText = $(this).data('desc');
        var salaryText = $(this).data('salary');
        var companyText = $(this).data('company');
        var locationText = $(this).data('location');
        var jobDateText = $(this).data("dateposted");
        var id = $(this).data("id");
        var uid = $(this).data("userid");

        $('#jobModalLabel').html(headerText);
        $('#modalHeader').html("<strong>"+headerText+"</strong>");
        $('#modalDesc').html(descText);
        $('#modalSalary').html(salaryText);
        $('#modalDesc').html(descText);
        $('#modalCompany').html(companyText);
        $('#modalLocation').html(" <i class=\"fa fa-map-marker primary\"></i> "+locationText);
        $('#modalDatePosted').html(jobDateText);
        $('#hiddenJobID').val(id);

        $('#calendar').fullCalendar( 'destroy' );

        $('#calendar').fullCalendar({
            editable: false,
            allDayDefault: true,
            contentHeight: 240,
            titleFormat: 'MMMM',
            eventColor: 'grey',
            events: 'https://clockwork-api.herokuapp.com/api/v1/users/get_calendar_formatted_dates.json?id='+uid,
            eventAfterRender: function(event, element, view) {
                $(element).css('height','30px');
                $(element).css('font-weight','700');
  }/*, eventRender: function (event, element, view) { 
        var dateString = event.start.format("YYYY-MM-DD");
        $(view.el[0]).find('.fc-day[data-date="' + dateString + '"]').css('background-color', '#ee4054');
    }*/

});

        var myevent = {title: headerText,start: new Date($(this).data("cdate")),color: '#ee4054'};
        $('#calendar').fullCalendar( 'renderEvent', myevent, true);

        $('#jobModal').modal('show');

    }else{
        var jobstatus = $(this).data('jobstatus');
        if(jobstatus=='listed'){
            window.location.href="/edit_post.jsp?id="+$(this).data("id");
        }
    }
});



$('#jobModal').on('shown.bs.modal', function () {

    $("#calendar").fullCalendar('render');
    $("#calendar").fullCalendar( 'rerenderEvents' );
});
</script>
<!-- End of Job Modal -->


<script>

$(document).ready(function() {



    $(".job-entry-desc").dotdotdot({
        /*  The text to add as ellipsis. */
        ellipsis    : '... ',
        /*  How to cut off the text/html: 'word'/'letter'/'children' */
        wrap        : 'word',
        /*  Wrap-option fallback to 'letter' for long words */
        fallbackToLetter: true,
        /*  jQuery-selector for the element to keep and put after the ellipsis. */
        after       : null,
        /*  Whether to update the ellipsis: true/'window' */
        watch       : false,
        /*  Optionally set a max-height, if null, the height will be measured. */
        height      : null,
        /*  Deviation for the height-option. */
        tolerance   : 0,
        /*  Callback function that is fired after the ellipsis is added,
        receives two parameters: isTruncated(boolean), orgContent(string). */
        callback    : function( isTruncated, orgContent ) {},
        lastCharacter   : {
            /*  Remove these characters from the end of the truncated text. */
            remove      : [ ' ', ',', ';', '.', '!', '?' ],
            /*  Don't add an ellipsis if this array contains 
            the last character of the truncated text. */
            noEllipsis  : []
        }
    });

});


$(function() {
    $('.job-entry').hover(function() {
        if($(this).hasClass("job-edit")){
            $(this).find(".job-entry-apply").css( "background-color", "#f0ad4e"); 
        }else{
            $(this).find(".job-entry-apply").css( "background-color", "#ee4054"); 
        }
        $(this).find("a").removeClass("whitelink"); 

    }, function() {
        $(this).find( ".job-entry-apply").css( "background-color", "") 
        $(this).find("a").addClass("whitelink"); 
    });
});

</script>


<jsp:include page="_footer.jsp" />






