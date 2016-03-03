<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>
<%@include file="_only_emp.jsp"%>

<%@ page import="model.User"%>
<%@ page import="controller.PostController"%>

<%  
appController = (AppController)session.getAttribute("appController");
PostController postController = appController.getPostController();
if (postController.getEmployerReviewingJobs().size() != 0){
    session.setAttribute("error", "Please submit your pending reviews before posting a new job!");
    response.sendRedirect("/dashboard.jsp");
    return;
}%>

<!-- Initialising Google Places for location autofill -->
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true&libraries=places"></script>
<script>
    var geocoder;
    function initialize() {
        var input = /** @type {HTMLInputElement} */(
                document.getElementById('job-location'));
        geocoder = new google.maps.Geocoder();
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
<div class="header-full-content">
    
<%@include file="_message.jsp"%>
    
<div class="header-content-inner">
<h2 class="text-center">Let's Create a new listing!</h2>

<div id="error-text" class="alert alert-danger" role="alert" style="font-size: 14px; display: none;">
  <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
  <strong id="error-message"></strong>
</div>

<div class="row">
<div class="col-md-8 col-md-offset-2">
<div class="panel panel-default">
<div class="panel-body">
<form class="form form-post" action="/CreatePostServlet" method="POST" role="form">
    <table>
        <tr>
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
            
            <div id="job-location-error" class="col-md-6 pull-right details-error" style="display: none;">  
                <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true" ></span>
                Please select a valid address!
            </div
        </tr>
        <tr>    
            <div class="form-group col-md-12 text-left">
                <label for="job-desc" class="control-label col-md-12">Job Description</label> 
<!--                <div class="col-md-12"> 
                    <label class="col-md-3 genre unclickable"><input type="checkbox" id="checkbox-service"/> &nbsp; Service</label>
                    <label class="col-md-3 genre unclickable"><input type="checkbox" id="checkbox-kitchen"/> &nbsp; Kitchen Crew</label>
                    <label class="col-md-3 genre unclickable"><input type="checkbox" id="checkbox-cleanup"/> &nbsp; Clean Up</label>
                    <label class="col-md-3 genre unclickable"><input type="checkbox" id="checkbox-ordertaking"/> &nbsp; Order Taking</label>
                    <label class="col-md-3 genre unclickable"><input type="checkbox" id="checkbox-selling"/> &nbsp; Selling</label>
                    <label class="col-md-3 genre unclickable"><input type="checkbox" id="checkbox-barista"/> &nbsp; Barista</label>
                    <label class="col-md-3 genre unclickable"><input type="checkbox" id="checkbox-cashier"/> &nbsp; Cashier</label>
                    <label class="col-md-3 genre unclickable"><input type="checkbox" id="checkbox-bartender"/> &nbsp; Bartender</label>
                </div>-->
                <% if (repopulate == null){%>
                <pre class="col-md-12"><textarea id="job-desc" class="form-control form-group-lg job-desc" rows="3" name="description" rows="3" required></textarea></pre>
                <%} else {%>
                <pre class="col-md-12"><textarea id="job-desc" class="form-control form-group-lg col-md-12" rows="3" name="description" rows="3" required><%=repopulate[2]%></textarea></pre> <%}%>
            </div>
        </tr>
        <tr>
            <div class="form-group form-group-lg col-md-7 text-left"> 
                <label for="job-date" class="control-label">Job Date</label> 
                <div class="input-group"> 
                    <div class="input-group-addon" id="job-date-icon"><i class="fa fa-calendar fa-lg fa-fw"></i></div> 
                    <% if (repopulate != null && repopulate[3] != null){%>
                        <input id="job-date" class="form-control" type="text" name="job_date" value="<%=repopulate[3]%>" onchange="test()" required> 
                    <%} else {%>
                        <input id="job-date" class="form-control" type="text" name="job_date" required><%}%>
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
                
            <div class="form-group form-group-lg col-md-5 pull-left text-left"> 
                <label for="job-pay" class="control-label">Pay</label> 
                <div class="input-group"> 
                    <div class="input-group-addon"><i class="fa fa-dollar fa-lg fa-fw"></i></div> 
                    <% if (repopulate != null && repopulate[4] != null){%>
                    <input id="job-pay" class="form-control" type="number" value="<%=repopulate[6]%>" name="salary" min="0" step="0.1" required>
                    <% } else { %>
                    <input id="job-pay" class="form-control" type="number" value="10" name="salary" min="0" step="0.1" required>
                    <% } %>
                    <div class="input-group-addon pay-type-selector btn-warning active" id="hour">
                        <strong>/hour</strong>
                    </div>
                    <div class="input-group-addon pay-type-selector btn-warning" style="border-top-right-radius: 4px; border-bottom-right-radius: 4px;" id="day">
                        <strong>/day</strong>
                    </div>
                    <input id="pay-switch" type="checkbox" class="switch form-group" name="pay-type" data-on-text="/hour" data-off-text="/day" checked hidden/>
                </div> 
            </div>
        </tr>
        <tr>
            <div class="form-group form-group-lg col-md-6 text-left"> 
                <label for="start-time" class="control-label">Job Start Time</label> 
                <div class="input-group"> 
                    <div class="input-group-addon"><i class="fa fa-clock-o fa-lg fa-fw"></i></div> 
                        <% if (repopulate != null && repopulate[5] != null){%>
                    <input id="start-time" class="form-control" type="time" name="start_time" value="<%=repopulate[4]%>" required> 
                    <%} else {%>
                    <input id="start-time" class="form-control" type="time" name="start_time" value="09:00" required><%}%>
                </div> 
            </div>

            <div class="form-group form-group-lg col-md-6 text-left"> 
                <label for="end-time" class="control-label">Job End Time</label> 
                <div class="input-group"> 
                    <div class="input-group-addon"><i class="fa fa-clock-o fa-lg fa-fw"></i></div> 
                        <% if (repopulate != null && repopulate[5] != null){%>
                    <input id="end-time" class="form-control" type="time" name="end_time" value="<%=repopulate[5]%>" required> 
                    <%} else {%>
                    <input id="end-time" class="form-control" type="time" name="end_time" value="18:00" required><%}%>
                </div> 
            </div>
        </tr>
        <tr>
            <div class="form-group form-group-lg col-md-12">
                <input type="submit" class="btn btn-lg btn-primary btn-srad" value="Create Listing"/>
            </div>
        </tr>
    </table>
</form>
</div>
</div>
</div>
</div>
</div>
</div>
</header>
<jsp:include page="_anchor.jsp" />
<jsp:include page="_footer.jsp" />
<jsp:include page="_javascript_checker.jsp" />

<script>
    $(".genre").change(function(){
        var checked = $(this).children("input[type=checkbox").prop("checked");
        if (checked){
            if ($(".job-desc").val() === ""){
                $(".job-desc").append("Responsibilities include:\n");
            }
            var id = $(this).children("input[type=checkbox").attr("id");
            switch (id) {
                case "checkbox-service":
                    if ($(".job-desc").val().indexOf("waiting on tables") === -1){
                        var old_desc = $(".job-desc").val();
                        var new_desc = old_desc + "\twaiting on tables\n";
                        $(".job-desc").val(new_desc);
                    }
                    break;
                case "checkbox-kitchen":
                    if ($(".job-desc").val().indexOf("helping to prepare food") === -1){
                        var old_desc = $(".job-desc").val();
                        var new_desc = old_desc + "\thelping to prepare food\n";
                        $(".job-desc").val(new_desc);
                    }
                    break;
                case "checkbox-cleanup":
                    if ($(".job-desc").val().indexOf("clearing of tables and general cleanup") === -1){
                        var old_desc = $(".job-desc").val();
                        var new_desc = old_desc + "\tclearing of tables and general cleanup\n";
                        $(".job-desc").val(new_desc);
                    }
                    break;
                case "checkbox-ordertaking":
                    if ($(".job-desc").val().indexOf("taking customer orders") === -1){
                        var old_desc = $(".job-desc").val();
                        var new_desc = old_desc + "\ttaking customer orders\n";
                        $(".job-desc").val(new_desc);
                    }
                    break;
                case "checkbox-selling":
                    if ($(".job-desc").val().indexOf("promoting products") === -1){
                        var old_desc = $(".job-desc").val();
                        var new_desc = old_desc + "\tpromoting products\n";
                        $(".job-desc").val(new_desc);
                    }
                    break;
                case "checkbox-barista":
                    if ($(".job-desc").val().indexOf("operate coffee brewing machine") === -1){
                        var old_desc = $(".job-desc").val();
                        var new_desc = old_desc + "\toperate coffee brewing machine\n";
                        $(".job-desc").val(new_desc);
                    }
                    break;
                case "checkbox-cashier":
                    if ($(".job-desc").val().indexOf("operate cash register") === -1){
                        var old_desc = $(".job-desc").val();
                        var new_desc = old_desc + "\toperate cash register\n";
                        $(".job-desc").val(new_desc);
                    }
                    break;
                case "checkbox-bartender":
                    if ($(".job-desc").val().indexOf("mix and serve alcohol") === -1){
                        var old_desc = $(".job-desc").val();
                        var new_desc = old_desc + "\tmix and serve alcohol\n";
                        $(".job-desc").val(new_desc);
                    }
                    break;
            }
        } else {
            var id = $(this).children("input[type=checkbox").attr("id");
            switch (id) {
                case "checkbox-service":
                    var old_desc = $(".job-desc").val();
                    var new_desc = old_desc.replace("\twaiting on tables\n", "");
                    $(".job-desc").val(new_desc);
                    break;
                case "checkbox-kitchen":
                    var old_desc = $(".job-desc").val();
                    var new_desc = old_desc.replace("\thelping to prepare food\n", "");
                    $(".job-desc").val(new_desc);
                    break;
                case "checkbox-cleanup":
                    var old_desc = $(".job-desc").val();
                    var new_desc = old_desc.replace("\tclearing of tables and general cleanup\n", "");
                    $(".job-desc").val(new_desc);
                    break;
                case "checkbox-ordertaking":
                    var old_desc = $(".job-desc").val();
                    var new_desc = old_desc.replace("\ttaking customer orders\n", "");
                    $(".job-desc").val(new_desc);
                case "checkbox-selling":
                    var old_desc = $(".job-desc").val();
                    var new_desc = old_desc.replace("\tpromoting products\n", "");
                    $(".job-desc").val(new_desc);
                    break;
                case "checkbox-barista":
                    var old_desc = $(".job-desc").val();
                    var new_desc = old_desc.replace("\toperate coffee brewing machine\n", "");
                    $(".job-desc").val(new_desc);
                    break;
                case "checkbox-cashier":
                    var old_desc = $(".job-desc").val();
                    var new_desc = old_desc.replace("\toperate cash register\n", "");
                    $(".job-desc").val(new_desc);
                    break;
                case "checkbox-bartender":
                    var old_desc = $(".job-desc").val();
                    var new_desc = old_desc.replace("\tmix and serve alcohol\n", "");
                    $(".job-desc").val(new_desc);
                    break;
            }
        }
    });
</script>