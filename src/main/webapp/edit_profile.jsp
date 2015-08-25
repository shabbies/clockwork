<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>

<!-- Initialising Google Places for location autofill -->
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true&libraries=places"></script>
<script>
function initialize() {
  var input = /** @type {HTMLInputElement} */(
    document.getElementById('street-address'));

  var autocomplete = new google.maps.places.Autocomplete(input);
  autocomplete.bindTo('bounds', map);

  google.maps.event.addListener(autocomplete, 'place_changed', function() {
    infowindow.close();
    marker.setVisible(false);
    var place = autocomplete.getPlace();
    if (!place.geometry) {
      window.alert("Autocomplete's returned place contains no geometry");
      return;
    }
    infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address);
    infowindow.open(map, marker);
  });
}

google.maps.event.addDomListener(window, 'load', initialize);
</script>
<!-- END -->

<header class="main">
  <div class="header-content">
    <div class="header-content-inner">
      <div class="row profile-div">

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

        <div class="col-sm-6">

          <div class="panel panel-default">
            <div class="panel-body">

              <form class="form form-signup" action="/UpdateUserProfileServlet" method="POST" role="form" enctype="multipart/form-data">

              <div class="text-center">
                <% if (currentUser.getAvatar() == null){%>
                <img src="img/user-placeholder.jpg" alt="" class="db-user-pic modal-pic col-centered img-rounded img-responsive" />
                <% } else { %>
                <img src="<%=currentUser.getAvatar()%>" alt="" class="db-user-pic modal-pic col-centered img-rounded img-responsive" />
                <% } %>
              </div>


              <div class="form-group col-sm-12 text-left"> 

                <label for="full-name" class="control-label"><%= (currentUser.getAccountType().equals("job_seeker"))? "Full Name*": "Company Name*"%></label> 
                <input id="full-name" class="form-control" type="text" placeholder="Name" name="username" value="<%=currentUser.getUsername()%>" required> 
              </div>

              <div class="form-group col-sm-12 text-left"> 
                <label for="contactnumber" class="control-label">Contact Number</label> 
                <% if (currentUser.getContactNumber() == 0){ %>
                <input id="contactnumber" class="form-control" type="text" name="contact_number"> 
                <% } else { %>
                <input id="contactnumber" class="form-control" type="text" name="contact_number" value="<%=currentUser.getContactNumber()%>" > <%}%>
              </div>

              <div class="form-group col-sm-12 text-left"> 
                <label for="street-address" class="control-label">Street Address</label> 
                <% if (currentUser.getAddress() == null){ %>
                <input id="street-address" class="form-control" type="text" name="address"> 
                <% } else { %>
                <input id="street-address" class="form-control" type="text" name="address" value="<%=currentUser.getAddress()%>"><%}%> 
              </div>
              
              <div class="form-group col-sm-12 text-left"> 
                <label for="avatar" class="control-label">Profile Picture</label> 
                <input id="avatar" class="form-control" type="file" name="avatar" accept="image/*">
              </div>

              <% if(currentUser.getAccountType().equals("job_seeker")){%>

              <div class="form-group col-sm-12 text-left"> 
               <label for="dob-date" class="control-label">Date of Birth</label> 
               <div class="input-group"> 
                 <div class="input-group-addon"><i class="fa fa-calendar fa-lg fa-fw"></i></div> 
                 <% if (currentUser.getDateOfBirth() == null){ %>
                 <input id="dob-date" class="form-control" type="date" name="dob_date" > 
                 <% } else { %>
                 <input id="dob-date" class="form-control" type="date" name="dob_date" value="<%=currentUser.getDateOfBirthString()%>"> <% } %>
               </div> 
             </div>

             <% } %>

             <input class="btn btn-lg btn-primary btn-srad" type="submit" value="Update Profile">
           </form>
         </div>
       </div>
     </div>

     <div class="col-sm-6">
      <div class="panel panel-default">
        <div class="panel-body">

          <form class="form form-signup" action="/RegisterAccountServlet" method="POST" role="form">


            <div class="form-group col-sm-12 text-left"> 
              <label for="old-password" class="control-label">Current Password</label> 

              <input id="old-password" class="form-control" type="password" placeholder="Password" name="password" required> 

            </div>
            <div class="form-group col-sm-12 text-left"> 
              <label for="new-password" class="control-label">New Password</label> 

              <input id="new-password" class="form-control" type="password" placeholder="Password" name="password" required> 

              <div class="password_length_error" style="display:none;">  
                <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                Password should contain at least 8 characters
              </div>

            </div>

            <div class="form-group col-sm-12 text-left"> 
              <label for="confirm-password" class="control-label">Confirm Password</label> 

              <input id="confirm-password" class="form-control" type="password" placeholder="Password" name="password" required> 

            </div>

            <input type="hidden" name="account_type" value="job_seeker">
            <input class="btn btn-lg btn-primary btn-srad" type="submit" value="Change Password">
          </form>
        </div>
      </div>

      <div class="panel panel-default">
        <div class="panel-body">

          <form class="form form-signup" action="/RegisterAccountServlet" method="POST" role="form">

            <div class="form-group col-sm-6 text-left"> 
              <label for="paypal-full-name" class="control-label">Full Name</label> 

              <input id="paypal-full-name" class="form-control" type="text" placeholder="Name" name="username" required> 

            </div>

            <div class="form-group col-sm-6 text-left"> 
              <label for="paypal-email" class="control-label">Paypal Email</label> 

              <input id="paypal-email" class="form-control" type="email" placeholder="Email address" name="email" required> 

            </div>

            <input type="hidden" name="account_type" value="job_seeker">
            <input class="btn btn-lg btn-primary btn-srad" type="submit" value="Update Payment Details">
          </form>
        </div>
      </div>
    </div>



  </div>
</div>
</div>

</div>
</header>
<jsp:include page="_javascript_checker.jsp" />
<jsp:include page="_footer.jsp" />