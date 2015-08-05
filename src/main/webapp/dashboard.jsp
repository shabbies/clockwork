<jsp:include page="_header.jsp" />
<jsp:include page="_nav.jsp" />

<header class="main">
    <div class="header-content">
        <div class="header-content-inner">

            <div class="row">
                <div class="col-md-8">
                    <div class="panel panel-default">


                        <div class="panel-heading"> 
                            <h4 class="panel-title">Your Applications</h4> 
                        </div> 

                        <table class="table"> 

                            <thead> 
                                <tr> 
                                    <th>Job</th>
                                    <th>Company</th>
                                    <th>Job Type</th>
                                    <th>Status</th>
                                </tr>
                            </thead>

                            <tbody> 

                            </tbody>

                        </table>
                        <div class="message">There are no applications.</div> 
                        <div><a href="/dashboard/jobs?page=1"><i class="fa fa-fw fa-plus"></i> Add a New Listing</a></div> </div> 
                    </div>

                    
                    

                    <div class="col-md-4">
                        <div class="panel panel-default">
                            <div class="panel-body">


                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <jsp:include page="_javascript_checker.jsp" />
    <jsp:include page="_footer.jsp" />