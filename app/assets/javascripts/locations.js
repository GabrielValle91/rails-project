$(function() {
  $(".location-details").on('click', function (){
    let id = $(this).data("id");
    $.get("/locations/" + id + ".json", function (locationData){
      let locationDetails = locationData["address1"] + " " + locationData["address2"] + "<br>" + locationData["city"] + ", " + locationData["state"] + locationData["zip_code"]
      $("#location-details-" + id).html(locationDetails);
    });
  });

  $(".hide-location-details").on('click', function(){
    let id = $(this).data("id");
    $("#location-details-" + id).empty();
  });

  $(".next-location").on('click', function(){
    let id = parseInt($("#location-id")["0"].innerHTML);
    let max = $(this).data("max");
    locationShow(id, max);
  });
});

function locationShow (id, max){
  id >= max ? id = 1 : id += 1;
  $.get("/locations/" + id + ".json", function() {
  })
    .success(function(locationData){
      $("#company-name").html(locationData["company_name"]);
      $("#address-1").html(locationData["address1"]);
      $("#address-2").html(locationData["address2"]);
      let locationDetails = locationData["city"] + ", " + locationData["state"] + " " + locationData["zip_code"];
      $("#address-city-state-zip").html(locationDetails);
      $("#location-id").html(id);
    })
    .fail(function (){
      locationShow(id);
    });
}
