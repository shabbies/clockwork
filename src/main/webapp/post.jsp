<%@include file="_header.jsp"%>
<%@include file="_nav.jsp"%>

<%@ page import="model.User"%>

<header class="main">
  <div class="header-content">
    <div class="header-content-inner">
        <% if (session.getAttribute("error") != null){%>
        <div class="alert alert-danger" role="alert">
          <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
          <span class="sr-only">Error:</span>
          <%=session.getAttribute("error")%>
        </div>
        <%session.removeAttribute("error");}%>
        <% if (session.getAttribute("message") != null){%>
        <div class="alert alert-danger" role="alert">
          <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
          <span class="sr-only">Error:</span>
          <%=session.getAttribute("message")%>
        </div>
        <%session.removeAttribute("message");}%>
      <h2 class="text-center"><strong>Bellboy</strong> @ HardRock Hotel</h2>

      <div class="row">
        <div class="col-md-12">
          <div class="panel panel-default">
            <div class="panel-body  grey">
              <div class="col-md-7 modal-job-details">
               <div class="col-md-4 text-center">
                <img src="http://placehold.it/200x200" alt="" class="db-user-pic img-rounded img-responsive"/>

                <h1 id="modalSalary">$10/hr</h1>
              </div>

              <div class="col-md-8">
               <h4 id="modalHeader"><strong>Bellboy</strong> @ HardRock Hotel</h4>
               <h4>Resort World Singapore</h4>
               <h4>21/08/2015</h4>

               <h5>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Fuga repellat corrupti nam provident praesentium vel! Nobis vel distinctio deserunt similique, nemo, voluptate a rem excepturi cumque ut quam quia minima.</br></br>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Fuga repellat corrupti nam provident praesentium vel! Nobis vel distinctio deserunt similique, nemo, voluptate a rem excepturi cumque ut quam quia minima.
               </h5>
             </div>

           </div>

           <div class="col-md-5 modal-job-calendar">
            <h4><strong>Schedule for the Month</strong></h4>
            <div id="calendar"></div>
          </div>

          <div class="text-center">
            <button type="button" class="btn btn-primary btn-lg">Apply for Job</button>
             <button type="button" class="btn btn-warning btn-lg hidden">Edit Job</button>
          </div>

        </div>
      </div>
    </div>
  </div>


</div>
</div>
</header>


<script>

$(document).ready(function() {
 $('#calendar').fullCalendar({
  editable: false,
  allDayDefault: true,
  contentHeight: 240,
  titleFormat: 'MMMM',
  eventColor: '#ee4054',
  events: [
  {
    title: 'A Event',
    start: '2015-08-05',
    end: '2015-08-05'
  },
  {
    title: 'C Event',
    start: '2015-08-07',
    end: '2015-08-07'
  },
  {
    title: 'B Event',
    start: '2015-08-06',
    end: '2015-08-06'
  },
  {
    title: 'D Event',
    start: '2015-08-02',
    end: '2015-08-05'
  }
  ],
  eventAfterRender: function(event, element, view) {
    $(element).css('height','30px');
    $(element).css('font-weight','700');
  }/*, eventRender: function (event, element, view) { 
        var dateString = event.start.format("YYYY-MM-DD");
        $(view.el[0]).find('.fc-day[data-date="' + dateString + '"]').css('background-color', '#ee4054');
      }*/
    });





});


</script>

<jsp:include page="_footer.jsp" />