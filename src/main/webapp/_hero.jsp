<header>
	<div class="header-content">
        <div class="header-content-inner">
            <h1>Lets Begin!</h1>
            <div class="header-content-btn">
                <a href="/register_job_seeker.jsp" id="btnwork" class="btn btn-primary btn-xl">Find Work (Register now)</a>
                <a href="/create_post.jsp" id="btnjob" class="btn btn-primary btn-xl">Post your Job (It's free)</a>
            </div>
        </div>
    </div>
</header>

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