require_relative 'guitar_data_model'

class Guitar
  attr_reader :brand, :price, :type, :color, :id

  def initialize(attrs)
    @brand = attrs[:brand]
    @price = attrs[:price]
    @type = attrs[:type]
    @color = attrs[:color]
  end

  def store
    @id = GuitarDataModel.store(self)
  end
end