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

function assignedShipmentListener(id){
  $('#assigned-shipment-list tr').removeClass("selected-shipment");
  $("#ASId-" + id).toggleClass('selected-shipment');
}

function populateUnassignedList(){
  $("#unassigned-shipment-list").empty();
  $.get("/dispatch/unassignedshipments", function (shipmentData){
    shipmentData.forEach(function(shipment){
      let newRow = "<tr><td>" + shipment.id + "</td><td>" + shipment.client.name + "</td><td>" + getFormattedDate(shipment.pickup_date) + "</td><td>" + getFormattedDate(shipment.delivery_date) + "</td></tr>"
      $("#unassigned-shipment-list").append(newRow);
    });
  });
}

function populateAssignedList(driver){
  $("#assigned-shipment-list").empty();
  let dateFilter = getDashedDate($("#date-filter-value").val());
  $.get("/dispatch/assignedshipments/" + dateFilter, function (shipmentData){
    if (!driver) {
      shipmentData.forEach(function(shipment){
        let newRow = `<tr id="ASId-${shipment.id}"><td>${shipment.id}</td><td>${shipment.client.name}</td></tr>`
        $("#assigned-shipment-list").append(newRow);
        $("#ASId-" + shipment.id).on('click', () => assignedShipmentListener(shipment.id));
      });
    } else {
      shipmentData.forEach(function(shipment){
        if (shipment["shipment_details"][0]["driver_id"] == driver || shipment["shipment_details"][1]["driver_id"] == driver){
          let newRow = `<tr id="ASId-${shipment.id}"><td>${shipment.id}</td><td>${shipment.client.name}</td></tr>`
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
