// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function create_home()
{
  home = { "home" : { "name" : $("#home_name").val(), "street" : $("#home_street").val(), "zipcode": $("#home_zipcode").val(), "city": $("#home_city").val() } }
  if (!home["home"]["name"])
    home["home"]["name"] = ""
  if (!home["home"]["street"])
    home["home"]["street"] = ""
  if (!home["home"]["zipcode"])
    home["home"]["zipcode"] = ""
  if (!home["home"]["city"])
    home["home"]["city"] = ""
  
  if (home["home"]["name"] == "" || home["home"]["street"] == "" || home["home"]["zipcode"] == "" || home["home"]["city"] == "")
  {
    var body_content = "<div class='alert alert-danger fade in flash'><button class='close' data-dismiss='alert'>×</button>" +
                  "Vous devez remplir tous les champs</div>" +
                  "<div class='field'>" +
                    "<label for='home_name'>Name</label><br>" +
                    "<input id='home_name' name='home[name]' type='text' value='" + home["home"]["name"] + "'>" +
                  "</div>" +
                  "<div class='field'>" +
                    "<label for='home_street'>Street</label><br>" +
                    "<input id='home_street' name='home[street]' type='text' value='" + home["home"]["street"] + "'>" +
                  "</div>" +
                  "<div class='field'>" +
                    "<label for='home_zipcode'>Zipcode</label><br>" +
                    "<input id='home_zipcode' name='home[zipcode]' type='text' value='" + home["home"]["zipcode"] + "'>" +
                  "</div>" +
                  "<div class='field'>" +
                    "<label for='home_city'>City</label><br>" +
                    "<input id='home_city' name='home[city]' type='text' value='" + home["home"]["city"] + "'>" +
                  "</div>"
    $(".modal-body").empty();
    $(".modal-body").append(body_content);

    $(".modal-footer").empty();
    $(".modal-footer").append("<button type='button' class='btn btn-danger' data-dismiss='modal'>Close</button>" +
                "<input class='btn btn-success' name='commit' onclick='create_home();return false;' type='submit' value='Envoyer'>");
  }
  else
  {
    var token = window.currentUser["token"];
    var ret;
    $.ajax({
      type: 'POST',
      beforeSend: function(xhr, settings) { xhr.setRequestHeader('Authorization','Token token=' + token ); },
      url: window.location["origin"] + '/homes.json',
      header: {"Authorization" : "Token token=" + token },
      dataType: 'json',
      data: home,
      async: false,
      timeout: 30000,
      success: function(responseData, textStatus, jqXHR) {
        ret = responseData;
        if (ret["status"] == "OK")
        {
          $('#home_modal').modal('hide');
          var msg = "<div class='alert alert-success fade in flash'><button class='close' data-dismiss='alert'>×</button>" +
          ret["message"] + "</div>";
          $(".content").before(msg);
          $("#home_details").empty();
          $("#home_details").append("Vous faite partie du foyer " + ret["data"]["home"]["name"] +
                  ". Vous souhaitez en changer ?" +
                  "<button class='btn btn-success' data-toggle='modal' data-target='#home_modal' style='margin-left: 10px;'>" +
                    "Choisir un nouveau foyer" +
                  "</button>");
        }
        else
        {
          $('#home_modal').modal('hide');
          var msg = "<div class='alert alert-error fade in flash'><button class='close' data-dismiss='alert'>×</button>" +
          ret["message"] + "</div>";
          $(".content").before(msg);
        }
      },
      error: function (responseData, textStatus, errorThrown) {
        console.warn(responseData, textStatus, errorThrown);
      }
    });
  }
}

function choose_home(form)
{
  var token = window.currentUser["token"];
  var ret;
  form[0].id = "home_form"
  var id = $( "#home_form option:selected" ).val();
  $.ajax({
    type: 'POST',
    beforeSend: function(xhr, settings) { xhr.setRequestHeader('Authorization','Token token=' + token ); },
    url: window.location["origin"] + '/homes/choose.json',
    header: {"Authorization" : "Token token=" + token },
    dataType: 'json',
    data: { "home" : { "id" : id } },
    async: false,
    timeout: 30000,
    success: function(responseData, textStatus, jqXHR) {
      if (responseData["success"])
      {
        $('#home_modal').modal('hide');
        var msg = "<div class='alert alert-success fade in flash'><button class='close' data-dismiss='alert'>×</button>" +
        responseData["success"] + "</div>";
        $(".content").before(msg);
        $("#home_details").empty();
        $("#home_details").append("Vous faite partie du foyer" + responseData["home"]["name"] +
                "Vous souhaitez en changer ?" +
                "<button class='btn btn-success' data-toggle='modal' data-target='#home_modal' style='margin-left: 10px;'>" +
                  "Choisir un nouveau foyer" +
                "</button>");
      }
      else
      {
        $('#home_modal').modal('hide');
        var msg = "<div class='alert alert-error fade in'><button class='close' data-dismiss='alert'>×</button>" +
        responseData["error"] + "</div>";
        $(".content").before(msg);
      }
    },
    error: function (responseData, textStatus, errorThrown) {
      console.warn(responseData, textStatus, errorThrown);
    }
  });
  
}

function searchHomes()
{
  var homes = [];
  var home = { "home": { "name": $("#home_name").val(), "street": $("#home_street").val(), "zipcode": $("#home_zipcode").val(), "city": $("#home_city").val() } }
  $.ajax({
    type: 'POST',
    beforeSend: function(xhr, settings) { xhr.setRequestHeader('Authorization','Token token=' + window.currentUser["token"] ); },
    url: window.location["origin"] + '/homes/search.json',
    header: {"Authorization" : "Token token=" + window.currentUser["token"] },
    dataType: 'json',
    data: home,
    async: false,
    timeout: 30000,
    success: function(responseData, textStatus, jqXHR) {
      homes = responseData;
    },
    error: function (responseData, textStatus, errorThrown) {
      console.warn(responseData, textStatus, errorThrown);
    }
  });
  if (homes.length > 0)
  {
    $(".modal-body").empty();
    if (homes.length == 1)
      var str = "<p>1 foyer a été trouvé(s).</p>";
    else
      var str = homes.length + " foyés ont étés trouvés"
    
    var select = ""
    
    $.each(homes, function(index, value) {
      select += "<option value='" + value["id"] + "'>" +
      value["name"] + " - " + value["street"] + ", " + value["zipcode"] + ", " + value["city"] + "</option>"
    });
    
    var home_name = home["home"]["name"];
      
    $(".modal-body").append(str + 
                            "<p>Vous pouvez en choisir un dans la liste ou en créer un.</p>" +
                            "<form>" +
                            "<select name='home[id]'><option value='' disabled selected style='display:none;'>Faites votre choix</option>" + select +
                            "</select><button class='btn btn-success' onclick='choose_home($(this).parent());return false;'>Choisir</button></form>" +
                            "<br/><button class='btn btn-success' onclick='create_home();return false;'>Créer</button>");
    $(".modal-footer").empty();
  }
  else
  {
    var content = $(".modal-body");
    $(".modal-body").empty();
    $(".modal-body").append("Aucun foyé n'a été trouvé. Nous vous invitons a le créer.");
    
    var home_name = typeof $("#home_name").val() !== 'undefined' ? $("#home_name").val() : ""
    var home_street = typeof $("#home_street").val() !== 'undefined' ? $("#home_street").val() : ""
    var home_zipcode = typeof $("#home_zipcode").val() !== 'undefined' ? $("#home_zipcode").val() : ""
    var home_city = typeof $("#home_city").val() !== 'undefined' ? $("#home_city").val() : ""
    
    home = { "home": { "name": home_name, "street": home_street, "zipcode": home_zipcode, "city": home_city } };
      var body_content = "<div class='field'>" +
                      "<label for='home_name'>"+ I18n.activerecord.attributes.home.name +"</label><br>" +
                      "<input id='home_name' name='home[name]' type='text' value='" + home["home"]["name"] + "'>" +
                    "</div>" +
                    "<div class='field'>" +
                      "<label for='home_street'>"+ I18n.activerecord.attributes.home.street +"</label><br>" +
                      "<input id='home_street' name='home[street]' type='text' value='" + home["home"]["street"] + "'>" +
                    "</div>" +
                    "<div class='field'>" +
                      "<label for='home_zipcode'>"+ I18n.activerecord.attributes.home.zipcode +"</label><br>" +
                      "<input id='home_zipcode' name='home[zipcode]' type='text' value='" + home["home"]["zipcode"] + "'>" +
                    "</div>" +
                    "<div class='field'>" +
                      "<label for='home_city'>"+ I18n.activerecord.attributes.home.city +"</label><br>" +
                      "<input id='home_city' name='home[city]' type='text' value='" + home["home"]["city"] + "'>" +
                    "</div>"
      $(".modal-body").append(body_content);
    
      $(".modal-footer").empty();
      $(".modal-footer").append("<button type='button' class='btn btn-danger' data-dismiss='modal'>Close</button>" +
                  "<input class='btn btn-success' name='commit' onclick='create_home();return false;' type='submit' value='Créer'>");
    }
    
}