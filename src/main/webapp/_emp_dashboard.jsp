<div class="col-md-4">
    <div class="panel panel-default">
        <div class="panel-body db-user">
                        
            <div class="text-center">
                <a href="/edit_profile.jsp">
                    <% if (currentUser.getAvatar() == null){%>
                    <img src="img/user-placeholder.jpg" alt="" class="db-user-pic col-centered img-rounded img-responsive" />
                    <% } else { %>
                    <img src="<%=currentUser.getAvatar()%>" alt="" class="db-user-pic col-centered img-rounded img-responsive" />
                    <%}%>
                </a>
            </div>
                            
            <div class="db-user-info">
                <h2>Hi <%=currentUser.getUsername()%>!</h2> 
                <span>What would you like to do today?</span>
            </div>
            <a href="/edit_profile.jsp" class="btn btn-primary btn-block"><i class="fa fa-fw fa-plus"></i> Update My Profile</a>
            <a href="/applicant_history.jsp" class="btn btn-primary btn-block"><i class="fa fa-fw fa-male"></i> View my past employees</a>
            <a href="#" class="btn btn-primary btn-block incomplete"><i class="fa fa-fw fa-book"></i> View my Achived Jobs</a>
        </div>
    </div>
</div>
                          
<script>
$(".incomplete").click(function(){
    alert("Oops! This is not yet available!")
});
</script>