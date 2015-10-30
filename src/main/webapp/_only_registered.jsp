<%
if (currentUser == null){
    session.setAttribute("error", "Only registered users are allowed to carry on, please login before proceeding!");
    response.sendRedirect("/login.jsp");
    return;
}
%>