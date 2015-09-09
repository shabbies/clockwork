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