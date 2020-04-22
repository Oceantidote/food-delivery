require "csv"
require_relative "../models/order"

class OrderRepository
  def initialize(csv_file, meal_repository, employee_repository, customer_repository)
    @csv_file = csv_file
    @meal_repository = meal_repository
    @employee_repository = employee_repository
    @customer_repository = customer_repository
    @orders = []
    @next_id = 1
    load_csv if File.exist?(@csv_file)
  end

  def all
    @orders
  end

  def add(order)
    order.id = @next_id
    @orders << order
    @next_id += 1
    save_csv
  end

  def mark_as_delivered(id)
    order = find(id)
    order.delivered = true
    save_csv
  end

  def find(id)
    @orders.find { |order| order.id == id }
  end

  private

  def save_csv
    CSV.open(@csv_file, "wb") do |csv|
      csv << %w[id customer meal employee delivered]
      @orders.each do |order|
        csv << [order.id, order.customer.id, order.meal.id, order.employee.id, order.delivered]
      end
    end
  end

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file, csv_options) do |row|
      row[:id] = row[:id].to_i
      row[:customer] = @customer_repository.find(row[:customer].to_i)
      row[:meal] = @meal_repository.find(row[:meal].to_i)
      row[:employee] = @employee_repository.find(row[:employee].to_i)
      row[:delivered] = row[:delivered] == "true"
      @orders << Order.new(row)
    end
    @next_id = @orders.last.id + 1 unless @orders.empty?
  end
end




















