$(function(){
  $(".shipment-more-details").on("click", function (){
    $("#client-name").empty();
    $("#shipment-reference").empty();
    $("#shipment-pickup-date").empty();
    $("#shipment-delivery-date").empty();
    $("#shipment-pickup-company").empty();
    $("#shipment-pickup-address").empty();
    $("#shipment-pickup-city").empty();
    $("#shipment-pickup-driver").empty();
    $("#shipment-delivery-company").empty();
    $("#shipment-delivery-address").empty();
    $("#shipment-delivery-city").empty();
    $("#shipment-delivery-driver").empty();
    let id = $(this).data("id");
    $.get("/shipments/" + id + ".json", function (shipmentData){
      $("#shipment-id").html("Shipment Id: " + shipmentData["id"]);
      $("#client-name").html("Client: " + shipmentData["client"]["name"]);
      $("#shipment-reference").html("Reference: " + shipmentData["reference"]);
      $("#shipment-pickup-date").html("Pickup Date: " + shipmentData["pickup_date"]);
      $("#shipment-delivery-date").html("Delivery Date: " + shipmentData["delivery_date"]);
      $("#shipment-status").html("Status: " + shipmentData["status"]);
      let shipperId = shipmentData["shipment_details"][0]["location_id"];
      let consigneeId = shipmentData["shipment_details"][1]["location_id"];
      let pickupDriverId = shipmentData["shipment_details"][0]["driver_id"];
      let deliveryDriverId = shipmentData["shipment_details"][1]["driver_id"];
      if (shipperId){
        $.get("/locations/" + shipperId + ".json", function(locationData) {
          $("#shipment-pickup-company").html("Shipper: " + locationData["company_name"]);
          $("#shipment-pickup-address").html("Address: " + locationData["address1"] + " " + locationData["address2"]);
          $("#shipment-pickup-city").html("City: " + locationData["city"] + ", " + locationData["state"] + " " + locationData["zip_code"]);
        });
      }
      if (pickupDriverId){
        $.get("/drivers/" + pickupDriverId + ".json", function(driverData){
          $("#shipment-pickup-driver").html("Pickup Driver: " + driverData["name"]);
        });
      }
      if (consigneeId){
        $.get("/locations/" + consigneeId + ".json", function(locationData){
          $("#shipment-delivery-company").html("Consignee: " + locationData["company_name"]);
          $("#shipment-delivery-address").html("Address: " + locationData["address1"] + " " + locationData["address2"]);
          $("#shipment-delivery-city").html("City: " + locationData["city"] + ", " + locationData["state"] + " " + locationData["zip_code"]);
        });
      }
      if (deliveryDriverId){
        $.get("/drivers/" + deliveryDriverId + ".json", function(driverData){
          $("#shipment-delivery-driver").html("Delivery Driver: " + driverData["name"]);
        });
      }
    });
  });
})
