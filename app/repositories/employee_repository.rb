class EmployeeRepository
  CSV_OPTIONS = {headers: :first_row, header_converters: :symbol}

  def initialize(csv_file)
    @csv_file = csv_file
    @employees = []
    load_csv
  end


  def find(id)
    @employees.select { |employee| employee.id == id }.first
  end

  def find_by_username(username)
    @employees.select { |employee| employee.username == username  }.first
  end

  def all
    @employees
  end

  def all_delivery_guys
    @employees.select { |employee| employee.delivery_guy? }
  end

  private

  def load_csv
    if File.exist?(@csv_file)
      CSV.foreach(@csv_file, CSV_OPTIONS) do |row|
        new_employee = Employee.new(id: row[:id].to_i, username: row[:username], password: row[:password], role: row[:role])
        @employees << new_employee
      end
    end
    @next_id = @employees.empty? ? 1 : @employees.last.id + 1
  end

end