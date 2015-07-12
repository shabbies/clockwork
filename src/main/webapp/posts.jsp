<jsp:include page="_header.jsp" />

<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Post"%>

<% ArrayList <Post> postList = (ArrayList <Post>)session.getAttribute("postList"); %>

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

    <div class="main">
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

                    <div class="row job-entry-apply">
                        <a href="" class="btn btn-primary btn pull-right">Apply now <i class="fa fa-check"></i></a>
                    </div>

                </div>

            </div>

            <%}%>

        </div>
    </div>

</section>


<jsp:include page="_footer.jsp" />






