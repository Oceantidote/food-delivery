class SessionsView
  def ask_for(thing)
    puts "Please enter your #{thing}"
    gets.chomp
  end
end
