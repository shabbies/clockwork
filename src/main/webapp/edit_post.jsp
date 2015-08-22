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

               <div class="form-group form-group-lg col-md-7 text-left"> 
                 <label for="job-date" class="control-label">Job Date</label> 
                 <div class="input-group"> 
                   <div class="input-group-addon"><i class="fa fa-calendar fa-lg fa-fw"></i></div> 
                   <input id="job-date" class="form-control" type="date" name="job_date" value="<%=post.getJobDateStringForInput()%>" required> 
                 </div> 
               </div>

               <div class="form-group form-group-lg col-md-5 pull-right text-left"> 
                 <label for="job-pay" class="control-label">Pay</label> 
                 <div class="input-group"> 
                   <div class="input-group-addon"><i class="fa fa-dollar fa-lg fa-fw"></i></div> 
                   <input id="job-pay" class="form-control" type="number" name="salary" value="<%=post.getSalary()%>" min="0" required> 
                   <div class="input-group-addon" style="font-weight:600;"> / Hr</div> 
                 </div> 
               </div>

               <input type="submit" class="btn btn-lg btn-primary btn-srad" value="Update Listing"/>

             </form>
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
</header>

<jsp:include page="_footer.jsp" />
