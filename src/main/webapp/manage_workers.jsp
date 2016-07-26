<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>
<%@include file="_only_emp.jsp"%>
<jsp:include page="_user_profile.jsp" />
    
<%@ page import="model.User"%>
<%@ page import="model.Post"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.TimeZone" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%@ page buffer="32kb" %>
<%  String postID = request.getParameter("id");
appController = (AppController)session.getAttribute("appController");
ArrayList <User> hiredList = (ArrayList <User>)session.getAttribute("hiredList");
String formURL = "/GetPostServlet?id=" + postID + "&location=manage";
Post post = (Post)session.getAttribute("post");
if (session.getAttribute("post") == null){ %>
<jsp:forward page="<%=formURL%>" />
<% } else { 
session.removeAttribute("post"); 
session.removeAttribute("hiredList");}%>
<header class="main">
<div class="header-full-content">
    
<%@include file="_message.jsp"%>

<div class="row">
    
<div class="col-md-4">
    <div class="panel panel-default">
        <div class="panel-body db-user panel-body-listing-info">
            <% appController = (AppController)session.getAttribute("appController");
                if (!appController.getEnvironment().equals("production")){
                    String expirePostURL = appController.getAPIManager().getPrefix() + "/api/v1/posts/dev_expire_post?id=" + post.getId(); %>
                    <button data-expireURL="<%=expirePostURL%>" class="btn btn-primary pull-right expire-post">Expire Post</button>
            <%  } %>
            <div class="text-center">
                <% if (post.getAvatarPath() == null){%>
                <img src="http://placehold.it/120x120" alt="" class="db-user-pic col-centered img-rounded img-responsive" />
                <% } else { %>
                <img src="<%=post.getAvatarPath()%>" alt="" class="db-user-pic col-centered img-rounded img-responsive" />
                <% } %>
            </div>

            <div class="db-user-info">
                <h2><%=post.getHeader()%></h2> 
                <h5><%=post.getDescription()%></h5>
            </div> 
        </div>
    </div>
    <div class="col-md-12 panel chat-panel">
        <div class="col-md-12 chat-panel-header">
            Chat <small> with your hires </small>
        </div>
        <%@include file="_chat.jsp"%>     
    </div>
</div>


<div class="col-md-8">
    <div class="panel panel-default worker-panel">
        <div class="panel-heading"> 
            <h4>Your Hired Applicants</h4> 
        </div> 
        <div class="col-xs-12 header">
            <label for="job-date" class="date-label hidden-xs">Date of Job</label>
            <label for="job-date" class="date-label visible-xs">Date</label>
            <select id="job-date" class="form-control" name="job-date" required></select>
        </div>
        
        <div class="col-xs-12 header">
            <div class="col-xs-2 header hidden-xs">Name</div>
            <div class="col-xs-3 header hidden-xs">Check-In</div>
            <div class="col-xs-3 header hidden-xs">Check-Out</div>
            <div class="col-xs-4 header hidden-xs">Pay </div>
            
            <div class="col-xs-3 header visible-xs">Name</div>
            <div class="col-xs-5 header visible-xs">Status</div>
            <div class="col-xs-4 header visible-xs">Pay </div>
        </div>
        
        <% if (hiredList != null){ %>
        <% if (hiredList.size() > 0){ %>
        <% for (User user : hiredList){ %>
        <div class="open-profileModal col-xs-12 worker-details-bar" data-name="<%= user.getUsername()%>" data-gender="<%=user.getGender()%>" data-nationality="<%=user.getNationality()%>" data-email="<%= user.getEmail()%>" data-contact="<%= String.valueOf(user.getContactNumber())%>" data-avatar="<%=user.getAvatar()%>" data-good="<%=user.getGoodRating()%>" data-neutral="<%=user.getNeutralRating()%>" data-bad="<%=user.getBadRating()%>" id="<%=user.getId()%>" data-qualification="<%=user.getQualification()%>" data-description="<%=user.getDescription()%>">
            <div class="col-xs-2 hidden-xs"><%=user.getUsername()%></div>
            <div class="col-xs-3 visible-xs"><%=user.getUsername()%></div>
            <div class="check-in col-xs-3 hidden-xs">
                <% String checkInID = user.getId() + "_check_in"; %>
                <form action="/CheckInServlet" method="POST" class="check-in-form" id="<%=checkInID + "_form"%>" style='display: inline;'>
                    <input type="hidden" name="post_id" value="<%=postID%>" />
                    <input type="hidden" name="user_id" value="<%=user.getId()%>" />
                    <input type="submit" value="Check In" class="btn btn-success" />
                </form>
                <div class='check-in-text' style='display: inline;'>
                    <strong style="color: green;" id="<%=checkInID%>"></strong>
                </div>
            </div>
            <div class="check-out col-xs-3 hidden-xs">
                <% String checkOutID = user.getId() + "_check_out"; %>
                <form action="/CheckOutServlet" method="POST" class="check-out-form" id="<%=checkOutID + "_form"%>" style='display: inline;'>
                    <input type="hidden" name="post_id" value="<%=postID%>" />
                    <input type="hidden" name="user_id" value="<%=user.getId()%>" />
                    <input type="submit" value="Check Out" class="btn btn-primary" />
                </form>
                <div class='check-out-text' style='display: inline;'>
                    <strong style="color: maroon;" id="<%=checkOutID%>"></strong>
                </div>
            </div>
                
            <div class="col-xs-5 visible-xs mobile-check">
                <button class="btn btn-success mobile-check-in" id="<%=checkInID + "_mobile"%>">Check In</button>
                <strong style="color: green;" id="<%=checkInID + "_mobile_text"%>"></strong>
                <div style="text-align: center;"> ------------------- </div>
                <button class="btn btn-primary mobile-check-out" id="<%=checkOutID + "_mobile"%>">Check Out</button>
                <strong style="color: maroon;" id="<%=checkOutID + "_mobile_text"%>"></strong>
            </div>
                
            <div class="day-wage-placeholder col-xs-4">
                <div> --- </div>
            </div>
            <div class="day-wage col-xs-4">
                <% String dayWage = user.getId() + "_day_wage"; %>
                <form action="/UpdateWageServlet" method="POST" style='display: inline;'>
                    <input type="hidden" name="post_id" value="<%=postID%>" />
                    <input type="hidden" name="user_id" value="<%=user.getId()%>" />
                    <input type="hidden" name="date" id="wage_date" class="wage_date" value="0" />
                    <span>$</span>
                    <input type="number" name="salary" id="<%=dayWage%>" class="form-control" min="0.01" step="0.01" max="2500">
                    <input type="submit" value="Update" class="btn btn-success" />
                </form>
            </div>
        </div>
        <% } %>
        <% } else { %>
        <tr style="background-color: white;"><td colspan="4" class="text-center" style="cursor: default;">No Hired Applicants</td></tr>
        <% } %>
        <% } %>
    </div>
</div>
            
</div>
<a href="/dashboard.jsp" class="btn btn-lg btn-warning btn-srad" type="button">Back to Dashboard</a>
</div>
</header>
    
<script>
    $(document).on("change", "#job-date", function() {
        var date = $("#job-date").val().replace("/", "-").replace("/", "-");
        $(".wage_date").val(date);
        updateListing(date);
    });
    
    $(document).on("click", ".mobile-check-in", function(e){
        var id = $(this).attr("id");
        var form = id.replace("_mobile", "_form");
        $("#" + form).submit();
        e.stopPropagation();
    });
    
    $(document).on("click", ".mobile-check-out", function(e){
        var id = $(this).attr("id");
        var form = id.replace("_mobile", "_form");
        $("#" + form).submit();
        e.stopPropagation();
    });
    
    function updateListing(date){
        $.ajax({
            url: "/UpdateListingServlet",
            method: "POST",
            dataType: "json",
            data: {
                "post_id" : <%= postID %>,
                "date" : date
            },
            success: function(data){
                console.log(data);
                $.each(data, function(index, element) {
                    var check_in = element.split(",")[0];
                    var check_out = element.split(",")[1];
                    var day_wage = element.split(",")[2];
                    if (check_in !== "null"){
                        $("#" + index).children(".check-in").children(".check-in-text").show();
                        $("#" + index).children(".check-in").children(".check-in-form").hide();
                        $("#" + index).children(".check-in").children(".check-in-text").children("#" + index + "_check_in").html(check_in);
                        
                        // mobile
                        $("#" + index).children(".mobile-check").children(".mobile-check-in").hide();
                        $("#" + index).children(".mobile-check").children("#" + index + "_check_in_mobile_text").show();
                        $("#" + index).children(".mobile-check").children("#" + index + "_check_in_mobile_text").html(check_in);
                    } else {
                        $("#" + index).children(".check-in").children(".check-in-text").hide();
                        $("#" + index).children(".check-in").children(".check-in-form").show();
                        
                        // mobile
                        $("#" + index).children(".mobile-check").children(".mobile-check-in").show();
                        $("#" + index).children(".mobile-check").children("#" + index + "_check_in_mobile_text").hide();
                    }
                    if (check_out !== "null"){
                        $(".day-wage").show();
                        $(".day-wage-placeholder").hide();
                        $("#" + index).children(".check-out").children(".check-out-text").show();
                        $("#" + index).children(".check-out").children(".check-out-form").hide();
                        $("#" + index).children(".check-out").children(".check-out-text").children("#" + index + "_check_out").html(check_out);
                        
                        // mobile
                        $("#" + index).children(".mobile-check").children(".mobile-check-out").hide();
                        $("#" + index).children(".mobile-check").children("#" + index + "_check_out_mobile_text").show();
                        $("#" + index).children(".mobile-check").children("#" + index + "_check_out_mobile_text").html(check_out);
                    } else {
                        $("#" + index).children(".check-out").children(".check-out-text").hide();
                        $("#" + index).children(".check-out").children(".check-out-form").show();
                        
                        // mobile
                        $("#" + index).children(".mobile-check").children(".mobile-check-out").show();
                        $("#" + index).children(".mobile-check").children("#" + index + "_check_out_mobile_text").hide();
                        
                        $(".day-wage").hide();
                        $(".day-wage-placeholder").show();
                    }
                    $("#" + index + "_day_wage").val(day_wage);
                });
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.log(textStatus, errorThrown);
            }
        });
    }
    
    var date = null;
    $(document).ready(function(){
        <% Date runningDate = post.getJobDate(); %>
        <% DateFormat df = new SimpleDateFormat("dd-MM-yyyy"); %>
        var running_date_string = "<%=df.format(runningDate)%>";
        var end_date_string = "<%=df.format(post.getEndDate())%>";
        var running_date = moment(running_date_string, "DD-MM-YYYY", true);
        var end_date = moment(end_date_string, "DD-MM-YYYY", true);
        while (!(running_date.isAfter(end_date))){
            var date = running_date.format("DD/MM/YYYY");
            $('#job-date').append($('<option>', {
                value: date,
                text: date
            }));
            running_date = running_date.add(1, "days");
        }
        
        $("#job-date").val($("#job-date option:first").val());
        
        date = $("#job-date option:first").val().replace("/", "-").replace("/", "-");
        updateListing(date);
        $(".wage_date").val(date);
    });
    
    $(".day-wage").change(function(){
        var amount = parseFloat($(this).val()).toFixed(2);
        $(this).val(amount);
    });
    
    $(document).on("click", ".day-wage", function(e){
        e.stopPropagation();
    });
</script>

<jsp:include page="_anchor.jsp" />
<jsp:include page="_footer.jsp" />