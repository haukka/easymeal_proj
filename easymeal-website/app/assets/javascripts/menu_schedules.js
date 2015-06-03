// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function empty_carousel()
{
  $("#count").empty();
  while ($(".owl-item").length != 0)
  { 
      $("#carousel").data('owlCarousel').removeItem();
  }
}

function associate(elem)
{
  var date = elem.find("input[name='date']").val();
  var token = elem.find("input[name='token']").val();
  var meal = parseInt(elem.find("input[name='meal']").val());
  var meal_name = elem.find("input[name='meal_name']").val();
  var user = parseInt(elem.find("input[name='user']").val());
  var recipe = parseInt(elem.find("input[name='recipe']").val());

   $.ajax({
       type: "POST",
       dataType: "json",
       data: { date: date, meal: meal, user: user, recipe: recipe },
       url: '/menu_schedule/associate',
       async: false
   })
   .done(function( data )
   {
     if (data["status"] == "OK")
     {
       location.reload(true);
       $("#" + date + " ." + meal_name + "> .recipes").append("<span class='recipe' data-token=" + token + " data-user=" + user + " data-date=" + date + " data-meal=" + meal_name + " data-id="+ data["response"].recipe_id +" >" + data["response"].recipe_name + "</span>");
	   $("#" + date + " ." + meal_name + "> .glyphicon-pencil").remove();
       $('#planningModal').modal('hide');
     }
   });
   
}

function dissociate(elem)
{
    var date = elem.attr("data-date");
    var meal = parseInt(elem.attr("data-meal"));
    var user = parseInt(elem.attr("data-user"));
    var recipe = parseInt(elem.attr("data-id"));
  	var token = elem.attr("data-token");
	
    $.ajaxSetup
    ({
       cache:false,
       beforeSend: function (xhr) { xhr.setRequestHeader('Authorization', 'Token token=' + token); }
     });
	
    $.ajax({
        type: "POST",
        dataType: "json",
        data: { date: date, meal: meal, user: user, recipe: recipe },
        url: '/menu_schedule/dissociate',
        async: false
    })
    .done(function( data )
    {
      if (data["status"] == "OK")
      {
  		  elem.remove();
      }
    });
}

function find_recipes(token, date, meal, user, meal_name)
{
  $.ajaxSetup
  ({
     cache:false,
     beforeSend: function (xhr) { xhr.setRequestHeader('Authorization', 'Token token=' + token); }
   });
          
  $.ajax({
      type: "GET",
      dataType: "json",
      url: '/recipes',
      data: { search: $("input#search").val() },
      async: false
  })
  .done(function( data )
  {
    $("#carousel").owlCarousel({
      // Most important owl features
          items : 3,
          itemsCustom : false,
          singleItem : false,
          itemsScaleUp : false,

          //Autoplay
          autoPlay : false,
          stopOnHover : false,

          // Navigation
          navigation : true,
          navigationText : ["prev","next"],
          rewindNav : true,
          scrollPerPage : false,

          //Pagination
          pagination : true,
          paginationNumbers: false
    });
    $("#count").html(data["response"]["recipes"].length.toString() + " recette(s) trouvée(s).");
    if ($(".owl-item").length != 0)
    {
      empty_carousel();
      data["response"]["recipes"].forEach(function(elem)
      {
          text = '<div><a href="#" class="associate" onclick="associate($(this));return false;">' +
                        '<img alt="'+ elem["name"] +'" src="'+ elem["photo_url"] +'">' +
                        elem["name"] +
                        '<input type="hidden" name="date" value="'+ date +'">' +
                        '<input type="hidden" name="meal" value="'+ meal +'">' +
                        '<input type="hidden" name="meal_name" value="'+ meal_name +'">' +
                        '<input type="hidden" name="user" value="'+ user +'">' +
                        '<input type="hidden" name="recipe" value="'+ elem["id"] +'">' +
                        '<input type="hidden" name="token" value="'+ token +'">' +
                      '</a></div>';
          $("#carousel").data('owlCarousel').addItem(text);
      });
    }
    else
    {
      data["response"]["recipes"].forEach(function(elem)
      {
        
          text = '<div><a href="#" class="associate" onclick="associate($(this));return false;">' +
                                        '<img alt="'+ elem["name"] +'" src="'+ elem["photo_url"] +'">'+
                                        elem["name"] +
                                        '<input type="hidden" name="date" value="'+ date +'">' +
                                        '<input type="hidden" name="meal" value="'+ meal +'">' +
                                        '<input type="hidden" name="meal_name" value="'+ meal_name +'">' +
                                        '<input type="hidden" name="user" value="'+ user +'">' +
                                        '<input type="hidden" name="recipe" value="'+ elem["id"] +'">' +
                                        '<input type="hidden" name="token" value="'+ token +'">' +
                                      '</a></div>';
                          $("#carousel").data('owlCarousel').addItem(text);
      });
      
    }
  });

}

function show_finder(meal, date, token, user, meal_name)
{
  $("#search").html('<input class="search_bar" id="search" name="search">' +
                    '<input type="hidden" id="meal" name="menu_schedule[meal]" value="' + meal + '">' +
                    '<input type="hidden" id="meal_name" name="menu_schedule[meal_name]" value="' + meal_name + '">' +
                    '<input type="hidden" id="date"name="menu_schedule[date]" value="' + date + '">' +
                    '<button class="btn btn-success" onclick="find_recipes(\''+ token +'\', \''+ date +'\', \''+ meal +'\', \''+ user +'\', \''+ meal_name +'\');">' +
                      '<span> OK</span>' +
                    '</button>');
  $('#planningModal').modal('show');
}