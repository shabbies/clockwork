<header>
	<div class="header-content">
            <div class="header-content-inner">
                    <h1>Lets Begin!</h1>
                    <div class="header-content-btn">
                            <a href="" id="btnwork" class="btn btn-primary btn-xl">Find Work (Register now)</a>
                            <a href="/create_post.jsp" id="btnjob" class="btn btn-primary btn-xl">Post your Job (It's free)</a>
                    </div>
            </div>
            <!-- Gerald TODO: styling -->
            <% if (session.getAttribute("error") != null){%>
            <h4><%=session.getAttribute("error")%></h4><%session.removeAttribute("error");}%>
            <% if (session.getAttribute("message") != null){%>
            <h4><%=session.getAttribute("message")%></h4><%session.removeAttribute("message");}%>
            <!-- END -->
	</div>
</header>