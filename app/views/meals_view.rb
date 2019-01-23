class MealsView

  def display(meals)
    meals.each do |meal|
      puts "id: #{meal.id} | #{meal.name} - $ #{meal.price}"
    end
  end

  def ask_name
    puts "Enter meal name:"
    gets.chomp
  end

  def ask_price
    puts "Enter meal price:"
    gets.chomp.to_i
  end

end