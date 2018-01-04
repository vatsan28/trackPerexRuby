class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  def hello
    render html: "This is just for me!"
    puts "In controller"
  end


end