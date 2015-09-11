<%@include file="_header.jsp"%>

<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Post"%>
<%@ page import="java.util.Date"%>

<%@include file="_nav.jsp"%>
<%@include file="_hero.jsp"%>
<%@include file="_job_details.jsp"%>

<div class="container">
  <form class="form-horizontal">
   <div class="form-group has-feedback">
    <label for="txt1" class="col-sm-2 control-label">Label 1</label>
    <div class="col-sm-10">
     <input id="txt1" type="text" class="form-control hasclear" placeholder="Textbox 1">
     <span class="clearer glyphicon glyphicon-remove-circle form-control-feedback" id="searchclear"></span>
    </div>
   </div>
   <div class="form-group has-feedback">
    <label for="txt2" class="col-sm-2 control-label">Label 2</label>
    <div class="col-sm-10">
      <input id="txt2" type="text" class="form-control hasclear" placeholder="Textbox 2">
      <span class="clearer glyphicon glyphicon-remove-circle form-control-feedback"></span>
    </div>
   </div>
   <div class="form-group has-feedback">
    <label for="txt3" class="col-sm-2 control-label">Label 3</label>
    <div class="col-sm-10">
     <input id="txt3" type="text" class="form-control hasclear" placeholder="Textbox 3">
     <span class="clearer glyphicon glyphicon-remove-circle form-control-feedback"></span>
    </div>   
   </div>
  </form>
 </div>

<hr class="grey">
<footer>
    <div class="container">
        <div class="row">
            <div class="col-md-4 col-xs-4">
                <span class="copyright">Copyright © Clockwork 2015</span>
            </div>
            <div class="col-md-4 col-xs-4">
                <ul class="list-inline social-buttons text-center">
                    <li><a href="#"><i class="fa fa-twitter"></i></a>
                    </li>
                    <li><a href="#"><i class="fa fa-facebook"></i></a>
                    </li>
                    <li><a href="#"><i class="fa fa-linkedin"></i></a>
                    </li>
                </ul>
            </div>
            <div class="col-md-4 col-xs-4">
                <ul class="list-inline quicklinks pull-right">
                    <li><a href="#">Privacy Policy</a>
                    </li>
                    <li><a href="#">Terms of Use</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</footer>

<script>
$(function() {
    $('.job-entry').hover(function() {
        if($(this).hasClass("job-edit")){
            $(this).find(".job-entry-apply").css( "background-color", "#f0ad4e"); 
        }else{
            $(this).find(".job-entry-apply").css( "background-color", "#ee4054"); 
        }
        $(this).find("a").removeClass("whitelink"); 

    }, function() {
        $(this).find( ".job-entry-apply").css( "background-color", "") 
        $(this).find("a").addClass("whitelink"); 
    });
});

$(".hasclear").keyup(function () {
    var t = $(this);
    t.css("background-color", "black");
    t.next('span').toggle(Boolean(t.val()));
});
$(".clearer").hide($(this).prev('input').val());
$(".clearer").click(function () {
    alert("hi");
    $(this).prev('input').val('').focus();
    $(this).hide();
});
$("#searchclear").click(function(){
    $("#searchText").val('');
});

</script>


<jsp:include page="_footer.jsp" />






