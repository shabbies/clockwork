<jsp:include page="_header.jsp" />
<jsp:include page="_nav.jsp" />

<header class="main">
    <div class="header-content">

        <div class="row">


            <div class="col-md-5">
                <div class="panel panel-default">
                    <div class="panel-body db-user">

                        <div class="text-center">
                            <img src="http://placehold.it/320x150" alt="" class="col-centered img-rounded img-responsive" />
                        </div>

                        <div class="db-user-info">
                            <h2>Bellboy</h2> 
                            <h4>Join our team at Maison Ikkoku!</h4>
                            <h5>
                                Singaporeans / PRs preferred.</br>
                                Provide impeccable service and exceeding customer's expectations.</br>
                                Prepare and serve beverages</br>
                                Table setting and maintain cleanliness environment</br>
                                Take order and deliver food to customers</br>
                                Assist Manager/Supervisor in daily operational matters.
                            </h5>
                        </div>
                        <a href="/edit_post.jsp" class="btn btn-primary btn-block"><i class="fa fa-fw fa-pencil"></i> Edit Listing</a>
                    </div>
                </div>
            </div>


            <div class="col-md-7">
                <div class="panel panel-default">


                    <div class="panel-heading"> 
                        <h4>Your Applications</h4> 
                    </div> 

                    <table class="table db-job-table"> 

                        <thead> 
                            <tr> 
                                <th>Name</th>
                                <th>Rating</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>

                        <tbody> 
                            <tr> 
                                <td>Adam</td>
                                <td>4 star</td>
                                <td>Pending</td>
                                <td><button class="btn btn-success btn-hire">Hire</button></td>
                            </tr>
                            <tr> 
                                <td>Suan</td>
                                <td>3 star</td>
                                <td>Pending</td>
                                <td><button class="btn btn-success btn-hire">Hire</button></td>
                            </tr>
                            <tr> 
                                <td>Adam</td>
                                <td>4 star</td>
                                <td>Hired</td>
                                <td><a href="#" class="btn btn-warning">Message</a></td>
                            </tr>
                            <tr> 
                                <td>Suan</td>
                                <td>3 star</td>
                                <td>Pending</td>
                                <td><button class="btn btn-success btn-hire">Hire</button></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td><button class="btn btn-lg btn-primary btn-hire"><span class="badge">3</span> Hire All</button></td>
                            </tr>
                        </tbody>

                    </table>

                    
                </div> 
            </div>

            
        </div>

    </div>
</header>


<!-- Hire Modal -->
<div class="modal fade" id="hireModal" tabindex="-1" role="dialog" aria-labelledby="hireModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>

    </div>
    <div class="modal-body payment-mode text-center">

     <h4>Choose your preferred mode of payment</h4>

     <button class="btn btn-lg btn-primary">Credit Card</button>
     <button class="btn btn-lg btn-primary">iBanking</button>
     <button class="btn btn-lg btn-primary">Paypal</button>
 </div>
 <div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
</div>
</div>
</div>
</div>

<script>

$(document).on("click", ".btn-hire", function() {
    $('#hireModal').modal('show');
});
</script>
<!-- End of Hire Modal -->


<jsp:include page="_javascript_checker.jsp" />
<jsp:include page="_footer.jsp" />