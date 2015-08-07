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
</script>