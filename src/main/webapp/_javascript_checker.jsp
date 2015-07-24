<script>
    $('.form-signup').on('submit', function () {
        if ($('#password').val().length() < 8){
            //Gerald TODO: add the flash message for password length checking (min 8 characters)
            $(.password_length_error).removeAttr("style");
            //END
            e.preventDefault();
        }
    });
</script>