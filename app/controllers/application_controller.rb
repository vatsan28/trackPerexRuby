class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  def hello
    render html: "hello world"
    puts "In controller"
  end

  def parse
    puts "TODO: parse message and figure out the customer status."
    puts params
    userNumber = params[:From]
    message = params[:Body]
    user = User.find_by phoneNumber: userNumber
    puts message
    userStatus = user ? 'user already registered.' : 'user needs to register.'

    render plain: userStatus


  end
end