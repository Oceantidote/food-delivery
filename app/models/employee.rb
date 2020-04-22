class Employee
  attr_accessor :id
  attr_reader :name, :password, :manager
  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @password = attributes[:password]
    @manager = attributes[:manager]
  end

end
