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

function populateUnassignedList(){
  $("#unassigned-shipment-list").empty();
  $.get("/dispatch/unassignedshipments", function (shipmentData){
    shipmentData.forEach(function(shipment){
      let newRow = "<tr><td>" + shipment.id + "</td><td>" + shipment.client.name + "</td><td>" + getFormattedDate(shipment.pickup_date) + "</td><td>" + getFormattedDate(shipment.delivery_date) + "</td></tr>"
      $("#unassigned-shipment-list").append(newRow);
    });
  });
}

function populateAssignedList(){
  $("#assigned-shipment-list").empty();
  let dateFilter = getDashedDate($("#date-filter-value").val());
  $.get("/dispatch/assignedshipments/" + dateFilter, function (shipmentData){
    shipmentData.forEach(function(shipment){
      let newRow = "<tr><td>" + shipment.id + "</td><td>" + shipment.client.name + "</td></tr>"
      $("#assigned-shipment-list").append(newRow);
    });
  });
}

function refreshShipmentLists(){
  populateUnassignedList();
  populateAssignedList();
}

function dateFilterListener(){
  $("#date-filter").on('click', () => refreshShipmentLists());
}

function addRowClass(){
  $(this).attr("class", "row")
}

function rowListeners(){
  $('#drivers tbody tr td').on('click', function(){
    $('#drivers tbody tr td').removeClass("selected-driver");
    $(this).toggleClass('selected-driver');
  });
}

function addListeners(){
  dateFilterListener();
  rowListeners();
}

$(function (){
  refreshShipmentLists();
  addListeners();
})
