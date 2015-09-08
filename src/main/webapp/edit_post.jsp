<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>

<%@ page import="model.Post"%>

<%  String postID = request.getParameter("id");
      String formURL = "/GetPostServlet?id=" + postID + "&location=edit";
      Post post = (Post)session.getAttribute("post");
      if (post == null){%>
<jsp:forward page="<%=formURL%>" />
<%} else { session.removeAttribute("post");}%>

<!-- Initialising Google Places for location autofill -->
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true&libraries=places"></script>
<script>
    function initialize() {
        var input = /** @type {HTMLInputElement} */(
                document.getElementById('job-location'));

        var autocomplete = new google.maps.places.Autocomplete(input);

        google.maps.event.addListener(autocomplete, 'place_changed', function() {
            var place = autocomplete.getPlace();
            if (!place.geometry) {
                window.alert("Autocomplete's returned place contains no geometry");
                return;
            }
        });
    }

    google.maps.event.addDomListener(window, 'load', initialize);
</script>
<!-- END -->

<header class="main">
<div class="header-full-content">
<div class="header-content-inner">
<h2 class="text-center"><%=post.getHeader()%></h2>

<div class="row">
<div class="col-md-8 col-md-offset-2">
<div class="panel panel-default">
<div class="panel-body">
    <form class="form form-signup" action="/EditPostServlet" method="POST" role="form">

        <input type="text" name="post_id" value="<%=post.getId()%>" hidden />
        <div class="form-group form-group-lg col-md-6 text-left"> 
            <label for="job-title" class="control-label">Job Title</label> 
            <input id="job-title" class="form-control" type="text" value="<%=post.getHeader()%>" name="header" required> 
        </div>

        <div class="form-group form-group-lg col-md-6 text-left"> 
            <label for="job-location" class="controls control-label">Job Location</label> 
            <input id="job-location" class="form-control" type="text" value="<%=post.getLocation()%>" name="location" required>  
        </div>

        <div class="form-group col-md-12 text-left"> 
            <label for="job-desc" class="control-label">Job Description</label> 
            <textarea id="job-desc" class="form-control form-group-lg" rows="3" name="description" rows="3" required><%=post.getDescription()%></textarea> 
        </div>

        <div class="form-group form-group-lg col-md-6 text-left"> 
            <label for="job-date" class="control-label">Job Start Date</label> 
            <div class="input-group"> 
                <div class="input-group-addon"><i class="fa fa-calendar fa-lg fa-fw"></i></div> 
                <input id="job-date" class="form-control" type="date" name="job_date" value="<%=post.getJobDateStringForInput()%>" required> 
            </div> 
            <div class="job-start-date col-md-12 profile_error" style="display:none;">  
                <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true" ></span>
                Start date should be at least 2 days from today
            </div>
            <div class="job-end-date col-md-12 profile_error start-filler" style="display:none;">  
                <span aria-hidden="true"></span>
                &nbsp;
            </div>
        </div>
            
        <div class="form-group form-group-lg col-md-6 text-left"> 
            <label for="end-date" class="control-label">Job End Date</label> 
            <div class="input-group"> 
                <div class="input-group-addon"><i class="fa fa-calendar fa-lg fa-fw"></i></div> 
                <input id="end-date" class="form-control" type="date" name="end_date" value="<%=post.getJobEndDateStringForInput()%>" required> 
            </div> 
            <div class="job-end-date col-md-12 profile_error" style="display:none;">  
                <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                End date should be at least 2 days from today
            </div>
            <div class="job-end-date col-md-12 profile_error end-filler" style="display:none;">  
                <span aria-hidden="true"></span>
                &nbsp;
            </div>  
        </div>
            
        <div class="form-group form-group-lg col-md-6 text-left"> 
            <label for="start-time" class="control-label">Job Start Time</label> 
            <div class="input-group"> 
                <div class="input-group-addon"><i class="fa fa-clock-o fa-lg fa-fw"></i></div> 
                <input id="start-time" class="form-control" type="time" name="start_time" value="<%=post.getStartTime()%>" required>
            </div> 
        </div>
            
        <div class="form-group form-group-lg col-md-6 text-left"> 
            <label for="end-time" class="control-label">Job End Time</label> 
            <div class="input-group"> 
                <div class="input-group-addon"><i class="fa fa-clock-o fa-lg fa-fw"></i></div> 
                <input id="end-time" class="form-control" type="time" name="end_time" value="<%=post.getEndTime()%>" required>
            </div> 
        </div>

        <div class="form-group form-group-lg col-md-5 pull-left text-left"> 
            <label for="job-pay" class="control-label">Pay</label> 
            <div class="input-group"> 
                <div class="input-group-addon"><i class="fa fa-dollar fa-lg fa-fw"></i></div> 
                <input id="job-pay" class="form-control" type="number" name="salary" value="<%=post.getSalary()%>" min="0" step="0.1"required> 
                <div class="input-group-addon" style="font-weight:600;"> / Hr</div> 
            </div> 
        </div>
               
        <div class="form-group form-group-lg col-md-12">         
            <input type="submit" class="btn btn-lg btn-primary btn-srad" value="Update Listing"/>
        </div>
    </form>
    <div class="form-group form-group-lg col-md-12">  
        <form action="/DeletePostServlet" method="POST">
            <input type="text" value="<%=post.getId()%>" name="post_id" hidden />
            <input type="submit" class="btn btn-lg btn-default btn-srad" value="Remove Listing"/>
        </form>
    </div>
</div>
</div>
</div>
</div>
</div>
</div>
</header>

<jsp:include page="_footer.jsp" />
<jsp:include page="_javascript_checker.jsp" />