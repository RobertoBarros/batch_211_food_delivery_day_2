class Router

  def initialize(meals_controller, customers_controller, orders_controller, sessions_controller )
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @orders_controller = orders_controller
    @sessions_controller = sessions_controller
    @running = true
  end

  def run
    @employee = @sessions_controller.sign_in

    while @running
      if @employee.manager?
        print_manager_actions
        action = gets.chomp.to_i
        dispatch_manager(action)
      else
        print_delivery_guy_actions
        action = gets.chomp.to_i
        dispatch_delivery_guy(action)
      end
    end
    puts "bye bye!!!"
  end

  private

  def print_manager_actions
    puts "---------------------------"
    puts "1. Create new Meal"
    puts "2. List all meals"
    puts "---------------------------"
    puts "3. Create new Customer"
    puts "4. List all customers"
    puts "---------------------------"
    puts "5. Create new order"
    puts "6. View undelivered orders"
    puts "7. View all orders"
    puts "---------------------------"
    puts "99. Quit"
    puts "---------------------------"
  end

  def dispatch_manager(action)
    case action
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list
    when 5 then @orders_controller.add
    when 6 then @orders_controller.list_undelivered_orders
    when 7 then @orders_controller.list_orders
    when 99 then @running = false
    else
      puts "type a valid number"
    end
  end

  def print_delivery_guy_actions
    puts "---------------------------"
    puts "1. List my undelivered orders"
    puts "2. Mark order as delivered"
    puts "---------------------------"
    puts "99. Quit"
    puts "---------------------------"
  end

  def dispatch_delivery_guy(action)
    case action
    when 1 then @orders_controller.list_my_undelivered_orders(@employee)
    when 2 then @orders_controller.mark_as_delivered(@employee)
    when 99 then @running = false
    else
      puts "type a valid number"
    end
  end


end
