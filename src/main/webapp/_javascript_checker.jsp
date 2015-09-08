<script>
$('.form-signup').on('submit', function () {
    if ($('#new-password').val() !== "" && $("#old-password").val() !== ""){
        if ($('#new-password').val().length < 8){
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

$('.form_complete_profile').on('submit', function() {
    if ($('input[name=gender]:checked').length < 1) {
        alert("Please select your gender before proceeding");
        return false;
    }
    
    if ($("#nationality option:selected").text() === "Please select a nationality"){
        alert("Please select your nationality before proceeding");
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
});

$("#job-pay").change(function(){
    var amount = parseFloat($(this).val()).toFixed(2);
    $(this).val(amount);
});

$("#job-date").change(function(){
    var start_date = $("#job-date").val();
    $("#end-date").val(start_date); 
    $("#end-date").attr("min", start_date);
});

$("#job-date").focusout(function(){
    var start_date_string = $("#job-date").val();
    var start_date = new Date(start_date_string);
    var today = new Date();
    
    start_date.setHours(0,0,0,0);
    today.setHours(0,0,0,0);
    today.setDate(today.getDate() + 2);
    var today_string = today.getFullYear() + "-" + ("0" + (today.getMonth() + 1)).slice(-2) + "-" + today.getDate();
    if (start_date < today){
        alert("Please select a start date at least 2 days from today!");
        $("#job-date").val(today_string);
        $("#end-date").val(today_string); 
        $("#end-date").attr("min", today_string);
    }
});

$("#end-date").focusout(function(){
    var end_date_string = $("#end-date").val();
    var end_date = new Date(end_date_string);
    var today = new Date();
    
    end_date.setHours(0,0,0,0);
    today.setHours(0,0,0,0);
    today.setDate(today.getDate() + 2);
    var today_string = today.getFullYear() + "-" + ("0" + (today.getMonth() + 1)).slice(-2) + "-" + today.getDate();
    if (end_date < today){
        alert("Please select an end date that is at least 2 days from today!");
        $("#end-date").val(today_string); 
        $("#end-date").attr("min", today_string);
    }
});

$("#dob-date").focusout(function(){
    var dob_string = $("#dob-date").val();
    var today = new Date();
    var dob = new Date(dob_string);
    
    today.setHours(0,0,0,0);
    dob.setHours(0,0,0,0);
    if (today.getFullYear() - 15 < dob.getFullYear()){
        alert("You need to be at least 15 years old to use this service");
        $("#dob-date").val("");
    }
});


</script>