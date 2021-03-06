<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>
<%@include file="_only_registered.jsp"%>
    
<!-- Initialising Google Places for location autofill -->
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true&libraries=places"></script>
<script>
    function initialize() {
        var input = /** @type {HTMLInputElement} */(
                document.getElementById('street-address'));
        
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

<div class="row profile-div">

    <%@include file="_message.jsp"%>

    <div class="col-sm-6">

        <div class="panel panel-default">
            <div class="panel-body">

                <!-- User Profile (Left Panel -->
                <form class="form form-signup" action="/UpdateUserProfileServlet" method="POST" role="form" enctype="multipart/form-data">

                    <div class="text-center">
                        <% if (currentUser.getAvatar() == null){%>
                        <img id="profile-pic" src="img/user-placeholder.jpg" alt="" class="db-user-pic modal-pic col-centered img-rounded img-responsive" />
                        <% } else { %>
                        <img id="profile-pic" src="<%=currentUser.getAvatar()%>" alt="" class="db-user-pic modal-pic col-centered img-rounded img-responsive" />
                        <% } %>
                    </div>

                    <div class="form-group col-sm-6 text-left"> 
                        <label for="avatar" class="control-label">Profile Picture</label> 
                        <input id="avatar" class="form-control" type="file" name="avatar" accept="image/*">
                    </div>
                    
                    <div class="form-group col-sm-6 text-left"> 
                        <label for="qualification" class="control-label">Highest Qualification*</label> 
                        <select id="qualification" class="form-control" name="qualification" required>
                            <option>PSLE</option>
                            <option>N' Levels</option>
                            <option>O' Levels</option>
                            <option>A' Levels</option>
                            <option>Diploma</option>
                            <option>NITEC</option>
                            <option>Higher NITEC</option>
                            <option>Degree</option>
                            <option>Others</option>
                            <option selected="selected" disabled="disabled">Please select your qualification</option>
                        </select>

                        <div class="qualification-error col-md-12 profile_error" style="display: none;">  
                            <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true" ></span>
                            Please select your qualification!
                        </div>
                    </div>

                    <div class="form-group col-sm-12 text-left"> 

                        <label for="full-name" class="control-label"><%= (currentUser.getAccountType().equals("job_seeker"))? "Full Name*": "Company Name*"%></label> 
                        <input id="full-name" class="form-control" type="text" placeholder="Name" name="username" value="<%=currentUser.getUsername()%>" required> 
                    </div>

                    <div class="form-group col-sm-12 text-left"> 
                        <label for="contactnumber" class="control-label">Contact Number*</label> 
                        <% if (currentUser.getContactNumber() == 0){ %>
                        <input id="contactnumber" class="form-control" type="text" name="contact_number" onkeypress="return isNumber(event)" required maxlength="8"> 
                        <% } else { %>
                        <input id="contactnumber" class="form-control" type="text" name="contact_number" onkeypress="return isNumber(event)" value="<%=currentUser.getContactNumber()%>" required maxlength="8"> <%}%>
                    </div>

                    <div class="form-group col-sm-12 text-left"> 
                        <label for="street-address" class="control-label">Home Address*</label> 
                        <% if (currentUser.getAddress() == null){ %>
                        <input id="street-address" class="form-control" type="text" name="address" required> 
                        <% } else { %>
                        <input id="street-address" class="form-control" type="text" name="address" value="<%=currentUser.getAddress()%>" required><%}%> 
                    </div>

                    <div class="form-group col-sm-12 text-left"> 
                        <label for="description" class="control-label">Description <small style='padding-left: 20px;'>Tell us a bit more about yourself!</small></label> 
                        <pre><textarea id="description" class="form-control" type="text" name="description" rows='3' placeholder="I am a 18 year old student from [School], and I'm really interested in working!"></textarea></pre>
                    </div>

                    <input class="btn btn-lg btn-primary btn-srad" type="submit" value="Update Profile">
                </form>
                <!-- END LEFT PANEL -->
            </div>
        </div>
    </div>

    <div class="col-sm-6">
        <div class="panel panel-default">
            <div class="panel-body">

                <form class="form form-signup" action="/UpdateUserProfileServlet" method="POST" role="form" enctype="multipart/form-data">


                    <div class="form-group col-sm-12 text-left"> 
                        <label for="old-password" class="control-label">Current Password*</label> 

                        <input id="old-password" class="form-control" type="password" placeholder="Password" name="old_password" required> 

                    </div>
                    <div class="form-group col-sm-12 text-left"> 
                        <label for="new-password" class="control-label">New Password*</label> 

                        <input id="new-password" class="form-control" type="password" placeholder="Password" name="new_password" required> 

                        <div class="password_length_error" style="display:none;">  
                            <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                            Password should contain at least 8 characters
                        </div>

                    </div>

                    <div class="form-group col-sm-12 text-left"> 
                        <label for="confirm-password" class="control-label">Confirm Password*</label> 

                        <input id="confirm-password" class="form-control" type="password" placeholder="Password" name="new_password_confirmation" required> 

                    </div>

                    <input type="hidden" name="account_type" value="job_seeker">
                    <input class="btn btn-lg btn-primary btn-srad" type="submit" value="Change Password">
                </form>
            </div>
        </div>
        
        <div class="panel panel-default">
          <div class="panel-body">
                <div class="form-group col-md-6 text-left col-md-offset-3"> 
                    <label for="referral_code" class="control-label">Referral Code</label> 
                    <input id="referral_code" class="form-control" value="<%=currentUser.getReferralID()%>" type="text" disabled> 
                </div>
                <div class="link-copied-text col-md-12" style="display: none;">  
                    <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                    Link has been copied to your clipboard!
                </div>
              <input id="referral_link_copy" class="btn btn-lg btn-warning btn-srad hidden-xs" value="Copy Referral Link">
              <a href="whatsapp://send" data-text="How are you spending this holiday? Sign up at Clockwork to find a short job now! " data-href="http://www.clockworksg.com/register_job_seeker.jsp?rf=<%=currentUser.getReferralID()%>" class="btn btn-lg btn-srad wa_btn">Share on WhatsApp</a>
          </div>
        </div>
    </div>
                    
</div>
</div>
</header>
<jsp:include page="_javascript_checker.jsp" />
<jsp:include page="_anchor.jsp" />
<jsp:include page="_footer.jsp" />

<script>
    function copyTextToClipboard(text) {
        var textArea = document.createElement("textarea");

        // Place in top-left corner of screen regardless of scroll position.
        textArea.style.position = 'fixed';
        textArea.style.top = 0;
        textArea.style.left = 0;

        // Ensure it has a small width and height. Setting to 1px / 1em
        // doesn't work as this gives a negative w/h on some browsers.
        textArea.style.width = '2em';
        textArea.style.height = '2em';

        // We don't need padding, reducing the size if it does flash render.
        textArea.style.padding = 0;

        // Clean up any borders.
        textArea.style.border = 'none';
        textArea.style.outline = 'none';
        textArea.style.boxShadow = 'none';

        // Avoid flash of white box if rendered for any reason.
        textArea.style.background = 'transparent';


        textArea.value = text;

        document.body.appendChild(textArea);

        textArea.select();

        try {
          var successful = document.execCommand('copy');
          var msg = successful ? 'successful' : 'unsuccessful';
          console.log('Copying text command was ' + msg);
        } catch (err) {
          console.log('Oops, unable to copy');
        }

        document.body.removeChild(textArea);
    }
    
    $("#referral_link_copy").on("click", function(){
        var code = $("#referral_code").val();
        var text = window.location.host.toString() + "/register_job_seeker.jsp?rf=" + code
        copyTextToClipboard(text);
        $(".link-copied-text").show();
        $("#referral_code").css("border", "1px solid #5cb85c");
    });
    
    $(document).ready(function(){
       $('#qualification').val("<%= currentUser.getQualification() %>");
       $('#description').val("<%= currentUser.getDescription() %>");
    });
</script>