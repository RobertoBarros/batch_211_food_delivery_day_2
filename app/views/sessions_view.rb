class SessionsView

  def ask_username
    puts "Username?"
    gets.chomp
  end

  def ask_password
    puts "Password?"
    gets.chomp
  end

  def correct_credentials(employee)
    puts "Welcome #{employee.username}"
  end

  def wrong_credentials
    puts "Wrong credentials"
  end

end