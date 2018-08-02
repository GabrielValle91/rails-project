module ShipmentsHelper
  def shipping_date(shipment)
    shipment.pickup_date.strftime("%m/%d/%Y - %A")
  end

  def delivery_date(shipment)
    shipment.delivery_date.strftime("%m/%d/%Y - %A")
  end
end
