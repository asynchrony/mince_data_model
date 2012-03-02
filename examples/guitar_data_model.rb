require_relative '../lib/mince_data_model'

class GuitarDataModel
  include MinceDataModel

  data_collection :guitars
  data_fields :brand, :price, :type, :color
end