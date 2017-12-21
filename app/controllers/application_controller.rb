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
    response = if (user) then 'user already registered.' else 'user needs to register.' end

    puts response

    render json:{
      status: 200,
      message: response
    }.to_json

  end
end


