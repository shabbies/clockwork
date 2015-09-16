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
            <img id="post_avatar" src="img/user-placeholder.jpg" alt="" class="db-user-pic img-rounded img-responsive"/>
            
            <h2 id="modalSalary">$10/h2>
        </div>

        <div class="col-md-8">
            <h4 id="modalHeader"><strong>Bellboy</strong> @ HardRock Hotel</h4>
            <h4 id="modalCompany"></h4>
            <h5 id="modalLocation">Resort World Singapore</h5>
            <h5 id="modalDatePosted" class="display-inline">21/08/2015</h5>
            <div id="modal_date_splitter" class="display-inline" >    to    </div>
            <h5 id="modalEndDate" class="display-inline">21/08/2015</h5>
            <div>
                <h5 id="modalStartTime" class="display-inline">11:00</h5>
                <div id="modal_date_splitter" class="display-inline" >    to    </div>
                <h5 id="modalEndTime" class="display-inline">15:00</h5>
            </div>

            <h5 id="modalDesc">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Fuga repellat corrupti nam provident praesentium vel! Nobis vel distinctio deserunt similique, nemo, voluptate a rem excepturi cumque ut quam quia minima.</br></br>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Fuga repellat corrupti nam provident praesentium vel! Nobis vel distinctio deserunt similique, nemo, voluptate a rem excepturi cumque ut quam quia minima.
            </h5>
        </div>

    </div>

    <div class="col-md-5 modal-job-calendar">
        <h4><strong>Schedule for the Month</strong></h4>
        <div id="calendar"></div>
        <h6><span class="label label-default bg-primary">Job Date</span>
            <%  if(currentUser!=null && currentUser.getAccountType().equals("job_seeker")){ %>
            <span class="label label-apply">Your Applied Jobs</span>
            <span class="label label-hire">Your Hired Jobs</span></h6>
            <% } %>
        </div>
    </div>
    <div class="modal-footer">
       <div class="pull-right" style="padding-right: 15px;">
        <button type="button" class="btn btn-default btn-lg" data-dismiss="modal">Close</button>
        <form action="/ApplyJobServlet" method="POST" class="display-inline">
            <input type="text" id="hiddenJobID" hidden value="" name="post_id"/>
            <%  if(!(currentUser!=null && currentUser.getAccountType().equals("employer"))){ %>
            <input type="submit" class="btn btn-primary btn-lg" value="Apply for Job" id="apply_job_button"/>
            <% } %>
        </form>
    </div>
</div>
</div>
</div>
</div>
        
<script>
$(document).on("click", "a", function(e){
   e.stopPropagation();
});

$(document).on("click", ".open-job-modal", function() {
    var job_details = $(this);
    if( job_details.data("ownjob") === ''){
        var headerText = job_details.data('header');
        var descText = job_details.data('desc');
        var salaryText = job_details.data('salary');
        var companyText = job_details.data('company');
        var locationText = job_details.data('location');
        var jobDateText = job_details.data("dateposted");
        var endDateText = job_details.data("enddate");
        var id = job_details.data("id");
        var uid = job_details.data("userid");
        var applied = job_details.data("applied");
        var avatar_path = job_details.data("avatar");
        var startTimeText = job_details.data("starttime");
        var endTimeText = job_details.data("endtime");


        $('#jobModalLabel').html(headerText);
        $('#modalHeader').html("<strong>"+headerText+"</strong>");
        $('#modalDesc').html(descText);
        $('#modalSalary').html(salaryText);
        $('#modalDesc').html(descText);
        $('#modalCompany').html(companyText);
        $('#modalLocation').html(" <i class=\"fa fa-map-marker primary\"></i> "+locationText);
        $('#modalDatePosted').html(jobDateText);
        $('#modalEndDate').html(endDateText);
        $('#modalStartTime').html(startTimeText);
        $('#modalEndTime').html(endTimeText);
        $('#hiddenJobID').val(id);
        if (avatar_path !== null){
            $('#post_avatar').attr("src", avatar_path);
        }

        $('#calendar').fullCalendar( 'destroy' );

        $('#calendar').fullCalendar({
            editable: false,
            allDayDefault: true,
            contentHeight: 400,
            titleFormat: 'MMMM',
            eventColor: 'grey',
            events: function(start, end, timezone, callback) {
                $.ajax({
                    url: 'https://clockwork-api.herokuapp.com/api/v1/users/get_calendar_formatted_dates.json',
                    dataType: 'json',
                    data: {
                        id:uid
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
            },
            eventAfterRender: function(event, element, view) {
                $(element).css('height','30px');
                $(element).css('font-weight','700');
            }
        });


        $('#calendar').fullCalendar( 'gotoDate', new Date(job_details.data("cdate")));

        var start_date = new Date(job_details.data("cdate"));
        var end_date = new Date(job_details.data("cdateend"));
        start_date.setHours(0);
        while (start_date <= end_date){
            var myevent = {title: headerText, start: start_date.toString(), color: '#ee4054'};
            $('#calendar').fullCalendar( 'renderEvent', myevent, true);
            start_date.setDate(start_date.getDate() + 1);
        }
        
        if (typeof applied !== "undefined"){
            $("#apply_job_button").hide();
        }
        $('#jobModal').modal('show');

    } else {
        var jobstatus = job_details.data('jobstatus');
        if(jobstatus === 'listed'){
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