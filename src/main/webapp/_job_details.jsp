<%@ page import="model.APIManager"%>

<div class="modal fade" id="jobModal" tabindex="-1" role="dialog" aria-labelledby="jobModalLabel">
<div class="modal-dialog modal-lg" role="document">
<div class="modal-content">
<div class="modal-header text-center">
    <div class="col-md-11 job-clashing-warning">
        <strong class="apply-application-warning" id="already_applied"><i class="fa fa-warning"></i> You have already applied for this job!</strong>
        <strong class="apply-application-warning" id="already_hired"><i class="fa fa-warning"></i> This job clashes with one that you are already hired for!</strong>
    </div>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
</div>
<div class="modal-body">

    <div class="col-md-7 modal-job-details">
        <div class="col-md-4 text-center">
            <img id="post_avatar" src="img/user-placeholder.jpg" alt="" class="db-user-pic img-rounded img-responsive"/>

            <h2 id="modalSalary">$10/h2>
        </div>

        <div class="col-md-8">
                <h4 class="col-md-12 col-lg-12" id="modalHeader"><strong>Bellboy</strong> @ HardRock Hotel</h4>
                <h4 class="col-md-12" id="modalCompany"></h4>
                <strong class="col-md-4">Location</strong><h5 class="col-md-8" id="modalLocation">Resort World Singapore</h5>
                <strong class="col-md-4">Start Date</strong><h5 class="col-md-8" id="modalDatePosted">21/08/2015</h5>
                <strong class="col-md-4">End Date</strong><h5 class="col-md-8" id="modalEndDate">21/08/2015</h5>
                <strong class="col-md-4">Timing</strong>
                <div class="col-md-8">
                    <h5 id="modalStartTime" class="display-inline">11:00</h5>
                    <div id="modal_date_splitter" class="display-inline" >    to    </div>
                    <h5 id="modalEndTime" class="display-inline">15:00</h5>
                </div>
                <strong class="col-md-12 text-center" style="padding-top: 10px; padding-bottom: 10px;">Job Description</strong>
                <pre class="col-md-12"><h5 id="modalDesc">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Fuga repellat corrupti nam provident praesentium vel! Nobis vel distinctio deserunt similique, nemo, voluptate a rem excepturi cumque ut quam quia minima.</br></br>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Fuga repellat corrupti nam provident praesentium vel! Nobis vel distinctio deserunt similique, nemo, voluptate a rem excepturi cumque ut quam quia minima.
                </h5></pre>
            
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
</div>
<div class="modal-footer">
    <div class="pull-right" style="padding-right: 15px;">
        <button type="button" class="btn btn-default btn-lg" data-dismiss="modal">Close</button>
        <form action="/ApplyJobServlet" method="POST" class="display-inline" id="apply_job_form">
            <input type="text" id="hiddenJobID" hidden value="" name="post_id"/>
            <%  if(!(currentUser!=null && currentUser.getAccountType().equals("employer"))){ %>
            <input type="submit" class="btn btn-primary btn-lg" value="Apply for Job" id="apply_job_button"/>
            <% } %>
        </form>
    </div>
    <div class="pull-left">
        <div><button type="button" id="facebook_share" class="btn btn-info btn-lg">Share on Facebook</button></div>
    </div>
</div>
</div>
</div>
</div>
    
<script>
    var postID = null;
    
    $(document).on("click", "#facebook_share", function(e){
        var left = (screen.width - 600) / 2;
        var top = (screen.height - 300) / 4; 
        var host = window.location.origin.toString();
        window.open("http://www.facebook.com/sharer/sharer.php?u=" + host + "/post.jsp?id=" + postID, "Share on Facebook!", "menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=300,width=600,top=" + top + ",left=" + left);
    });
    
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
            postID = id;
            
            $("#already_applied").addClass("hidden");
            $("#already_hired").addClass("hidden");
            var current_location = window.location.href.toString();
            if (current_location.indexOf("dashboard") === -1){
            <% if (currentUser != null) { %>
                $.ajax({
                    url: '/CheckJobAppliedServlet',
                    method: "GET",
                    async: false,
                    data: {
                        post_id: job_details.data("id")
                    },
                    success: function(hasAppliedJSON) {
                        var hasApplied = JSON.parse(hasAppliedJSON);
                        if (hasApplied === true){
                            $("#already_applied").removeClass("hidden");
                            applied = "true";
                        } else if (hasApplied.toString() !== ""){
                            $("#already_hired").removeClass("hidden");
                            applied = "true";
                        }
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                      console.log(textStatus, errorThrown);
                    }
                });
            <% } %>
            }
            $('#jobModalLabel').html(headerText);
            $('#modalHeader').html("<strong>"+headerText+"</strong>");
            $('#modalDesc').html(descText);
            $('#modalSalary').html(salaryText);
            $('#modalDesc').html(descText);
            $('#modalCompany').html("<strong>" + companyText + "</strong>");
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
            
            var calendar_dates = {};
            if (current_location.indexOf("dashboard") > 0 || (typeof applied !== "undefined" && current_location.indexOf("index") !== -1)){
                $("#apply_job_button").hide();
            } else {
                $("#apply_job_button").show();
                var start_date = new Date(job_details.data("cdate"));
                var end_date = new Date(job_details.data("cdateend"));
                start_date.setHours(0);
                while (start_date <= end_date){
                    var start_date_string = start_date.getFullYear() + "-" + ("0" + (start_date.getMonth() + 1)).slice(-2) + "-" + ("0" + start_date.getDate()).slice(-2);
                    calendar_dates[start_date_string] = {title: "", start: start_date_string, color: '#ee4054'};
                    start_date.setDate(start_date.getDate() + 1);
                }
            }
            $('#calendar').fullCalendar({
                editable: false,
                allDayDefault: true,
                contentHeight: 400,
                titleFormat: 'MMMM',
                eventColor: 'grey',
                events: function(start, end, timezone, callback) {
                <%  if (session.getAttribute("currentUser") != null){ 
                    appController = (AppController)session.getAttribute("appController");
                    APIManager apiManager = appController.getAPIManager();
                    String URL = apiManager.getEPCalendarFormatDates();%>
                    $.ajax({
                        url: '<%=URL%>',
                        dataType: 'json',
                        data: {
                            id:uid
                        },
                        success: function(doc) {
                            var events = [];
                            obj = JSON.parse(doc);
                            $(obj).each(function() {
                                var title = $(this).attr('title');
                                var start = $(this).attr("job_date");
                                var color = $(this).attr("color");
                                calendar_dates[start] = {
                                    title: "",
                                    start: start,
                                    color: color
                                };
                            });
                            
                            var start_date = new Date(job_details.data("cdate"));
                            var end_date = new Date(job_details.data("cdateend"));
                            start_date.setHours(0);
                            while (start_date <= end_date){
                                var start_date_string = start_date.getFullYear() + "-" + ("0" + (start_date.getMonth() + 1)).slice(-2) + "-" + ("0" + start_date.getDate()).slice(-2);
                                calendar_dates[start_date_string] = {title: "", start: start_date_string, color: '#ee4054'};
                                start_date.setDate(start_date.getDate() + 1);
                            }
                            
                            for (var key in calendar_dates){
                                events.push(calendar_dates[key]);
                            }
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
            
            
            $('#calendar').fullCalendar( 'gotoDate', new Date(job_details.data("cdate")));
            
            <% if (currentUser == null){ %>
                var events = [];
                for (var key in calendar_dates){
                    events.push(calendar_dates[key]);
                }
                $('#calendar').fullCalendar( 'addEventSource', events);
            <% } %>
            
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