<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>

<%@ page import="model.User"%>
<%@ page import="model.Post"%>
<%@ page import="java.util.ArrayList" %>

<%  String postID = request.getParameter("id");
ArrayList <User> applicantList = (ArrayList <User>)session.getAttribute("applicantList");
ArrayList <User> hiredList = (ArrayList <User>)session.getAttribute("hiredList");
String formURL = "/GetPostServlet?id=" + postID + "&location=listing";
Post post = (Post)session.getAttribute("post");
if (post == null){%>
<jsp:forward page="<%=formURL%>" />
<%} else { session.removeAttribute("post"); session.removeAttribute("applicantList"); session.removeAttribute("hiredList");}%>

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
                            <h2><%=post.getHeader()%></h2> 
                            <h5><%=post.getDescription()%></h5>
                            <form action="https://www.sandbox.paypal.com/cgi-bin/webscr" method="post" target="_top" id="paypalform" hidden>
                                <input type="hidden" name="cmd" value="_s-xclick">
                                <input type="hidden" name="hosted_button_id" value="UYF4VPUSPPGMY">
                                <input type="image" src="https://www.sandbox.paypal.com/en_US/i/btn/btn_buynow_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
                                <input type="hidden" name="item_name" value="Payment for Wages">
                                <input type="hidden" name="amount" value="100.00">
                                <img alt="" border="0" src="https://www.sandbox.paypal.com/en_US/i/scr/pixel.gif" width="1" height="1">
                            </form>
                        </div>
                    </div>
                </div>
            </div>


            <div class="col-md-7">
                <div class="panel panel-default">

                    <div class="panel-heading"> 
                        <h4>Your Applications</h4> 
                    </div> 

                    <% if (post.getStatus().equals("applied")) { %>

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
                            <% if (applicantList != null){
                            for (User user : applicantList){ %>
                            <tr> 
                                <td><%=user.getUsername()%></td>
                                <td><div class="ratings" data-score="4"></div></td>
                                <td>Pending</td>
                                <td><button class="btn btn-success btn-hire" data-userid="<%=user.getId()%>" data-postid="<%=postID%>">Hire</button></td>
                            </tr>
                            <%}%>
                            <%}%>    
                            <% if (hiredList != null){
                            for (User user : hiredList){ %>
                            <tr> 
                                <td><%=user.getUsername()%></td>
                                <td><div class="ratings" data-score="4"></div></td>
                                <td>Hired</td>
                                <td><a href="#" class="btn btn-warning btn-viewprofile">View Profile</a></td>
                            </tr>
                            <%}%>
                            <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td><button class="btn btn-lg btn-primary btn-hire"><span class="badge"><%=applicantList.size()%></span> Hire All</button></td>
                            </tr>
                            <% } %>
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
                                <td><div id="rating_changethistohisid" class="score" data-score="4"></div></td>
                                <td><button class="btn btn-success btn-comment">Leave Comment</button></td>
                            </tr>
                            <tr> 
                               <td>Susan</td>
                               <td>Completed</td>
                               <td><div id="rating_changethistohisid" class="score" data-score="3"></div></td>
                               <td><button class="btn btn-success btn-comment">Leave Comment</button></td>
                           </tr>
                           <tr> 
                            <td>David</td>
                            <td>Completed</td>
                            <td><div id="rating_changethistohisid" class="score" data-score="0"></div></td>
                            <td><button class="btn btn-success btn-comment">Leave Comment</button></td>
                        </tr>
                        <tr> 
                            <td>Steve</td>
                            <td>Completed</td>
                            <td><div id="rating_changethistohisid" class="score" data-score="0"></div></td>
                            <td><button class="btn btn-success btn-comment">Leave Comment</button></td>
                        </tr>
                        <tr> 
                            <td>Malcom</td>
                            <td>Completed</td>
                            <td><div id="rating_changethistohisid" class="score" data-score="0"></div></td>
                            <td><button class="btn btn-success btn-comment">Leave Comment</button></td>
                        </tr>

                    </tbody>

                </table>

                <a href="#" class="btn btn-primary btn-lg btn-rate">Submit My Ratings</a>

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

       <form action="/HireUserServlet" method="POST" class="display-inline"/>
       <input type="text" id="form_user_id" name="applicant_id" hidden />
       <input type="text" id="form_post_id" name="post_id" hidden />
       <input type="submit" class="btn btn-lg btn-primary" value="Credit Card" />
   </form>
   <button class="btn btn-lg btn-primary">iBanking</button>
   <button class="btn btn-lg btn-primary" onclick="submitPaypalForm();">Paypal</button>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
</div>
</div>
</div>
</div>

<script>

$(document).on("click", ".btn-hire", function() {
    var userID = $(this).data("userid");
    var postID = $(this).data("postid");
    
    $("#form_user_id").val(userID);
    $("#form_post_id").val(postID);
    $('#hireModal').modal('show');
});

function submitPaypalForm(){
  $("#paypalform").submit();  
};
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

$(document).on("click", ".btn-rate", function() {

    var scores = new Array();
    $('.score').each(function() {
        var id = this.id;
        var currentScore = $(this).raty('score');
        scores.push(id+":"+currentScore);

    });
    console.log(scores);

});
</script>


<script>
$.fn.raty.defaults.path = '../rating/images';
$(function() {
    $('.score').raty({
      score: function() {
        return $(this).attr('data-score');
    }
});
    $('.ratings').raty({
      score: function() {
        return $(this).attr('data-score');
    },readOnly: true
});
    
});
</script>



<jsp:include page="_javascript_checker.jsp" />
<jsp:include page="_footer.jsp" />