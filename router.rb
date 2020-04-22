class Router
  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @sessions_controller = sessions_controller
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @orders_controller = orders_controller
    @running = true
  end

  def run
    while @running
      @user = @sessions_controller.login
      while @user
        if @user.manager
          manager_menu
          choice = gets.chomp.to_i
          route_manager_action(choice)
        else
          print_menu
          choice = gets.chomp.to_i
          route_action(choice)
        end
      end
      print `clear`
    end
  end

  private




  def manager_menu
    puts "--------------------"
    puts "------- MENU -------"
    puts "--------------------"
    puts "1. Add new meal"
    puts "2. List all meals"
    puts "3. Add new customer"
    puts "4. List all customers"
    puts "5. Add a new order"
    puts "6. List undelivered order"
    puts "7. Logout"
    puts "8. Exit"
    print "> "
  end

  def route_manager_action(choice)
    case choice
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list
    when 5 then @orders_controller.add
    when 6 then @orders_controller.list_undelivered
    when 7 then @user = nil
    when 8 then stop!
    else
      puts "Try again..."
    end
  end

  def print_menu
    puts "--------------------"
    puts "------- MENU -------"
    puts "--------------------"
    puts "1. See all your undelivered orders"
    puts "2. Mark an order as delivered"
    puts "3. Logout"
    puts "4. Exit"
    print "> "
  end

  def route_action(choice)
    case choice
    when 1 then @orders_controller.list_undelivered_employee_orders(@user)
    when 2 then @orders_controller.mark_as_delivered(@user)
    when 3 then @user = nil
    when 4 then stop!
    else
      puts "Try again..."
    end
  end

  def stop!
    @running = false
    @user = nil
  end
end
