require_relative '../views/orders_view'

class OrdersController
  def initialize(meal_repository, employee_repository, customer_repository, order_repository)
    @order_repository = order_repository
    @meal_repository = meal_repository
    @employee_repository = employee_repository
    @customer_repository = customer_repository

    @meals_view = MealsView.new
    @customers_view = CustomersView.new
    @orders_view = OrdersView.new

  end

  def add
    @meals_view.display(@meal_repository.all)
    meal_id = @orders_view.ask_id
    meal = @meal_repository.find(meal_id)

    @customers_view.display(@customer_repository.all)
    customer_id = @orders_view.ask_id
    customer = @customer_repository.find(customer_id)

    @orders_view.list_delivery_guys(@employee_repository.all_delivery_guys)
    employee_id = @orders_view.ask_id
    employee = @employee_repository.find(employee_id)

    new_order = Order.new(meal: meal, customer: customer, employee: employee)

    @order_repository.add(new_order)
  end

  def list_undelivered_orders
    undelivered_orders = @order_repository.undelivered_orders
    @orders_view.display(undelivered_orders)
  end

  def list_orders
    my_orders = @order_repository.all
    @orders_view.display(my_orders)
  end


  def list_my_orders(employee)
    my_orders = @order_repository.orders_by(employee)
    @orders_view.display(my_orders)
  end

  def list_my_undelivered_orders(employee)
    my_undelivered_orders = @order_repository.orders_by(employee).reject { |order| order.delivered? }
    @orders_view.display(my_undelivered_orders)
  end


  def mark_as_delivered(employee)
    my_undelivered_orders = @order_repository.orders_by(employee).reject { |order| order.delivered? }

    @orders_view.display(my_undelivered_orders)
    order_id = @orders_view.ask_id
    order = @order_repository.find(order_id)

    order.deliver!

    @order_repository.save_csv

  end

end