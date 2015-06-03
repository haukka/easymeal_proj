// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function samePasswords()
{
  if($("#user_password_confirmation").val() != $("#user_password").val())
  {
    $("#password_error").removeClass("hidden");
    $("#password_error").show();
    return false;
  }
  else
  {
    $("#password_error").hide();
    return true;
  }
}

function currentPassword()
{
  if($("#user_current_password").val().length >= 6)
    return true;
  else
    return false;
}

function passwordValid()
{
  if($("#user_password_confirmation").val().length >= 6)
    return true;
  else
    return false;
}

function step1()
{
  $("#step2").hide();
  $("#step3").hide();
  $("#step1").show();
  return false;
}

function step2()
{
  $("#step1").hide();
  $("#step3").hide();
  $("#step2").show();
  $("#step2").removeClass("hidden");
  return false;
}

function step3()
{
  $("#step1").hide();
  $("#step2").hide();
  $("#step3").show();
  $("#step3").removeClass("hidden");
  return false;
}

function nextButtonStep1(passwordsOk)
{
  if (passwordsOk && $("#user_username").val() != "" && $("#user_mail").val() != "" &&
    $("#user_password").val() != "" && $("#user_password_comfirmation").val() != "")
    {
      $("#nextStep1button").removeClass("disabled");
    }
  else
    $("#nextStep1button").addClass("disabled");
}

function nextButtonStep2()
{
  if ($("#user_firstname").val() != "" && $("#user_lastname").val() != "")
    {
      $("#nextStep2button").removeClass("disabled");
    }
  else
  {
    $("#nextStep2button").addClass("disabled");
  }
}

function password_success()
{
  $('#user_password').val("");
  $('#user_password_confirmation').val("");
  $("#submit_button").addClass("disabled");
  var msg = "<div class='alert alert-success fade in flash' style='margin: 5px auto -20px auto;'><button class='close' data-dismiss='alert'>×</button>" +
  "Votre mot de passe a été changé avec succès.</div>";
  $(".content").before(msg);
}
