// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function choose_date(){
    $( "#weight_point_date" ).datepicker({ firstDay: 1,
					   defaultDate: "-1j",
					   changeYear: true,
					   dateFormat: 'yy-mm-dd',
					   navigationAsDateFormat: true,
					   dayNamesMin: [ "Di", "Lu", "Ma", "Me", "Je", "Ve", "Sa" ],
					   monthNames: [ "Janvier", "Février", "Mars", "Avril", "Mai", "Juin",
							 "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre" ]});
}

function change_weight() {
    $("#weight_point_weight").change(function(){
	$("#weight_error").addClass("hidden");
	$("#weight_error").hide();
    });
}

function change_date() {
    $(".datepicker").change(function(){
	$("#date_error").addClass("hidden");
	$("#date_error").hide();
    });
 }

function submit_weight(){
    $("#new_weight_point").submit(function(e) {
	var value = true;
	var today = new Date();
	var cmp = new Date($(".datepicker").val());
	var res = today.getTime() - cmp.getTime();
	if ($("#weight_point_weight").val().length == 0 || $(".weight_val").val() < 0) {
	    value = false;
	    $("#weight_error").removeClass("hidden");
	    $("#weight_error").show();
	}
	if ($(".datepicker").val().length == 0 || res < 0) {
	    value = false;
	    $("#date_error").removeClass("hidden");
	    $("#date_error").show();
	}
	if (value == true)
	    $(this).submit();
	return false;
    });
}