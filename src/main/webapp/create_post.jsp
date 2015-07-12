<jsp:include page="_header.jsp" />
<jsp:include page="_nav.jsp" />

<header class="main">
  <div class="header-content">
    <div class="header-content-inner">
      <h2 class="text-center">Let's Create a new listing!</h2>

      <div class="row">
        <div class="col-md-6 col-md-offset-3">
          <div class="panel panel-default">
            <div class="panel-body">
              <form class="form form-signup" action="/CreatePostServlet" method="POST" role="form">

                <div class="form-group form-group-lg col-md-12 text-left"> 
                 <label for="job-title" class="control-label">Job Title</label> 
                 <input id="job-title" class="form-control" type="text" placeholder="" name="header" required> 
               </div>

               <div class="form-group col-md-12 text-left"> 
                 <label for="job-desc" class="control-label">Job Description</label> 
                 <textarea id="job-desc" class="form-control form-group-lg" rows="3" name="description" rows="3" required></textarea> 
               </div>

               <div class="form-group form-group-lg col-md-12 text-left"> 
                 <label for="job-pay" class="control-label">Job Location</label> 
                 <input id="job-pay" class="form-control" type="text" placeholder="" name="location" required>  
               </div>

               <div class="form-group form-group-lg col-md-6 text-left"> 
                 <label for="job-pay" class="control-label">Job Date</label> 
                 <div class="input-group"> 
                   <div class="input-group-addon"><i class="fa fa-calendar fa-lg fa-fw"></i></div> 
                   <input id="job-pay" class="form-control" type="text" placeholder="" name="job_date" required> 
                 </div> 
               </div>

               <div class="form-group form-group-lg col-md-6 text-left"> 
                 <label for="job-pay" class="control-label">Pay</label> 
                 <div class="input-group"> 
                   <div class="input-group-addon"><i class="fa fa-dollar fa-lg fa-fw"></i></div> 
                   <input id="job-pay" class="form-control" type="number" placeholder="" name="salary" required> 
                 </div> 
               </div>

               <input type="submit" class="btn btn-lg btn-primary" value="Create Listing"/>

             </form>
           </div>
         </div>
       </div>
     </div>
   </div>
 </div>
</header>

<jsp:include page="_footer.jsp" />
