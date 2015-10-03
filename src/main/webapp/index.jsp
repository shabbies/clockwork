<%@include file="_header.jsp"%>

<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Post"%>
<%@ page import="java.util.Date"%>

<%  ArrayList <Post> postList = (ArrayList <Post>)session.getAttribute("postList"); 
if (postList == null){ %>
<jsp:forward page="/GetAllPostsServlet?order=none" />
<% } else { 
    session.removeAttribute("postList"); 
    session.setAttribute("postListUnsorted", postList);
}
String query = (request.getParameter("q") != null) ? request.getParameter("q") : "";%>

<%@include file="_nav.jsp"%>
<%@include file="_hero.jsp"%>
<%@include file="_job_details.jsp"%>

<section id="jobs">
    
<div class="job-search text-center">
    <div class="container">
        <form id="searchForm" action="/SearchPostServlet" method="GET">
            <div class="input-group input-group-lg stylish-input-group">
                <input type="search" class="form-control" id="searchText" autocomplete="off" placeholder="search keyword..." name="query" value="<%=query%>"/>
                <span class="input-group-btn search_cross_on_focus hidden search_cross">
                    <i class="fa fa-times-circle-o hidden" id="search_clear"></i>
                    <i class="fa fa-times-circle" id="search_cross"></i>
                </span>
                <span class="input-group-btn">
                    <input type="submit" class="btn btn-primary" value="FIND JOBS"/>
                </span>
            </div> 
        </form>
    </div>
</div>
                
<div class="container">
<div class="row search-label">
    <div class="row-same-height">
        <div class="col-lg-8 col-sm-height col-bottom"> 
            <% if (!query.isEmpty()){ %>
            <h3 class=""><label><cite>Search Results for </cite>'<span><%=query%></span>'</label></h3> 
            <div class="sortlink col-md-11 text-right"><a href="/index.jsp" class="display-inline">Back to all results</a></div>
            <% } else {%>
            <h3><cite>Featured Job Listings</cite></h3>           
            <% } %>
        </div>
        <div class="col-lg-4 col-sm-height col-bottom"> 
            <% if (postList.size() != 0){ %>
            <h5 class="pull-right sortlink">Sort by 
                <a href="/GetAllPostsServlet?order=oldest">OLDEST</a>  
                <a href="/GetAllPostsServlet?order=latest">LATEST</a>
                <a href="/GetAllPostsServlet?order=salary">SALARY</a>
            </h5>
            <% } %>
        </div>


    </div>  
</div>       

<% 
if (postList.size() != 0){
for (Post post : postList){
  Date jobDate = post.getJobDate(); 
String jobDateString = jobDate.toString();
%>

<div class="col-lg-4">

    <%  String jobEditStyle = "", jobStyle = "", jobEditColor = "", ownjob = "", currentuserid="";
        if(currentUser != null){
            currentuserid = String.valueOf(currentUser.getId());
                if(currentUser.getUsername().equals(post.getCompany())){
                jobEditStyle =  "job-edit";
                jobStyle =  "job-entry-edit";
                jobEditColor = "job-edit-color";
                ownjob = "true";
            }
        } %> 

    <div class="job-entry <%=jobEditStyle%>">
        <div class="job-entry-desc">
            <div class="row">
                <div class="col-xs-9">
                    <h4><strong><%=post.getHeader()%></strong></h4>
                    <h5><%=post.getCompany()%>
                    </h5>
                    <h5>
                        <i class="fa fa-map-marker primary"></i> 
                        <%=post.getLocation()%>
                    </h5>
                </div>
                <span class="job-entry-price pull-right primary <%= jobEditColor %>">
                    <% String salary = "$" + post.getSalary();
                        if (post.getPayType().equals("hour")){
                            salary += " / hr";
                        } else {
                            salary += " / day";
                        }%>
                    <strong><%=salary%></strong>
                </span>
            </div>

            <div class="row">
                <div class="col-xs-12">
                    <h5 class="font-normal"><%=post.getDescription()%></h5>
                </div>
            </div>
        </div>


        <div class="row job-entry-apply <%=jobStyle%> open-job-modal" data-userid="<%= currentuserid %>" data-jobstatus="<%= post.getStatus() %>" data-ownjob="<%= ownjob %>" data-header="<%= post.getHeader()%>" data-desc="<%=post.getDescription()%>" data-salary="<%=salary%>" data-company="<%=post.getCompany()%>" data-location="<%=post.getLocation()%>" data-dateposted="<%=post.getJobDateString()%>" data-enddate="<%=post.getEndDateString()%>" data-cdate="<%=post.getJobDateStringForInput()%>" data-cdateend="<%=post.getJobEndDateStringForInput()%>" data-id="<%=post.getId()%>" data-avatar="<%=post.getAvatarPath()%>" data-starttime="<%=post.getStartTime()%>" data-endtime="<%=post.getEndTime()%>">

            <!--
            <div class="col-xs-6"> 
                <div class="detailIconsDiv">
                    <ul class="list-inline text-left">
                        <li class="detailIcons"><a href="#" class="whitelink"><i class="fa fa-dollar"></i></a></li>
                        <li class="detailIcons"><a href="#" class="whitelink"><i class="fa fa-cutlery"></i></a></li>
                        <li class="detailIcons"><a href="#" class="whitelink"><i class="fa fa-compass"></i></a></li>
                    </ul>
                </div>
            </div>
            -->

            <div class="col-xs-12">

                <% if(currentUser==null){ %>
                <button class="btn open-job-modal btn-primary btnnohover pull-right">Apply now</button>
                <%} else { %>
                <% if(!currentUser.getUsername().equals(post.getCompany())){ 
    if(currentUser.getAccountType().equals("job_seeker")){%>

                <button class="btn open-job-modal btn-primary btnnohover pull-right">Apply now</button>
                <% }else{ %>

                <%  } %>

                <% } else { 
    if(post.getStatus().equals("listed")){%>
                <a href="/edit_post.jsp?id=<%= post.getId() %>" class="btn btn-warning btnnohover pull-right">Edit Job</a>

                <% }
} %>
                <% } %>
            </div>
        </div>
    </div>
</div>
<% } 
} else { %>
<h4 class="col-md-12 text-center">Oops there are no results!</h4>
<% }%>
</div> 
</section>

<hr class="grey">
<footer>
    <div class="container">
        <div class="row">
            <div class="col-md-4 col-xs-4">
                <span class="copyright">Copyright © Clockwork 2015</span>
            </div>
            <div class="col-md-4 col-xs-4">
                <ul class="list-inline social-buttons text-center">
                    <li><a href="#"><i class="fa fa-twitter"></i></a>
                    </li>
                    <li><a href="#"><i class="fa fa-facebook"></i></a>
                    </li>
                    <li><a href="#"><i class="fa fa-linkedin"></i></a>
                    </li>
                </ul>
            </div>
            <div class="col-md-4 col-xs-4">
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

<script>

    $(document).ready(function() {
    
        if($("#searchText").val() !== ""){
            $("#searchText").addClass("calculated_search_text");
            $(".search_cross").removeClass("hidden");
            $(".search_cross").addClass("search_cross_off_focus");
        }

        $(".job-entry-desc").dotdotdot({
            /*  The text to add as ellipsis. */
            ellipsis    : '... ',
            /*  How to cut off the text/html: 'word'/'letter'/'children' */
            wrap        : 'word',
            /*  Wrap-option fallback to 'letter' for long words */
            fallbackToLetter: true,
            /*  jQuery-selector for the element to keep and put after the ellipsis. */
            after       : null,
            /*  Whether to update the ellipsis: true/'window' */
            watch       : false,
            /*  Optionally set a max-height, if null, the height will be measured. */
            height      : null,
            /*  Deviation for the height-option. */
            tolerance   : 0,
            /*  Callback function that is fired after the ellipsis is added,
        receives two parameters: isTruncated(boolean), orgContent(string). */
            callback    : function( isTruncated, orgContent ) {},
            lastCharacter   : {
                /*  Remove these characters from the end of the truncated text. */
                remove      : [ ' ', ',', ';', '.', '!', '?' ],
                /*  Don't add an ellipsis if this array contains 
            the last character of the truncated text. */
                noEllipsis  : []
            }
        });

    });


    $(function() {
        $('.job-entry').hover(function() {
            if($(this).hasClass("job-edit")){
                $(this).find(".job-entry-apply").css( "background-color", "#f0ad4e"); 
            }else{
                $(this).find(".job-entry-apply").css( "background-color", "#ee4054"); 
            }
            $(this).find("a").removeClass("whitelink"); 

        }, function() {
            $(this).find( ".job-entry-apply").css( "background-color", "") 
            $(this).find("a").addClass("whitelink"); 
        });
    });

    // SEARCH BAR JS / CSS

    $("#search_clear").click(function(){
        $("#searchText").val('');
        $("#searchText").removeClass("calculated_search_text");
        $(".search_cross").addClass("hidden");
    <% if (!query.isEmpty()) { %>
            window.location.href = "/index.jsp";
    <% } %>
        });

        $("#search_cross").hover(function(){
            $(this).addClass("hidden");
            $("#search_clear").removeClass("hidden");
        });

        $("#search_clear").hover(function(){}, function(){
            $("#search_cross").removeClass("hidden");
            $("#search_clear").addClass("hidden");
        });

        $("#searchText").keyup(function(){
            $(this).addClass("calculated_search_text");
            $(".search_cross").removeClass("hidden");
            if ($(this).val() === ""){
                $(this).removeClass("calculated_search_text");
                $(".search_cross").addClass("hidden");
            }
        });

        $("#searchText").focusout(function(){
            $(".search_cross").removeClass("search_cross_on_focus");
            $(".search_cross").addClass("search_cross_off_focus");
        });

        $("#searchText").focus(function(){
            $(".search_cross").addClass("search_cross_on_focus");
            $(".search_cross").removeClass("search_cross_off_focus");
        });

        // END SEARCH BAR CSS / JS

        //AJAX FOR SEARCHING (FOR BOOKMARKING)

</script>


<jsp:include page="_footer.jsp" />






