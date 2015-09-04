<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>

<%@ page import="model.User"%>

<%  
if (currentUser == null){
session.setAttribute("error", "Please login or register first before posting a job");
response.sendRedirect("/login.jsp");
return;
} else if (!currentUser.getAccountType().equals("employer")){
session.setAttribute("error", "Only an employer account is able to post a job!");
response.sendRedirect("/index.jsp");
return;
}%>

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

<%  String[] repopulate = (String[])session.getAttribute("repopulate");
    if (repopulate != null){
        session.removeAttribute("repopulate");
    } 
%>

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
    
<div class="header-content-inner">
<h2 class="text-center">Let's Create a new listing!</h2>

<div class="row">
<div class="col-md-8 col-md-offset-2">
<div class="panel panel-default">
<div class="panel-body">
<form class="form form-signup" action="/CreatePostServlet" method="POST" role="form">

    <div class="form-group form-group-lg col-md-6 text-left"> 
        <label for="job-title" class="control-label">Job Title</label> 
        <% if (repopulate == null){%>
        <input id="job-title" class="form-control" type="text" placeholder="" name="header" required> 
        <%} else {%>
        <input id="job-title" class="form-control" type="text" placeholder="" name="header" value="<%=repopulate[0]%>" required><%}%>
    </div>

    <div class="form-group form-group-lg col-md-6 text-left"> 
        <label for="job-location" class="controls control-label">Job Location</label> 
        <% if (repopulate == null){%>
        <input id="job-location" class="form-control" type="text" placeholder="" name="location" required>  
        <% } else { %>
        <input id="job-location" class="form-control" type="text" placeholder="" name="location" value="<%=repopulate[1]%>"required><%}%>
    </div>

    <div class="form-group col-md-12 text-left">
        <label for="job-desc" class="control-label">Job Description</label> 
        <% if (repopulate == null){%>
        <textarea id="job-desc" class="form-control form-group-lg" rows="3" name="description" rows="3" required></textarea> 
        <%} else {%>
        <textarea id="job-desc" class="form-control form-group-lg" rows="3" name="description" rows="3" required><%=repopulate[2]%></textarea> <%}%>
    </div>

    <div class="form-group form-group-lg col-md-7 text-left"> 
        <label for="job-date" class="control-label">Job Date</label> 
        <div class="input-group"> 
            <div class="input-group-addon"><i class="fa fa-calendar fa-lg fa-fw"></i></div> 
            <% if (repopulate != null && repopulate[3] != null){%>
                <input id="job-date" class="form-control" type="date" name="job_date" value="<%=repopulate[3]%>" onchange="test()" required> 
            <%} else {%>
                <input id="job-date" class="form-control" type="date" name="job_date" required><%}%>
        </div> 
    </div>
        
        
    <div class="form-group form-group-lg col-md-7 text-left"> 
        <label for="job-expiry" class="control-label">Post Expiry Date</label> 
        <div class="input-group"> 
            <div class="input-group-addon"><i class="fa fa-calendar fa-lg fa-fw"></i></div> 
            <% if (repopulate != null && repopulate[7] != null){%>
                <input id="job-expiry" class="form-control" type="date" name="job_expiry" value="<%=repopulate[7]%>" required> 
            <%} else {%>
                <input id="job-expiry" class="form-control" type="date" name="job_expiry" required><%}%>
        </div> 
    </div>
        
    <div class="form-group form-group-lg col-md-5 pull-right text-left"> 
        <label for="job-pay" class="control-label">Pay</label> 
        <div class="input-group"> 
            <div class="input-group-addon"><i class="fa fa-dollar fa-lg fa-fw"></i></div> 
                <% if (repopulate != null && repopulate[4] != null){%>
            <input id="job-pay" class="form-control" type="number" value="<%=repopulate[4]%>" name="salary" min="0" step="0.1" required>
            <%} else {%>
            <input id="job-pay" class="form-control" type="number" value="10" name="salary" min="0" step="0.1" required><%}%>
            <div class="input-group-addon" style="font-weight:600;"> / Hr</div> 
        </div> 
    </div>
        
    <div class="form-group form-group-lg col-md-7 text-left"> 
        <label for="job-time" class="control-label">Job Start Time</label> 
        <div class="input-group"> 
            <div class="input-group-addon"><i class="fa fa-clock-o fa-lg fa-fw"></i></div> 
                <% if (repopulate != null && repopulate[5] != null){%>
            <input id="job-start-time" class="form-control" type="time" name="job_time" value="<%=repopulate[5]%>" required> 
            <%} else {%>
            <input id="job-start-time" class="form-control" type="time" name="job_time" required><%}%>
        </div> 
    </div>

    <div class="form-group form-group-lg col-md-12 pull-right text-left"> 
        <label for="job-hours" class="control-label">Number of Hours</label> 
        <div class="input-group"> 
            <div class="input-group-addon"><i class="fa fa-clock-o fa-lg fa-fw"></i></div> 
                <% if (repopulate != null && repopulate[6] != null){%>
            <input id="job-hours" class="form-control" type="number" value="<%=repopulate[6]%>" name="duration" min="0" required>
            <%} else {%>
            <input id="job-hours" class="form-control" type="number" value="8" name="duration" min="0" required><%}%>
            <div class="input-group-addon" style="font-weight:600;"> Hours</div> 
        </div> 
    </div>

    <input type="submit" class="btn btn-lg btn-primary btn-srad" value="Create Listing"/>

</form>
</div>
</div>
</div>
</div>
</div>
</div>
</header>
<script>
    $(document).ready(function(){
        $("#job-pay").change(function(){
            var amount = parseFloat($(this).val()).toFixed(2);
            $(this).val(amount);
        });
       
//        $("#inline-date-picker").multiDatesPicker();
    });
</script>
<jsp:include page="_footer.jsp" />
