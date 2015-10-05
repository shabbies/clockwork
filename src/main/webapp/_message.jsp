<% if (session.getAttribute("error") != null){%>
<div class="alert alert-danger" role="alert" style="font-size: 14px;">
  <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
  <span class="sr-only">Error:</span>
  <strong><%=session.getAttribute("error")%></strong>
</div>
<%session.removeAttribute("error");}%>

<% if (session.getAttribute("message") != null){%>
<div class="alert alert-success" role="alert" style="font-size: 14px;">
  <span class="glyphicon glyphicon-ok-sign" aria-hidden="true"></span>
  <strong><%=session.getAttribute("message")%></strong>
</div>
<%session.removeAttribute("message");}%>