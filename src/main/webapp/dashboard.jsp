<jsp:include page="_header.jsp" />
<jsp:include page="_nav.jsp" />

<header class="main">
    <div class="header-content">

        <div class="row">
            <div class="col-md-8">
                <div class="panel panel-default">


                    <div class="panel-heading"> 
                        <h4>Your Job Listings</h4> 
                    </div> 

                    <table class="table db-job-table"> 

                        <thead> 
                            <tr> 
                                <th>Job</th>
                                <th>Date</th>
                                <th>Status</th>
                                 <th>Action</th>
                            </tr>
                        </thead>

                        <tbody> 
                            <tr> 
                                <td>Bellboy</td>
                                <td>20/08/2015</td>
                                <td><span class="badge db-default-badge">No Applicants</span></td>
                                <td><a href="/edit_post.jsp" class="btn btn-warning">Edit Job</a></td>
                            </tr>
                            <tr> 
                                <td>Bellboy</td>
                                <td>21/08/2015</td>
                                <td><span class="badge db-default-badge">Ongoing</span></td>
                                <td><a href="/listing.jsp" class="btn btn-primary"> <span class="badge">4</span> Click to Hire</a></td>
                               
                            </tr>
                             <tr> 
                                <td>Bellboy</td>
                                <td>18/08/2015</td>
                                <td><span class="badge db-default-badge">Completed</span></td>
                                <td><a href="/listing.jsp?completed=true" class="btn btn-success"> Click to Review</a></td>
                               
                            </tr>
                        </tbody>

                    </table>

                    <div>
                        <a href="/create_post.jsp" class="btn btn-primary"><i class="fa fa-fw fa-plus"></i> Add a New Listing</a>
                    </div>
                </div> 
            </div>

            <div class="col-md-4">
                <div class="panel panel-default">
                    <div class="panel-body db-user">

                        <div class="text-center">
                            <img src="http://placehold.it/120x120" alt="" class="db-user-pic col-centered img-rounded img-responsive" />
                        </div>

                        <div class="db-user-info">
                            <h2>Hi <%=currentUser.getUsername()%>!</h2> 
                            <span>What would you like to do today?</span>
                        </div>
                        <a href="/edit_profile.jsp" class="btn btn-primary btn-block"><i class="fa fa-fw fa-plus"></i> Complete my Profile</a>
                    </div>
                </div>
            </div>
        </div>

    </div>
</header>
<jsp:include page="_footer.jsp" />