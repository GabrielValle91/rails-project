function getFormattedDate(date) {
  var d = new Date(date);
  var year = d.getFullYear();
  var month = (1 + d.getMonth()).toString();
  month = month.length > 1 ? month : '0' + month;
  var day = d.getDate() + 1;
  day = day.toString();
  day = day.length > 1 ? day : '0' + day;
  return month + '/' + day + '/' + year;
}

function getDashedDate(date){
  var d = new Date(date);
  var year = d.getFullYear();
  var month = (1 + d.getMonth()).toString();
  month = month.length > 1 ? month : '0' + month;
  var day = d.getDate() + 1;
  day = day.toString();
  day = day.length > 1 ? day : '0' + day;
  return month + '-' + day + '-' + year;
}

function highlightUnassignedShipments(id){
  $('#unassigned-shipment-list tr').removeClass("selected-shipment");
  $("#USId-" + id).toggleClass('selected-shipment');
}

function populateUnassignedDetails(id){
  $("#unassigned-shipment-details p").empty();
  $.get("/shipments/" + id + ".json", function (shipmentData){
    $("#unassigned-shipment-reference").html("Reference: " + shipmentData["reference"]);
    $("#unassigned-shipment-status").html("Status: " + shipmentData["status"]);
    let shipperId = shipmentData["shipment_details"][0]["location_id"];
    let consigneeId = shipmentData["shipment_details"][1]["location_id"];
    let pickupDriverId = shipmentData["shipment_details"][0]["driver_id"];
    let deliveryDriverId = shipmentData["shipment_details"][1]["driver_id"];
    if (shipperId){
      $.get("/locations/" + shipperId + ".json", function(locationData) {
        $("#unassigned-shipment-pickup-company").html("Shipper: " + locationData["company_name"]);
        $("#unassigned-shipment-pickup-address").html("Address: " + locationData["address1"] + " " + locationData["address2"]);
        $("#unassigned-shipment-pickup-city").html("City: " + locationData["city"] + ", " + locationData["state"] + " " + locationData["zip_code"]);
      });
    }
    if (pickupDriverId){
      $.get("/drivers/" + pickupDriverId + ".json", function(driverData){
        $("#unassigned-shipment-pickup-driver").html("Pickup Driver: " + driverData["name"]);
      });
    }
    if (consigneeId){
      $.get("/locations/" + consigneeId + ".json", function(locationData){
        $("#unassigned-shipment-delivery-company").html("Consignee: " + locationData["company_name"]);
        $("#unassigned-shipment-delivery-address").html("Address: " + locationData["address1"] + " " + locationData["address2"]);
        $("#unassigned-shipment-delivery-city").html("City: " + locationData["city"] + ", " + locationData["state"] + " " + locationData["zip_code"]);
      });
    }
    if (deliveryDriverId){
      $.get("/drivers/" + deliveryDriverId + ".json", function(driverData){
        $("#unassigned-shipment-delivery-driver").html("Delivery Driver: " + driverData["name"]);
      });
    }
  });
}

function unassignedShipmentListener(id){
  highlightUnassignedShipments(id);
  populateUnassignedDetails(id);
}

function highlightAssignedShipments(id){
  $('#assigned-shipment-list tr').removeClass("selected-shipment");
  $("#ASId-" + id).toggleClass('selected-shipment');
}

function populateAssignedDetails(id){
  $("#assigned-shipment-details p").empty();
  $.get("/shipments/" + id + ".json", function (shipmentData){
    $("#assigned-shipment-id").html("Shipment Id: " + shipmentData["id"]);
    $("#assigned-client-name").html("Client: " + shipmentData["client"]["name"]);
    $("#assigned-shipment-reference").html("Reference: " + shipmentData["reference"]);
    $("#assigned-shipment-pickup-date").html("Pickup Date: " + shipmentData["pickup_date"]);
    $("#assigned-shipment-delivery-date").html("Delivery Date: " + shipmentData["delivery_date"]);
    $("#assigned-shipment-status").html("Status: " + shipmentData["status"]);
    let shipperId = shipmentData["shipment_details"][0]["location_id"];
    let consigneeId = shipmentData["shipment_details"][1]["location_id"];
    let pickupDriverId = shipmentData["shipment_details"][0]["driver_id"];
    let deliveryDriverId = shipmentData["shipment_details"][1]["driver_id"];
    if (shipperId){
      $.get("/locations/" + shipperId + ".json", function(locationData) {
        $("#assigned-shipment-pickup-company").html("Shipper: " + locationData["company_name"]);
        $("#assigned-shipment-pickup-address").html("Address: " + locationData["address1"] + " " + locationData["address2"]);
        $("#assigned-shipment-pickup-city").html("City: " + locationData["city"] + ", " + locationData["state"] + " " + locationData["zip_code"]);
      });
    }
    if (pickupDriverId){
      $.get("/drivers/" + pickupDriverId + ".json", function(driverData){
        $("#assigned-shipment-pickup-driver").html("Pickup Driver: " + driverData["name"]);
      });
    }
    if (consigneeId){
      $.get("/locations/" + consigneeId + ".json", function(locationData){
        $("#assigned-shipment-delivery-company").html("Consignee: " + locationData["company_name"]);
        $("#assigned-shipment-delivery-address").html("Address: " + locationData["address1"] + " " + locationData["address2"]);
        $("#assigned-shipment-delivery-city").html("City: " + locationData["city"] + ", " + locationData["state"] + " " + locationData["zip_code"]);
      });
    }
    if (deliveryDriverId){
      $.get("/drivers/" + deliveryDriverId + ".json", function(driverData){
        $("#assigned-shipment-delivery-driver").html("Delivery Driver: " + driverData["name"]);
      });
    }
  });
}

function assignedShipmentListener(id){
  highlightAssignedShipments(id);
  populateAssignedDetails(id);
}

function populateUnassignedList(){
  $("#unassigned-shipment-list").empty();
  $.get("/dispatch/unassignedshipments", function (shipmentData){
    shipmentData.forEach(function(shipment){
      let newRow = `<tr id="USId-${shipment.id}"><td>${shipment.id}</td><td>${shipment.client.name}</td><td>${getFormattedDate(shipment.pickup_date)}</td><td>${getFormattedDate(shipment.delivery_date)}</td></tr>`
      $("#unassigned-shipment-list").append(newRow);
      $("#USId-" + shipment.id).on('click', () => unassignedShipmentListener(shipment.id));
    });
  });
}

function populateAssignedList(driver){
  $("#assigned-shipment-list").empty();
  let dateFilter = getDashedDate($("#date-filter-value").val());
  $.get("/dispatch/assignedshipments/" + dateFilter, function (shipmentData){
    if (!driver) {
      shipmentData.forEach(function(shipment){
        let newRow = `<tr id="ASId-${shipment.id}"><td>${shipment.id}</td><td>${shipment.client.name}</td><td>${shipment.status}</td></tr>`
        $("#assigned-shipment-list").append(newRow);
        $("#ASId-" + shipment.id).on('click', () => assignedShipmentListener(shipment.id));
      });
    } else {
      shipmentData.forEach(function(shipment){
        if (shipment["shipment_details"][0]["driver_id"] == driver || shipment["shipment_details"][1]["driver_id"] == driver){
          let newRow = `<tr id="ASId-${shipment.id}"><td>${shipment.id}</td><td>${shipment.client.name}</td><td>${shipment.status}</td></tr>`
          $("#assigned-shipment-list").append(newRow);
          $("#ASId-" + shipment.id).on('click', () => assignedShipmentListener(shipment.id));
        }
      });
    }
  });
}

function refreshShipmentLists(){
  populateUnassignedList();
  populateAssignedList(0);
  $('#drivers tbody tr td').removeClass("selected-driver");
  $("#assigned-shipment-details p").empty();
  $("#unassigned-shipment-details p").empty();
}

function dateFilterListener(){
  $("#date-filter").on('click', () => refreshShipmentLists());
}

function driverRowListeners(){
  $('#drivers tbody tr td').on('click', function(){
    $('#drivers tbody tr td').removeClass("selected-driver");
    $(this).toggleClass('selected-driver');
    let driverId = $(this).attr("id");
    populateAssignedList(driverId);
  });
}

function addListeners(){
  dateFilterListener();
  driverRowListeners();
}

$(function (){
  refreshShipmentLists();
  addListeners();
})
