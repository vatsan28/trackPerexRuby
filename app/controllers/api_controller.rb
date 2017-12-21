class ApiController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :authenticate_number

  def parse
    puts "TODO: parse message and figure out purpose of message."
    check_message_type('regTrackex')
    if @message_type =='reg'
      if (@message_contents[3].include? '@')
        if (check_valid_email)
          new_user = User.create(firstName: @message_contents[1], lastName: @message_contents[2], phoneNumber: @userNumber, email: @message_contents[3])
          puts new_user
          respond_registration_success
        else
          respond_email_taken
        end
      else
        respond_with_corrected_format
      end
    else
      if @user
        respond_work_in_progress
      else
        respond_register_request
      end
    end
  end
end