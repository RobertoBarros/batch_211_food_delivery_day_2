class OrdersView

    def ask_id
      puts "Enter the id:"
      gets.chomp.to_i
    end

    def list_delivery_guys(delivery_guys)
      delivery_guys.each do |delivery_guy|
        puts "id: #{delivery_guy.id} - #{delivery_guy.username}"
      end
    end

    def display(orders)
      orders.each do |order|
        delivered = order.delivered? ? '[X]' : '[ ]'

        puts "id: #{order.id} - Customer: #{order.customer.name} | Meal: #{order.meal.name} | Delivered By: #{order.employee.username} | Delivered: #{delivered}"
      end
    end
end