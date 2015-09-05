<script>
$('.form-signup').on('submit', function () {
    if ($('#register-password').val().length < 8){
        $('.password_length_error').removeAttr("style");
        $("#register-password").val('');

        $("#register-password").css("border", "1px solid #ee4054" );
        $("#register-password").css("box-shadow", "none");

        $("#register-password-icon").css("border", "1px solid #ee4054");
        $("#register-password-icon").css("background-color", "#ee4054");
        $("#register-password-icon").css("color", "#fff");

        return false;
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

$()
</script>