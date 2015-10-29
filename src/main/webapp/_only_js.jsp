<% 
String unauthorisedRedirect = "";
boolean unauthorised = false;
if (currentUser == null){
    session.setAttribute("error", "Only registered users are allowed to carry on, please login before proceeding!");
    unauthorisedRedirect = "/login.jsp";
    unauthorised = true;
} else if (!currentUser.getAccountType().equals("job_seeker")){
    session.setAttribute("error", "This page is only available for job seekers!");
    unauthorisedRedirect = "/index.jsp";
    unauthorised = true;
}

if (unauthorised){
    response.sendRedirect(unauthorisedRedirect);
    return;
}
%>