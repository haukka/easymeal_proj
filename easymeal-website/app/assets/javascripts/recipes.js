// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function change_name() {
    $("#name").change(function(){
	$("#name_error").addClass("hidden");
	$("#name_error").hide();
    });
}

function change_time() {
    $("#time").change(function(){
	$("#time_error").addClass("hidden");
	$("#time_error").hide();
    });
}

function change_price() {
    $("#price").change(function(){
	$("#price_error").addClass("hidden");
	$("#price_error").hide();
    });
}

function change_difficulty() {
    $("#difficulty").change(function(){
	$("#difficulty_error").addClass("hidden");
	$("#difficulty_error").hide();
    });
}

function change_calorie() {
    $("#calorie").change(function(){
	$("#calorie_error").addClass("hidden");
	$("#calorie_error").hide();
    });
}

function change_prep() {
    $("#textprep").change(function(){
	$("#prep_error").addClass("hidden");
	$("#prep_error").hide();
    });
}

function check_data(){
    var val = 0;
    if ($("#name").val().length == 0)
    {
	$("#name_error").removeClass("hidden");
	$("#name_error").show();
	val = 1;
    }
    if ($("#time").val().length == 0){
	$("#time_error").removeClass("hidden");
	$("#time_error").show();
	val = 1;
    }
    if ($("#difficulty").val().length == 0){
	$("#difficulty_error").removeClass("hidden");
	$("#difficulty_error").show();
	val = 1;
    }
    if ($("#calorie").val().length == 0){
	$("#calorie_error").removeClass("hidden");
	$("#calorie_error").show();
	val = 1;
    }
    if ($("#price").val().length == 0){
	$("#price_error").removeClass("hidden");
	$("#price_error").show();
	val = 1;
    }
    if ($("#textprep").val().length == 0){
	$("#prep_error").removeClass("hidden");
	$("#prep_error").show();
	val = 1;
    }
    return val;
}

function valid_textarea(){
    $(".new_recipe").submit(function(e){
	var valid = false;
	if (check_data() == 0)
	    valid = true;
	var txt = $("#textprep").val();
	if (txt.length > 0 && valid == true) {
	    var size = txt.length-1;
	    if (txt.charAt(size) != '.'){
		txt = txt + '.';
	    }
	    var res = txt.split(".");
	    var str = "";
	    var i = 0;
	    while (i < res.length-1){
		str += "<ol>"+ res[i] + "</ol>";
		i++;
	    }
	    $("#textprep").val(str);
	    return true;
	}
	return false;
    });
}

function empty_recipe(){
    if ($("#recipe_id").children().length == 0){
	$("#recipe_id").css({height: '100px'});
	$("#recipe_id").append( "<h2>Aucune recettes n'a été trouvé</h2>" );
    }
}

function show_table() {
    if ($("#table tr").length == 1) {
	$("#table").hide();
	$("#preptable").hide();
    }
}

function add_aliment()
{
  qty = $("#quantity").val();
  aliment = $("#aliment").val();
  aliment_id = $("#aliment_id").val();
  $("#aliments_list").append("<li>"+ qty +" "+ aliment +"<input type='hidden' recipes[qtys] class='qtys' value='"+qty+"'/><input type='hidden' recipe[aliments] class='aliments' value='"+aliment_id+"'/></li>");
  $("#quantity").val("");
  $("#aliment").val("");
}
