<jsp:include page="_header.jsp" />

<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Post"%>

<%  ArrayList <Post> postList = (ArrayList <Post>)session.getAttribute("postList"); 
    if (postList == null){%><jsp:forward page="/GetAllPostsServlet" /><%}%>

<jsp:include page="_nav.jsp" />
<jsp:include page="_hero.jsp" />

<section id="jobs" ng-controller="jobListCtrl">
    <div class="job-search text-center">

        <div class="container">
            <form id="searchForm">
                <div class="input-group input-group-lg stylish-input-group">
                    <input type="text" class="form-control" id="searchText" autocomplete="off" placeholder="search keyword...">
                    <span class="input-group-btn">
                        <button class="btn btn-primary" type="button"> FIND JOBS <span class="glyphicon glyphicon-search"></span></button>
                    </span>
                </div>
            </form>
        </div>
    </div>
    <div class="container">

        <div class="col-lg-12 search-label"> 
            <h3>Search Results for "<span>goodie bag</span>"</h3>                             
        </div>

        <%for (Post post : postList){%>

        <div class="col-lg-4">

            <div class="job-entry">

                <div class="row">
                    <div class="col-lg-9">
                        <h4><%=post.getHeader()%></h4>
                    </div>
                    <span class="job-entry-price pull-right primary"><strong>$<%=post.getSalary()%>/hr</strong></span>
                </div>

                <div class="row">
                    <div class="col-lg-12">
                        <h5><%=post.getDescription()%></h5>
                    </div>
                </div>

                <div class="row job-entry-apply" id="open-jobModal" data-header="<%= post.getHeader()%>" data-desc="<%=post.getDescription()%>" data-salary="$<%=post.getSalary()%>/hr">
                       <div class="col-md-6"> 
                        <div class="detailIconsDiv">
                            <ul class="list-inline text-left">
                                <li class="detailIcons"><a href="#" class="whitelink"><i class="fa fa-dollar"></i></a></li>
                                <li class="detailIcons"><a href="#" class="whitelink"><i class="fa fa-cutlery"></i></a></li>
                                <li class="detailIcons"><a href="#" class="whitelink"><i class="fa fa-compass"></i></a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <a href="#"  class="btn btn-primary btn pull-right">Apply now <i class="fa fa-check"></i></a>
                    </div>

                </div>

            </div>

        </div>

        <%}%>

    </div>

</section>

<hr class="grey">
<footer>
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <span class="copyright">Copyright © Clockwork 2015</span>
            </div>
            <div class="col-md-4">
                <ul class="list-inline social-buttons text-center">
                    <li><a href="#"><i class="fa fa-twitter"></i></a>
                    </li>
                    <li><a href="#"><i class="fa fa-facebook"></i></a>
                    </li>
                    <li><a href="#"><i class="fa fa-linkedin"></i></a>
                    </li>
                </ul>
            </div>
            <div class="col-md-4">
                <ul class="list-inline quicklinks pull-right">
                    <li><a href="#">Privacy Policy</a>
                    </li>
                    <li><a href="#">Terms of Use</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</footer>



<!-- Job Modal -->
<div class="modal fade" id="jobModal" tabindex="-1" role="dialog" aria-labelledby="jobModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>

    </div>
    <div class="modal-body">
     <h4 id="modalHeader"></h4>
     <h5 id="modalDesc"></h5>
     <h5 id="modalSalary"></h5>
 </div>
 <div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
    <button type="button" class="btn btn-primary">Apply</button>
</div>
</div>
</div>
</div>

<script>
$(document).on("click", "#open-jobModal", function() {
    var headerText = $(this).data('header');
    var descText = $(this).data('desc');
    var salaryText = $(this).data('salary');

    $('#jobModalLabel').html(headerText);
    $('#modalHeader').html(headerText);
    $('#modalDesc').html(descText);
    $('#modalSalary').html(salaryText);

    $('#jobModal').modal('show');
});
</script>
<!-- End of Job Modal -->



<jsp:include page="_footer.jsp" />






