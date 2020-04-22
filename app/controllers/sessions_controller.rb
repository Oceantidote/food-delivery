require_relative "../views/sessions_view"

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @sessions_view = SessionsView.new
  end

  def login
    @name = @sessions_view.ask_for(:name)
    @password = @sessions_view.ask_for(:password)
    @user = @employee_repository.find_by_name(@name)
    if @user&.password == @password
      return @user
    else
      puts "Incorrect credentials, please try again"
      nil
    end
  end
end
