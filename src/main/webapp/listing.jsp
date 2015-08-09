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
                                Lorem ipsum dolor sit amet, consectetur adipisicing elit. Molestias harum, sunt nulla, temporibus labore vitae sequi, quidem enim facere saepe eum ducimus magnam fugiat neque pariatur odit laboriosam soluta non.
                            </h5>
                        </div>
                        <% if (request.getParameter("completed") == null) { %>
                        <a href="/edit_post.jsp" class="btn btn-primary btn-block"><i class="fa fa-fw fa-pencil"></i> Edit Listing</a>
                        <% } %>
                    </div>
                </div>
            </div>


            <div class="col-md-7">
                <div class="panel panel-default">

                    <div class="panel-heading"> 
                        <h4>Your Applications</h4> 
                    </div> 

                    <% if (request.getParameter("completed") == null) { %>

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

                    <% } else { %>


                    <table class="table db-job-table"> 

                        <thead> 
                            <tr> 
                                <th>Name</th>
                                <th>Status</th>
                                <th>Choose Rating</th>
                                <th>Leave a Review</th>
                            </tr>
                        </thead>

                        <tbody> 
                            <tr> 
                                <td>Adam</td>
                                <td>Completed</td>
                                <td><div class="score" data-score="4"></div></td>
                                <td><button class="btn btn-success btn-comment">Leave Comment</button></td>
                            </tr>
                            <tr> 
                             <td>Susan</td>
                             <td>Completed</td>
                             <td><div class="score" data-score="3"></div></td>
                             <td><button class="btn btn-success btn-comment">Leave Comment</button></td>
                         </tr>
                         <tr> 
                            <td>David</td>
                            <td>Completed</td>
                            <td><div class="score" data-score="0"></div></td>
                            <td><button class="btn btn-success btn-comment">Leave Comment</button></td>
                        </tr>
                         <tr> 
                            <td>Steve</td>
                            <td>Completed</td>
                            <td><div class="score" data-score="0"></div></td>
                            <td><button class="btn btn-success btn-comment">Leave Comment</button></td>
                        </tr>
                         <tr> 
                            <td>Malcom</td>
                            <td>Completed</td>
                            <td><div class="score" data-score="0"></div></td>
                            <td><button class="btn btn-success btn-comment">Leave Comment</button></td>
                        </tr>

                    </tbody>

                </table>

                <a href="/edit_profile.jsp" class="btn btn-primary btn-lg">Submit My Ratings</a>

                <% } %>

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




<!-- Comment Modal -->
<div class="modal fade" id="commentModal" tabindex="-1" role="dialog" aria-labelledby="commentModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>

    </div>
    <div class="modal-body payment-mode text-center">

     <h4>Leave a comment</h4>

     <textarea class="form-control" style="min-width: 100%"></textarea>
 </div>
 <div class="modal-footer">
   <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
   <button type="button" class="btn btn-primary">Submit</button>
</div>
</div>
</div>
</div>

<script>

$(document).on("click", ".btn-comment", function() {
    $('#commentModal').modal('show');
});
</script>
<!-- End of Hire Modal -->


<script>

$.fn.raty.defaults.path = '../rating/images';

$(function() {

    $('.score').raty({
      score: function() {
        return $(this).attr('data-score');
    }
});
});
</script>



<jsp:include page="_javascript_checker.jsp" />
<jsp:include page="_footer.jsp" />