<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>
<%@include file="_only_js.jsp"%>
<%@ page buffer="32kb" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Badge"%>

<%
ArrayList <Badge> badgeList = (ArrayList <Badge>)session.getAttribute("badgeList");
if (badgeList == null){ %>
<jsp:forward page="/GetBadgesServlet" />
<% } else {
session.removeAttribute("badgeList");}%>

<header class="main">
<div class="header-full-content">
    
<%@include file="_message.jsp"%>
    
<div class="row">
    <div class="col-md-8">
        <div class="panel panel-default center-panel-content">
            <div class="panel-heading"> 
                <h4>Your Badges</h4> 
            </div> 

            <table class="table table-hover"> 

                <thead> 
                    <tr id="header-row"> 
                        <th></th>
                        <th>Name</th>
                        <th>Criteria</th>
                    </tr>
                </thead>

                <tbody> 
                    <% for (Badge badge : badgeList) {%>
                    <% if (badge.getStatus().equals("completed")) {%> 
                    <tr class="success"> 
                    <% } else { %> 
                    <tr> 
                    <% } %>
                        <td>
                            <img class="col-md-1 notification_content_profile img-rounded img-responsive" src="<%=badge.getImageLink()%>">
                        </td>
                        <td style="vertical-align: middle;"><%=badge.getName()%></td>
                        <td style="vertical-align: middle;"><%=badge.getCriteria()%></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div> 
    </div>
    <%@include file="_js_dashboard.jsp"%>
</div>

</div>
</header>
<jsp:include page="_anchor.jsp" />
<jsp:include page="_footer.jsp" />
