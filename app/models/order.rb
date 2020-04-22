class Order
  attr_accessor :id, :delivered
  attr_reader :customer, :meal, :employee

  def initialize(attributes = {})
    @id = attributes[:id]
    @customer = attributes[:customer]
    @meal = attributes[:meal]
    @employee = attributes[:employee]
    @delivered = attributes[:delivered] || false
  end
end
