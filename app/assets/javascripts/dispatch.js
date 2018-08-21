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

function assignPuDriver(){
  let driverId = $("#pu-driver").val();
  let driverName = $("#pu-driver").text;
  let sId = parseInt($("#unassigned-shipment-list tr.selected-shipment td:first")[0].innerHTML);
  let shipmentData = {
    'shipment':{
      'location_shipper': {
        'driver_id': driverId
      }
    }
  }
  $.ajax({
    type: 'PATCH',
    url: `/shipments/${sId}`,
    data: shipmentData
  })
  .done(function(){
    alert('good');
    $("#unassigned-shipment-pickup-driver").html("Pickup Driver: " + driverName);
  })
  .fail(function(response){
    alert(response);
  })
}

function assignDelDriver(){
  let driverId = $("#del-driver").val();
  alert(driverId);
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
    } else {
      $.get("/drivers.json", function(driverData){
        $("#unassigned-shipment-pickup-driver").html('Pickup Driver: <select id="pu-driver"></select>');
        var select = document.getElementById("pu-driver")
        driverData.forEach(function(driver){
          var el = document.createElement("option");
          el.textContent = driver["name"];
          el.value = driver["id"]
          select.appendChild(el);
        });
        let s = 0;
        $("#pu-driver").val(s);
        $("#unassigned-shipment-pickup-driver").append('<button id="assign-pu-driver">Assign</button>')
        $("#assign-pu-driver").on('click', () => assignPuDriver());
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
    } else {
      $.get("/drivers.json", function(driverData){
        $("#unassigned-shipment-delivery-driver").html('Delivery Driver: <select id="del-driver"></select>');
        var select = document.getElementById("del-driver")
        driverData.forEach(function(driver){
          var el = document.createElement("option");
          el.textContent = driver["name"];
          el.value = driver["id"]
          select.appendChild(el);
        });
        $("#unassigned-shipment-delivery-driver").append('<button id="assign-del-driver">Assign</button>')
        let s = 0;
        $("#del-driver").val(s);
        $("#assign-del-driver").on('click', () => assignDelDriver());
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

function UnassignedShipment(id, client_name, pickup_date, delivery_date){
  this.id = id;
  this.clientName = client_name;
  this.pickupDate = pickup_date;
  this.deliveryDate = delivery_date;
}

UnassignedShipment.prototype.displayDetails = function(){
  let newRow = `<tr id="USId-${this.id}"><td>${this.id}</td><td>${this.clientName}</td><td>${getFormattedDate(this.pickupDate)}</td><td>${getFormattedDate(this.deliveryDate)}</td></tr>`
  $("#unassigned-shipment-list").append(newRow);
  $("#USId-" + this.id).on('click', () => unassignedShipmentListener(this.id));
}

function populateUnassignedList(){
  $("#unassigned-shipment-list").empty();
  $.get("/dispatch/unassignedshipments", function (shipmentData){
    shipmentData.forEach(function(shipment){
      let newShipment = new UnassignedShipment(shipment.id, shipment.client.name, shipment.pickup_date, shipment.delivery_date);
      newShipment.displayDetails();
    });
  });
}

function AssignedShipment(id, client_name, status){
  this.id = id;
  this.clientName = client_name;
  this.status = status;
}

AssignedShipment.prototype.displayDetails = function(){
  let newRow = `<tr id="ASId-${this.id}"><td>${this.id}</td><td>${this.clientName}</td><td>${this.status}</td></tr>`
  $("#assigned-shipment-list").append(newRow);
  $("#ASId-" + this.id).on('click', () => assignedShipmentListener(this.id));
}

function populateAssignedList(driver){
  $("#assigned-shipment-list").empty();
  let dateFilter = getDashedDate($("#date-filter-value").val());
  $.get("/dispatch/assignedshipments/" + dateFilter, function (shipmentData){
    if (!driver) {
      shipmentData.forEach(function(shipment){
        let newShipment = new AssignedShipment(shipment.id, shipment.client.name, shipment.status);
        newShipment.displayDetails();
      });
    } else {
      shipmentData.forEach(function(shipment){
        if (shipment["shipment_details"][0]["driver_id"] == driver || shipment["shipment_details"][1]["driver_id"] == driver){
          let newShipment = new AssignedShipment(shipment.id, shipment.client.name, shipment.status);
          newShipment.displayDetails();
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

function shipmentSubmit(){
  $("#new_shipment").on('submit', function(e) {
    e.preventDefault();
    let shipmentData = {
      'authenticity_token': $("input[name='authenticity_token']").val(),
      'shipment': {
        'client_id': $("#shipment_client_id").val(),
        'reference': $("#shipment_reference").val(),
        'pickup_date': $("#shipment_pickup_date").val(),
        'delivery_date': $("#shipment_delivery_date").val(),
        'location_shipper': {
          'id': $("#shipment_location_shipper_id").val(),
          'company_name': $("#shipment_location_shipper_company_name").val(),
          'address1': $("#shipment_location_shipper_address1").val(),
          'address2': $("#shipment_location_shipper_address2").val(),
          'city': $("#shipment_location_shipper_city").val(),
          'state': $("#shipment_location_shipper_state").val(),
          'zip_code': $("#shipment_location_shipper_zip_code").val()
        },
        'location_consignee': {
          'id': $("#shipment_location_consignee_id").val(),
          'company_name': $("#shipment_location_consignee_company_name").val(),
          'address1': $("#shipment_location_consignee_address1").val(),
          'address2': $("#shipment_location_consignee_address2").val(),
          'city': $("#shipment_location_consignee_city").val(),
          'state': $("#shipment_location_consignee_state").val(),
          'zip_code': $("#shipment_location_consignee_zip_code").val()
        }
      }
    };
    let url = this.action + ".json";
    $.post(url, shipmentData, function(shipment){
      let newRow = `<tr id="USId-${shipment.id}"><td>${shipment.id}</td><td>${shipment.client.name}</td><td>${getFormattedDate(shipment.pickup_date)}</td><td>${getFormattedDate(shipment.delivery_date)}</td></tr>`
      $("#unassigned-shipment-list").append(newRow);
      $("#USId-" + shipment.id).on('click', () => unassignedShipmentListener(shipment.id));
    });
  });
  $("#new_shipment input:last").blur();
}

function addListeners(){
  dateFilterListener();
  driverRowListeners();
  shipmentSubmit();
}

$(function (){
  refreshShipmentLists();
  addListeners();
})
