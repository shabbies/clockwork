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

$("input[name=gender]").change(function(){
    $(".gender-error").attr("style", "display: none;");
});

$("#nationality").change(function(){
    $(".nationality-error").attr("style", "display: none;");
    $("#nationality").css("border", "1px solid #ccc" );
    $("#nationality").css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075)");
});

$('.form_complete_profile').on('submit', function() {
    if ($('input[name=gender]:checked').length < 1 || $("#nationality option:selected").text() === "Please select a nationality") {
        if ($('input[name=gender]:checked').length < 1) {
            $(".gender-error").removeAttr("style");
        }

        if ($("#nationality option:selected").text() === "Please select a nationality"){
            $(".nationality-error").removeAttr("style");
            $("#nationality").css("border", "1px solid #ee4054" );
            $("#nationality").css("box-shadow", "none");
        }
        
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
    }
});

$("#end-date").focusout(function(){
    $(".job-end-date").attr("style", "display:none;");
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

$("#dob-date").focusout(function(){
    $(".dob-error").attr("style", "display:none;");
    $("#dob-date").css("border", "1px solid #ccc" );
    $("#dob-date").css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075)");
    var dob_string = $("#dob-date").val();
    var today = new Date();
    var dob = new Date(dob_string);
    
    today.setHours(0,0,0,0);
    dob.setHours(0,0,0,0);
    if (today.getFullYear() - 15 < dob.getFullYear()){
        $("#dob-date").css("border", "1px solid #ee4054" );
        $("#dob-date").css("box-shadow", "none");
        $(".dob-error").removeAttr("style");
        $("#dob-date").val("");
    }
});


</script>