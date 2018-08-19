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
});
