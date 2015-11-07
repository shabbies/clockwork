<div class="col-md-4">
    <div class="panel panel-default">
        <div class="panel-body db-user">
            <% String editURL = "/edit_profile.jsp";
            if (currentUser.getContactNumber() == 0 || currentUser.getDateOfBirth() == null || currentUser.getGender() == '\u0000' || currentUser.getNationality() == null){
                editURL = "/complete_profile.jsp";
            }%>
            <div class="text-center">
                <a href="<%=editURL%>">
                    <% if (currentUser.getAvatar() == null){%>
                    <img src="img/user-placeholder.jpg" alt="" class="db-user-pic col-centered img-rounded img-responsive" />
                    <% } else { %>
                    <img src="<%=currentUser.getAvatar()%>" alt="" class="db-user-pic col-centered img-rounded img-responsive" />
                    <%}%>
                </a>
            </div>
                    
            <div class="db-user-info">
                <h2>Hi <%= currentUser.getUsername()%>!</h2>
                <div class="text-center ratings_info">
                    <div>My ratings:</div>
                    <%=currentUser.getGoodRating()%> <img src="/img/good.png" class="listing_ratings"/>
                    <%=currentUser.getNeutralRating()%> <img src="/img/neutral.png" class="listing_ratings"/>
                    <%=currentUser.getBadRating()%> <img src="/img/bad.png" class="listing_ratings"/>
                </div>
                <span>What would you like to do today?</span>
            </div>
            <a href="/scoreboard.jsp" class="btn btn-primary btn-block"><i class="fa fa-fw fa-gamepad"></i> View my Scores </a>
            <a href="/badges.jsp" class="btn btn-primary btn-block"><i class="fa fa-fw fa-trophy"></i> View my Badges </a>
            <a href="<%=editURL%>" class="btn btn-primary btn-block"><i class="fa fa-fw fa-plus"></i> 
                <% if (currentUser.getContactNumber() == 0 || currentUser.getDateOfBirth() == null || currentUser.getGender() == '\u0000' || currentUser.getNationality() == null){ %>
                Complete my Profile
                <% } else { %>
                Update my Profile
                <% } %>
            </a>
            <a href="/all_ratings.jsp" class="btn btn-primary btn-block"><i class="fa fa-fw fa-star"></i> View my Ratings</a>
            <a href="#" class="btn btn-primary btn-block incomplete"><i class="fa fa-fw fa-book"></i> View my Archived Jobs</a>
        </div>
    </div>
</div>