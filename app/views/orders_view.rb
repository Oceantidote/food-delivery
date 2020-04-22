class OrdersView
  def ask_for(thing)
    puts "please enter the desired #{thing}"
    gets.chomp
  end

  def list_undelivered(orders)
    orders.each do |order|
      puts "#{order.id} meal: #{order.meal.id} customer: #{order.customer.id} employee: #{order.employee.id} delivered: #{order.delivered}"
    end
  end

  def list(things)
    things.each do |thing|
      puts "#{thing.id} - #{thing.name}"
    end
  end

  def ask_for_order_id
    puts "Please enter te id of the order you have just delivered"
    gets.chomp.to_i
  end

  def delivered
    puts "Order successfully marked as delivered!"
  end
end
