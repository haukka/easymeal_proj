// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function emptydiv_disease(){
    if ($("#disease_id").children().length == 0){
	$("#disease_id").append( "<p>Vous ne possédez pas de Maladie.</p>" );
    }
}

function select_disease(){
    $("#diseases_select").change(function() {
	$.ajax({
	    data: {
		disease_id : $('#diseases_select').val()
	    },
	    dataType: "script"
	});
    });
}

function add_disease(){
    $("#new_disease").submit(function(e) {
	if ($("#diseases_select option:selected").val() > 0) {
	    var selectval = $("#diseases_select option:selected").text();
	    $("#disease").val(selectval);
	    $("#new_disease").submit();
	} else{
	    return false;
	}
	return false;
    });
}

function select_diet(){
    $("#diettypes_select").change(function() {
	$.ajax({
	    data: {
		diet_type_id : $('#diettypes_select').val()
	    },
	    dataType: "script"
	});
    });
}

function submit_diet() {
    $("#new_diet_type").submit(function(e) {
	if ($("#diettypes_select option:selected").val() > 0) {
	    var selectval = $("#diettypes_select option:selected").text();
	    $("#dietname").val(selectval);
	    $("#new_diet_type").submit();
	} else{
	    return false;
	}
	return false;
    });
}
