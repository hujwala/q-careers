function validateApplicationForm() {

    $('#form_application').validate({
      debug: true,
      rules: {
        "fresher[name]": {
            required: true,
            minlength: 3,
            maxlength: 255
        },
        "fresher[email]": "required",
        "fresher[phone]": "required",
        "fresher[current_city]": "required",
        "fresher[native_city]": "required",
        "fresher[candidate][year_of_passing]": "required",
        "fresher[resume]": "required"
      },
      errorElement: "span",
      errorClass: "help-block",
      messages: {
        "fresher[name]": "can't be blank",
        "fresher[email]": "can't be blank",
        "fresher[phone]": "can't be blank",
        "fresher[current_city]": "can't be blank",
        "fresher[native_city]": "can't be blank",
        "fresher[candidate][year_of_passing]": "can't be blank",
        "fresher[resume]": "can't be blank"
      },
      highlight: function(element) {
          $(element).parent().parent().addClass("has-error");
      },
      unhighlight: function(element) {
          $(element).parent().parent().removeClass("has-error");
      },
      invalidHandler: function(referral, validator) {
        // 'this' refers to the form
        var errors = validator.numberOfInvalids();
        if (errors) {

          // Populating error message
          var errorMessage = errors == 1
            ? 'You missed 1 field. It has been highlighted'
            : 'You missed ' + errors + ' fields. They have been highlighted';

          // Removing the form error if it already exists
          var errorHtml = "<div class=\"alert alert-danger\" data-alert=\"alert\" style=\"margin-bottom:5px;\">"+ errorMessage +"</div>"
          $("#application_form_error").html(errorHtml);

          // Show error labels
          $("div.error").show();

        } else {
          // Hide error labels
          $("div.error").hide();

          // Removing the error message
          $("#application_form_error").remove();
        }
      },
      submitHandler: function(form) {
        if ($(form).valid())
          form.submit();
        return false; // prevent normal form posting
      }

    });

}
