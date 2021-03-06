<%
String unauthorisedRedirect = "";
boolean unauthorised = false;

if (currentUser == null){
    session.setAttribute("error", "Only registered users are allowed to carry on, please login before proceeding!");
    unauthorisedRedirect = "/login.jsp";
    unauthorised = true;
} else if (!currentUser.getHasConfirmed()){
    unauthorisedRedirect = "/unconfirmed.jsp";
    unauthorised = true;
    if (request.getRequestURI().indexOf("unconfirmed.jsp") != -1){
        unauthorised = false;
    }
} 

if (unauthorised){
    response.sendRedirect(unauthorisedRedirect);
    return;
}
%>