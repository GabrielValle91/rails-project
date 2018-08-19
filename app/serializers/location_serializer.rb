class LocationSerializer < ActiveModel::Serializer
  attributes :id, :company_name, :address1, :address2, :city, :state, :zip_code
end
