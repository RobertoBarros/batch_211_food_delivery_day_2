class OrderRepository
  CSV_OPTIONS = {headers: :first_row, header_converters: :symbol}

  def initialize(csv_file, meal_repository, employee_repository, customer_repository)
    @meal_repository = meal_repository
    @employee_repository = employee_repository
    @customer_repository = customer_repository
    @csv_file = csv_file
    @orders = []
    load_csv
  end

  def add(order)
    order.id = @next_id
    @next_id += 1
    @orders << order
    save_csv
  end

  def find(id)
    @orders.select { |order| order.id == id }.first
  end

  def all
    @orders
  end

  def undelivered_orders
    @orders.select { |order| !order.delivered? }
  end

  def orders_by(employee)
    @orders.select { |order| order.employee.id == employee.id }
  end

  def save_csv
    CSV.open(@csv_file, 'wb', CSV_OPTIONS) do |csv|
      csv << %i[id delivered meal_id employee_id customer_id]
      @orders.each do |order|
        csv << [order.id, order.delivered?, order.meal.id, order.employee.id, order.customer.id]
      end
    end
  end


  private

  def load_csv
    if File.exist?(@csv_file)
      CSV.foreach(@csv_file, CSV_OPTIONS) do |row|

        meal_id = row[:meal_id].to_i
        meal = @meal_repository.find(meal_id)

        employee_id = row[:employee_id].to_i
        employee = @employee_repository.find(employee_id)

        customer_id = row[:customer_id].to_i
        customer = @customer_repository.find(customer_id)

        new_order = Order.new(id: row[:id].to_i, delivered: row[:delivered] == 'true', meal: meal, employee: employee, customer: customer )

        @orders << new_order
      end
    end
    @next_id = @orders.empty? ? 1 : @orders.last.id + 1
  end


end