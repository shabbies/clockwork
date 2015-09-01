<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>
    
<header class="main">
<div class="header-content">
<div class="header-content-inner">
<div class="row profile-div">

    <% if (session.getAttribute("error") != null){%>
    <div class="alert alert-danger" role="alert">
        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
        <span class="sr-only">Error:</span>
        <%=session.getAttribute("error")%>
    </div>
    <%session.removeAttribute("error");}%>
    <% if (session.getAttribute("message") != null){%>
    <div class="alert alert-success" role="alert">
        <span class="glyphicon glyphicon-ok-sign" aria-hidden="true"></span>
        <%=session.getAttribute("message")%>
    </div>
    <%session.removeAttribute("message");}%>
    
    <div class="col-sm-2"></div>
    <div class="col-sm-8">

        <div class="panel panel-default">
            <div class="panel-body">

                <!-- User Profile (Left Panel -->
                <form class="form form-signup" action="/CompleteProfileServlet" method="POST" role="form" enctype="multipart/form-data">

                    <div class="text-center">
                        <% if (currentUser.getAvatar() == null){%>
                        <img src="img/user-placeholder.jpg" alt="" class="db-user-pic modal-pic col-centered img-rounded img-responsive" />
                        <% } else { %>
                        <img src="<%=currentUser.getAvatar()%>" alt="" class="db-user-pic modal-pic col-centered img-rounded img-responsive" />
                        <% } %>
                    </div>


                    <div class="form-group col-sm-6 text-left"> 

                        <label for="full-name" class="control-label"><%= (currentUser.getAccountType().equals("job_seeker"))? "Full Name*": "Company Name*"%></label> 
                        <input id="full-name" class="form-control" type="text" placeholder="Name" name="username" value="<%=currentUser.getUsername()%>" required> 
                    </div>
                    
                    <div class="form-group col-sm-6 text-left"> 

                        <label for="gender" class="control-label">Gender*</label> 
                        <label class="radio"><input type="radio" name="gender" value="M">Male</label>
                        <label class="radio"><input type="radio" name="gender" value="F">Female</label>
                    </div>

                    <div class="form-group col-sm-6 text-left"> 
                        <label for="contactnumber" class="control-label">Contact Number</label> 
                        <% if (currentUser.getContactNumber() == 0){ %>
                        <input id="contactnumber" class="form-control" type="text" name="contact_number" onkeypress="return isNumber(event)"> 
                        <% } else { %>
                        <input id="contactnumber" class="form-control" type="text" name="contact_number" onkeypress="return isNumber(event)" value="<%=currentUser.getContactNumber()%>" > <%}%>
                    </div>
                    
                    <div class="form-group col-sm-6 text-left"> 
                        <label for="nationality" class="control-label">Nationality*</label> 
                        <select id="nationality" class="form-control" name="nationality" required>
                            <option>Singaporean</option>
                            <option>Singapore PR</option>
                            <option>Others</option>
                            <option selected="selected" disabled="disabled">Please select a nationality</option>
                        </select>
                    </div>

                    <div class="form-group col-sm-12 text-left"> 
                        <label for="street-address" class="control-label">Street Address</label> 
                        <% if (currentUser.getAddress() == null){ %>
                        <input id="street-address" class="form-control" type="text" name="address"> 
                        <% } else { %>
                        <input id="street-address" class="form-control" type="text" name="address" value="<%=currentUser.getAddress()%>"><%}%> 
                    </div>

                    <div class="form-group col-sm-12 text-left"> 
                        <label for="avatar" class="control-label">Profile Picture</label> 
                        <input id="avatar" class="form-control" type="file" name="avatar" accept="image/*">
                    </div>

                    <% if(currentUser.getAccountType().equals("job_seeker")){%>

                    <div class="form-group col-sm-12 text-left"> 
                        <label for="dob-date" class="control-label">Date of Birth</label> 
                        <div class="input-group"> 
                            <div class="input-group-addon"><i class="fa fa-calendar fa-lg fa-fw"></i></div> 
                                <% if (currentUser.getDateOfBirth() == null){ %>
                            <input id="dob-date" class="form-control" type="date" name="dob_date" > 
                            <% } else { %>
                            <input id="dob-date" class="form-control" type="date" name="dob_date" value="<%=currentUser.getDateOfBirthString()%>"> <% } %>
                        </div> 
                    </div>

                    <% } %>

                    <input class="btn btn-lg btn-primary btn-srad" type="submit" value="Complete Profile">
                </form>
                <!-- END LEFT PANEL -->
            </div>
        </div>
    </div>
    <div class="col-sm-2"></div>           
</div>
<a href="/mydashboard.jsp" class="btn btn-lg btn-warning btn-srad" type="button">Back to Dashboard</a>
</div>
</div>
</header>
<jsp:include page="_javascript_checker.jsp" />
<jsp:include page="_footer.jsp" />