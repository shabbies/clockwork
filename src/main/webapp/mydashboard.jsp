<jsp:include page="_header.jsp" />
<jsp:include page="_nav.jsp" />

<header class="main">
    <div class="header-content">

        <div class="row">
            <div class="col-md-8">
                <div class="panel panel-default">


                    <div class="panel-heading"> 
                        <h4>Jobs you have applied for</h4> 
                    </div> 

                    <table class="table db-job-table"> 

                        <thead> 
                            <tr> 
                                <th>Job</th>
                                <th>Company</th>
                                <th>Status</th>
                                 <th>Action</th>
                            </tr>
                        </thead>

                        <tbody> 
                            <tr> 
                                <td>Bellboy</td>
                                <td>ABC Company</td>
                                <td><span class="badge db-default-badge">Pending</span></td>
                                <td><a href="#" class="btn btn-primary">Withdraw</a></td>
                            </tr>
                            <tr> 
                                <td>Bellboy</td>
                                <td>CDE Company</td>
                                <td><span class="badge db-default-badge success">Accepted</span></td>
                                <td><a href="#" class="btn btn-warning"> Message</a></td>
                               
                            </tr>
                        </tbody>

                    </table>

                    <div>
                        <a href="/index.jsp" class="btn btn-primary"><i class="fa fa-fw fa-plus"></i> Search for a Job</a>
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
                            <h2>Hi User!</h2> 
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