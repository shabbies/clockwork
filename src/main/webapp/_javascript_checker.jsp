<script>
    
$('.form-signup').on('submit', function () {
    var location = window.location.href;
    if ($('#new-password').val() !== "" && $("#old-password").val() !== "" || location.indexOf("register") > -1){
        if ($('#new-password').val().length < 8 || $("#register-password").val().length < 8){
            $('.password_length_error').removeAttr("style");
            $("#new-password").val('');
            $("#confirm-password").val('');

            $("#new-password").css("border", "1px solid #ee4054" );
            $("#new-password").css("box-shadow", "none");

            $("#register-password-icon").css("border", "1px solid #ee4054");
            $("#register-password-icon").css("background-color", "#ee4054");
            $("#register-password-icon").css("color", "#fff");

            return false;
        }
    }
    
    return true;
});

$("input[name=gender]").change(function(){
    $(".gender-error").attr("style", "display: none;");
});

$("#nationality").change(function(){
    $(".nationality-error").attr("style", "display: none;");
    $("#nationality").css("border", "1px solid #ccc" );
    $("#nationality").css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075)");
});

$("#qualification").change(function(){
    $("#qualification").css("border", "1px solid #ccc" );
    $("#qualification").css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075)");
    $(".qualification-error").hide(); 
});

$('.form_complete_profile').on('submit', function() {
    if ($('input[name=gender]:checked').length < 1 || $("#nationality option:selected").text() === "Please select a nationality") {
        if ($('input[name=gender]:checked').length < 1) {
            $(".gender-error").removeAttr("style");
        }

        if ($("#nationality option:selected").text() === "Please select your nationality"){
            $(".nationality-error").removeAttr("style");
            $("#nationality").css("border", "1px solid #ee4054" );
            $("#nationality").css("box-shadow", "none");
        }
        
        return false;
    }
    
    if($(".dob-error").attr("style") !== "display:none;"){
        return false;
    }
    
    if($(".nric-error").is(":visible")){
        return false;
    }
    
    if ($("#qualification option:selected").text() === "Please select your qualification"){
        $(".qualification-error").removeAttr("style");
        $("#qualification").css("border", "1px solid #ee4054" );
        $("#qualification").css("box-shadow", "none");
        
        return false;
    }
});

function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}

$(document).ready(function(){
    var today = new Date().toISOString().split('T')[0];
    $("#job-date").attr("min", today);
    $("#end-date").attr("min", today);
        
    var monthNames = ["January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December"];

    var today = new Date();
    today.setDate(today.getDate() + 2);
    var max_date = new Date();
    max_date.setDate(max_date.getDate() + 8);

    var min_date_string = monthNames[today.getMonth()] + " " + today.getDate() + ", " + today.getFullYear();
    var max_date_string = monthNames[max_date.getMonth()] + " " + max_date.getDate() + ", " + max_date.getFullYear();
    $("#job-date").daterangepicker({
        locale: {
            format: 'MMMM D, YYYY'
        },
        startDate: min_date_string,
        endDate: max_date_string,
        dateLimit: {
            "days": 6
        },
        minDate: min_date_string
    }); 
    
    $("#job-date-edit").daterangepicker({
        locale: {
            format: 'MMMM D, YYYY'
        },
        dateLimit: {
            "days": 6
        },
        minDate: min_date_string
    }); 
});

$(document).on("click", "#job-date-icon", function(){
    $("#job-date").focus(); 
    $("#job-date-edit").focus(); 
 });

$("#job-pay").change(function(){
    var amount = parseFloat($(this).val()).toFixed(2);
    $(this).val(amount);
});

$("#job-date").change(function(){
    var start_date = $("#job-date").val();
    $("#end-date").val(start_date); 
    $("#end-date").attr("min", start_date);
    var max_date = new Date(start_date);
    max_date.setDate(max_date.getDate() + 7);
    var max_date_string = max_date.getFullYear() + "-" + ("0" + (max_date.getMonth() + 1)).slice(-2) + "-" + max_date.getDate();
    $("#end-date").attr("max", max_date_string);
});

$("#job-date").focusout(function(){
    $(".job-start-date").attr("style", "display:none;");
    $(".job-end-date").attr("style", "display:none;");
    $("#job-date").css("border", "1px solid #ccc" );
    $("#job-date").css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075)");
    $("#end-date").css("border", "1px solid #ccc" );
    $("#end-date").css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075)");
    
    var start_date_string = $("#job-date").val();
    var start_date = new Date(start_date_string);
    var today = new Date();
    
    start_date.setHours(0,0,0,0);
    today.setHours(0,0,0,0);
    today.setDate(today.getDate() + 2);
    var today_string = today.getFullYear() + "-" + ("0" + (today.getMonth() + 1)).slice(-2) + "-" + today.getDate();
    if (start_date < today){
        var max_date = new Date();
        max_date.setDate(today.getDate() + 7);
        var max_date_string = max_date.getFullYear() + "-" + ("0" + (max_date.getMonth() + 1)).slice(-2) + "-" + max_date.getDate();
        
        $("#job-date").css("border", "1px solid #ee4054" );
        $("#job-date").css("box-shadow", "none");
        $(".job-start-date").removeAttr("style");
        if ($(".job-end-date").attr("style") === "display:none;"){
            $(".end-filler").removeAttr("style");
        }
        
        $(".start-filler").attr("style", "display:none;");
        $("#job-date").val(today_string);
        $("#end-date").val(today_string); 
        $("#end-date").attr("min", today_string);
        $("#end-date").attr("max", max_date_string);
    }
});

$("#end-date").focusout(function(){
    $(".job-end-date").attr("style", "display:none;");
    $("#end-date").css("border", "1px solid #ccc" );
    $("#end-date").css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075)");
    if ($(".job-start-date").attr("style") !== "display:none;"){
        $(".end-filler").removeAttr("style");
    }
    var end_date_string = $("#end-date").val();
    var end_date = new Date(end_date_string);
    var today = new Date();
    
    end_date.setHours(0,0,0,0);
    today.setHours(0,0,0,0);
    today.setDate(today.getDate() + 2);
    var today_string = today.getFullYear() + "-" + ("0" + (today.getMonth() + 1)).slice(-2) + "-" + today.getDate();
    if (end_date < today){
        $("#end-date").css("border", "1px solid #ee4054" );
        $("#end-date").css("box-shadow", "none");
        $(".job-end-date").removeAttr("style");
        $(".start-filler").removeAttr("style");
        $(".end-filler").attr("style", "display: none;");
        $("#end-date").val(today_string); 
        $("#end-date").attr("min", today_string);
    }
});

//$("#dob-date").focusout(function(){
//    $(".dob-error").attr("style", "display:none;");
//    $("#dob-date").css("border", "1px solid #ccc" );
//    $("#dob-date").css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075)");
//    var dob_string = $("#dob-date").val();
//    var today = new Date();
//    var dob = new Date(dob_string);
//    
//    today.setHours(0,0,0,0);
//    dob.setHours(0,0,0,0);
//    if (today.getFullYear() - 15 < dob.getFullYear()){
//        $("#dob-date").css("border", "1px solid #ee4054" );
//        $("#dob-date").css("box-shadow", "none");
//        $(".dob-error").removeAttr("style");
//        $("#dob-date").val("");
//    }
//});

$("#avatar").change(function (evt) {
    var pic = evt.target.files[0];
    var reader = new FileReader();
    reader.onload = (function() {
      return function(e) {
        $("#profile-pic").attr("src", e.target.result);
      };
    })(pic);
    reader.readAsDataURL(pic);
});

$(document).on("click", ".pay-type-selector", function(){
    if (this.id === "hour"){
        $("#hour").addClass("active");
        $("#day").removeClass("active");
        $("#pay-switch").attr("checked", true);
    } else {
        $("#day").addClass("active");
        $("#hour").removeClass("active");
        $("#pay-switch").attr("checked", false);
    }
});
 
$("#job-location").focusout(function(){
    var address = $(this).val();
    geocoder.geocode( { 'address': address}, function(results, status) {
        if (status === "ZERO_RESULTS"){
            $("#job-location-error").show();
        } else {
            $("#job-location-error").hide();
        }
    });
});

$(".form-post").submit(function( event ) {
    if ($("#job-location-error").is(":visible")){
        $("#error-message").html("Please fix the errors before submitting the form!");
        $("#error-text").show();
        return false;
    }
});

//$("#nric").focusout(function(){
//    var str = $("#nric").val();
//    if (str.length != 9) {
//        $(".nric-error").show();
//        $("#nric").css("border", "1px solid #ee4054" );
//        $("#nric").css("box-shadow", "none");
//        return;
//    }
//    str = str.toUpperCase();
//
//    var i, 
//        icArray = [];
//    for(i = 0; i < 9; i++) {
//        icArray[i] = str.charAt(i);
//    }
//
//    icArray[1] = parseInt(icArray[1], 10) * 2;
//    icArray[2] = parseInt(icArray[2], 10) * 7;
//    icArray[3] = parseInt(icArray[3], 10) * 6;
//    icArray[4] = parseInt(icArray[4], 10) * 5;
//    icArray[5] = parseInt(icArray[5], 10) * 4;
//    icArray[6] = parseInt(icArray[6], 10) * 3;
//    icArray[7] = parseInt(icArray[7], 10) * 2;
//
//    var weight = 0;
//    for(i = 1; i < 8; i++) {
//        weight += icArray[i];
//    }
//
//    var offset = (icArray[0] == "T" || icArray[0] == "G") ? 4:0;
//    var temp = (offset + weight) % 11;
//
//    var st = ["J","Z","I","H","G","F","E","D","C","B","A"];
//    var fg = ["X","W","U","T","R","Q","P","N","M","L","K"];
//
//    var theAlpha;
//    if (icArray[0] == "S" || icArray[0] == "T") { theAlpha = st[temp]; }
//    else if (icArray[0] == "F" || icArray[0] == "G") { theAlpha = fg[temp]; }
//
//    if (icArray[8] !== theAlpha) {
//        $(".nric-error").show();
//        $("#nric").css("border", "1px solid #ee4054" );
//        $("#nric").css("box-shadow", "none");
//    } else {
//        $("#nric").css("border", "1px solid #ccc" );
//        $("#nric").css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075)");
//        $(".nric-error").hide();
//    }
//});


    
</script>