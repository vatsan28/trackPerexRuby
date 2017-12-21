class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  def hello
    render html: "This is just for me!"
    puts "In controller"
  end

  def authenticate_number
    puts params
    @userNumber = params[:From]
    @message = params[:Body]
    @user = User.find_by phoneNumber: @userNumber
      # render plain: userStatus
  end

  def parse_message
    check
  end

  def check_message_type(check_type)
    @message_contents = @message.split(' ')
    if (@message_contents[0].downcase == check_type.downcase)
      @message_type = 'reg'
    else
      @message_type = 'expense'
    end
  end

  def respond_with_corrected_format
    render plain: 'For registration respond in this format: regTrackex <first name> <last name> <email Id>'
  end

  def respond_email_taken
    render plain: 'Please check your email Id. Email Id is already taken.'
  end

  def check_valid_email
    if (User.find_by email: @message_contents[3])
      return false
    else
      return true
    end
  end

  def respond_registration_success
    render plain: 'Thanks for registering '+@message_contents[1]+'. Record your expenses by sending texts from this phone number in the following format: <amount> <category of the expense>.'
  end

  def respond_work_in_progress
    render plain: 'We are working on recording expenses. Bare with us.'
  end

  def respond_register_request
    render plain: 'Please register first. Reply with the following format for registering: regTrackex <first name> <last name> <email Id>'
  end
end