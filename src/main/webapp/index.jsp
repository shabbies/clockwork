<jsp:include page="_header.jsp" />

<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Post"%>

<%  ArrayList <Post> postList = (ArrayList <Post>)session.getAttribute("postList"); 
if (postList == null){%><jsp:forward page="/GetAllPostsServlet" /><%}%>

<jsp:include page="_nav.jsp" />
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
            <h3>Search Results for "<span>goodie bag</span>"</h3>                             
        </div>

        <%for (Post post : postList){%>

        <div class="col-lg-4">

            <div class="job-entry">
                <div class="job-entry-desc">
                    <div class="row">
                        <div class="col-xs-9">
                            <h4><strong><%=post.getHeader()%></strong></h4>
                            <h5>Resort World Singapore</h5>
                        </div>
                        <span class="job-entry-price pull-right primary"><strong>$<%=post.getSalary()%>/hr</strong></span>
                    </div>

                    <div class="row">
                        <div class="col-xs-12">
                            <h5><%=post.getDescription()%> Lorem ipsum dolor sit amet, consectetur adipisicing elit. Fuga repellat corrupti nam provident praesentium vel! Nobis vel distinctio deserunt similique, nemo, voluptate a rem excepturi cumque ut quam quia minima.</br></br>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Fuga repellat corrupti nam provident praesentium vel! Nobis vel distinctio deserunt similique, nemo, voluptate a rem excepturi cumque ut quam quia minima.</h5>
                        </div>
                    </div>
                </div>

                <div class="row job-entry-apply" id="open-jobModal" data-header="<%= post.getHeader()%>" data-desc="<%=post.getDescription()%>" data-salary="$<%=post.getSalary()%>/hr">
                 <div class="col-xs-6"> 
                    <div class="detailIconsDiv">
                        <ul class="list-inline text-left">
                            <li class="detailIcons"><a href="#" class="whitelink"><i class="fa fa-dollar"></i></a></li>
                            <li class="detailIcons"><a href="#" class="whitelink"><i class="fa fa-cutlery"></i></a></li>
                            <li class="detailIcons"><a href="#" class="whitelink"><i class="fa fa-compass"></i></a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-xs-6">
                    <a href="#"  class="btn btn-primary btn pull-right">Apply now <i class="fa fa-check"></i></a>
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
            <h5>Resort World Singapore</h5>
            <h5>21/08/2015</h5>

            <h5 id="modalDesc">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Fuga repellat corrupti nam provident praesentium vel! Nobis vel distinctio deserunt similique, nemo, voluptate a rem excepturi cumque ut quam quia minima.</br></br>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Fuga repellat corrupti nam provident praesentium vel! Nobis vel distinctio deserunt similique, nemo, voluptate a rem excepturi cumque ut quam quia minima.
            </h5>
        </div>

    </div>

    <div class="col-md-5 modal-job-calendar">
        <h4><strong>Schedule for the Month</strong></h4>
        <div id="calendar"></div>
    </div>
</div>
<div class="modal-footer">
 <div class="pull-right" style="padding-right: 15px;">
    <button type="button" class="btn btn-default btn-lg" data-dismiss="modal">Close</button>
    <button type="button" class="btn btn-primary btn-lg">Apply for Job</button>
</div>
</div>
</div>
</div>
</div>

<script>

$(document).on("click", "#open-jobModal", function() {
    var headerText = $(this).data('header');
    var descText = $(this).data('desc');
    var salaryText = $(this).data('salary');

    $('#jobModalLabel').html(headerText);
    $('#modalHeader').html(headerText);
    $('#modalDesc').html(descText);
    $('#modalSalary').html(salaryText);


    $('#jobModal').modal('show');
});

$('#jobModal').on('shown.bs.modal', function () {
 $("#calendar").fullCalendar('render');
});
</script>
<!-- End of Job Modal -->


<script>

$(document).ready(function() {
 $('#jobModal').modal('show');
 $('#calendar').fullCalendar({
    editable: false,
    allDayDefault: true,
    contentHeight: 240,
    titleFormat: 'MMMM',
    eventColor: '#ee4054',
    events: [
    {
        title: 'A Event',
        start: '2015-08-05',
        end: '2015-08-05'
    },
    {
        title: 'C Event',
        start: '2015-08-07',
        end: '2015-08-07'
    },
    {
        title: 'B Event',
        start: '2015-08-06',
        end: '2015-08-06'
    },
    {
        title: 'D Event',
        start: '2015-08-02',
        end: '2015-08-05'
    }
    ],
    eventAfterRender: function(event, element, view) {
      $(element).css('height','30px');
      $(element).css('font-weight','700');
  }/*, eventRender: function (event, element, view) { 
        var dateString = event.start.format("YYYY-MM-DD");
        $(view.el[0]).find('.fc-day[data-date="' + dateString + '"]').css('background-color', '#ee4054');
    }*/
});


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


</script>


<jsp:include page="_footer.jsp" />






