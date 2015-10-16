<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>
   
<!-- Initialising Google Places for location autofill -->
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true&libraries=places"></script>
<script>
    function initialize() {
        var input = /** @type {HTMLInputElement} */(
                document.getElementById('street-address'));
        
        var autocomplete = new google.maps.places.Autocomplete(input);
        
        google.maps.event.addListener(autocomplete, 'place_changed', function() {
            infowindow.close();
            marker.setVisible(false);
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
<div class="row profile-div">

<%@include file="_message.jsp"%>

<div class="col-sm-2"></div>
<div class="col-sm-8">

<div class="panel panel-default">
<div class="panel-body">

<form class="form form_complete_profile" action="/CompleteProfileServlet" method="POST" role="form" enctype="multipart/form-data">
    <div class="text-center">
        <% if (currentUser.getAvatar() == null){%>
        <img id="profile-pic" src="img/user-placeholder.jpg" alt="" class="db-user-pic modal-pic col-centered img-rounded img-responsive" />
        <% } else { %>
        <img id="profile-pic" src="<%=currentUser.getAvatar()%>" alt="" class="db-user-pic modal-pic col-centered img-rounded img-responsive" />
        <% } %>
    </div>

    <div class="form-group col-sm-6 text-left"> 
        <label for="full-name" class="control-label">Full Name*</label> 
        <input id="full-name" class="form-control" type="text" placeholder="Name" name="username" value="<%=currentUser.getUsername()%>" required> 
    </div>

    <div class="form-group col-sm-6 text-left"> 
        <label for="gender" class="control-label">Gender*</label>
        <% if (currentUser.getGender() == 'M'){ %>
            <label class="radio"><input type="radio" name="gender" value="M" checked="checked">Male</label>
        <% } else { %>
            <label class="radio"><input type="radio" name="gender" value="M">Male</label>
        <% } %>
        <% if (currentUser.getGender() == 'F'){ %>
            <label class="radio"><input type="radio" name="gender" value="F" checked="checked">Female</label>
        <% } else { %>
            <label class="radio"><input type="radio" name="gender" value="F">Female</label>
        <% } %>
        <div class="gender-error col-md-12 profile_error" style="display: none;">  
            <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true" ></span>
            Please select your gender
        </div>
    </div>

    <div class="form-group col-sm-6 text-left"> 
        <label for="contactnumber" class="control-label">Contact Number*</label> 
        <% if (currentUser.getContactNumber() == 0){ %>
        <input id="contactnumber" class="form-control" type="text" name="contact_number" onkeypress="return isNumber(event)" required> 
        <% } else { %>
        <input id="contactnumber" class="form-control" type="text" name="contact_number" onkeypress="return isNumber(event)" value="<%=currentUser.getContactNumber()%>" required> <%}%>
    </div>

    <div class="form-group col-sm-6 text-left"> 
        <label for="nationality" class="control-label">Nationality*</label> 
        <select id="nationality" class="form-control" name="nationality" required>
            <% if (currentUser.getNationality() == null) { %>
                <option>Singaporean</option>
                <option>Singapore PR</option>
                <option>Others</option>
                <option selected="selected" disabled="disabled">Please select a nationality</option>
            <% } else if (currentUser.getNationality().equals("Singaporean")) {%>
                <option selected="selected">Singaporean</option>
                <option>Singapore PR</option>
                <option>Others</option>
            <% } else if (currentUser.getNationality().equals("Singapore PR")){ %>
                <option>Singaporean</option>
                <option selected="selected">Singapore PR</option>
                <option>Others</option>
            <% } else { %>
                <option>Singaporean</option>
                <option>Singapore PR</option>
                <option selected="selected">Others</option>
            <% } %>
        </select>
        
        <div class="nationality-error col-md-12 profile_error" style="display: none;">  
            <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true" ></span>
            Please select your nationality
        </div>
    </div>

    <div class="form-group col-sm-6 text-left"> 
        <label for="avatar" class="control-label">Profile Picture</label> 
        <input id="avatar" class="form-control" type="file" name="avatar" accept="image/*">
    </div>

    <div class="form-group col-sm-6 text-left"> 
        <label for="dob-date" class="control-label">Date of Birth*</label> 
        <div class="input-group"> 
            <div class="input-group-addon"><i class="fa fa-calendar fa-lg fa-fw" id="dob-date-icon"></i></div> 
                <% if (currentUser.getDateOfBirth() == null){ %>
            <input id="dob-date" class="form-control" type="text" name="dob_date" required> 
            <% } else { %>
            <input id="dob-date" class="form-control" type="text" name="dob_date" value="<%=currentUser.getDateOfBirthString()%>" required> <% } %>
        </div> 
        <div class="dob-error col-md-12 profile_error" style="display:none;">  
            <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true" ></span>
            You have to be at least 15 years old
        </div>
    </div>

    <div class="form-group col-sm-12 text-left"> 
        <label for="street-address" class="control-label">Street Address*</label> 
        <% if (currentUser.getAddress() == null){ %>
        <input id="street-address" class="form-control" type="text" name="address" required> 
        <% } else { %>
        <input id="street-address" class="form-control" type="text" name="address" value="<%=currentUser.getAddress()%>" required><%}%> 
    </div>
    <div class="form-group col-sm-12 text-center"> 
        <input class="btn btn-lg btn-primary btn-srad" type="submit" value="Complete Profile">
    </div>
</form>
</div>
</div>
</div>
<div class="col-sm-2"></div>           
</div>
<a href="/mydashboard.jsp" class="btn btn-lg btn-warning btn-srad" type="button">Back to Dashboard</a>
</div>
</div>
</header>
<jsp:include page="_javascript_checker.jsp" />
<jsp:include page="_footer.jsp" />

<script>
    $("#dob-date").daterangepicker({
        locale: {
            format: 'MMMM D, YYYY'
        },
        dateLimit: {
            "days": 6
        },
        singleDatePicker: true
    }, function(start, end, label) {
        var years = moment().diff(start, 'years');
        if (years < 15){
            $("#dob-date").css("border", "1px solid #ee4054" );
            $("#dob-date").css("box-shadow", "none");
            $(".dob-error").removeAttr("style");
            $("#dob-date").val("");
        }
    }); 
    
    $(document).on("click", "#dob-date-icon", function(){
       $("#dob-date").focus(); 
    });
</script>