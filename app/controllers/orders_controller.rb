require_relative "../models/order"
require_relative "../views/orders_view"
class OrdersController
  def initialize(order_repository, customer_repository, meal_repository, employee_repository)
    @order_repository = order_repository
    @meal_repository = meal_repository
    @employee_repository = employee_repository
    @customer_repository =customer_repository
    @view = OrdersView.new
  end

  def add
    # ask the user for the id
    puts "please choose the customer"
    customers = @customer_repository.all
    @view.list(customers)
    cust_id = @view.ask_for("customer_id").to_i
    customer = @customer_repository.find(cust_id)
    meals = @meal_repository.all
    @view.list(meals)
    meal_id = @view.ask_for("meal_id").to_i
    meal = @meal_repository.find(meal_id)
    employees = @employee_repository.all
    @view.list(employees)
    employee_id = @view.ask_for("employee_id").to_i
    employee = @employee_repository.find(employee_id)
    order = Order.new(customer: customer, meal: meal, employee: employee)
    @order_repository.add(order)
  end

  def list_undelivered_employee_orders(employee)
    orders = @order_repository.all.select {|order| !order.delivered && order.employee == employee}
    @view.list_undelivered(orders)
  end

  def mark_as_delivered(employee)
    list_undelivered_employee_orders(employee)
    id = @view.ask_for_order_id
    @order_repository.mark_as_delivered(id)
    @view.delivered
  end

  def list_undelivered
    orders = @order_repository.all.select {|order| !order.delivered}
    @view.list_undelivered(orders)
  end
end

