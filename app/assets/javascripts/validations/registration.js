function validateRegistrationForm() {

    $('#form_registration').validate({
      debug: true,
      rules: {
        "registration[name]": {
            required: true,
            minlength: 3,
            maxlength: 255
        },
        "registration[email]": "required",
        "registration[phone]": "required",
        "registration[current_city]": "required",
        "registration[native_city]": "required",
        "registration[year_of_passing]": "required"
      },
      errorElement: "span",
      errorClass: "help-block",
      messages: {
        "registration[name]": "can't be blank",
        "registration[email]": "can't be blank",
        "registration[phone]": "can't be blank",
        "registration[current_city]": "can't be blank",
        "registration[native_city]": "can't be blank",
        "registration[year_of_passing]": "can't be blank"
      },
      highlight: function(element) {
          $(element).parent().parent().addClass("has-error");
      },
      unhighlight: function(element) {
          $(element).parent().parent().removeClass("has-error");
      },
      invalidHandler: function(registration, validator) {
        // 'this' refers to the form
        var errors = validator.numberOfInvalids();
        if (errors) {

          // Populating error message
          var errorMessage = errors == 1
            ? 'You missed 1 field. It has been highlighted'
            : 'You missed ' + errors + ' fields. They have been highlighted';

          // Removing the form error if it already exists
          var errorHtml = "<div class=\"alert alert-danger\" data-alert=\"alert\" style=\"margin-bottom:5px;\">"+ errorMessage +"</div>"
          $("#registration_form_error").html(errorHtml);

          // Show error labels
          $("div.error").show();

        } else {
          // Hide error labels
          $("div.error").hide();

          // Removing the error message
          $("#registration_form_error").remove();
        }
      }

    });

}
