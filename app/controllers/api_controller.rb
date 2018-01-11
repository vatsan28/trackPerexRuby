class ApiController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :authenticate_number

  def parse
    puts "TODO: parse message and figure out purpose of message."
    check_message_type('regTrackex')
    puts ('-----' + @message_type)
    if @message_type =='reg'
      if (@message_contents[3].include? '@')
        if (check_valid_email)
          User.create(firstName: @message_contents[1], lastName: @message_contents[2], phoneNumber: @userNumber, email: @message_contents[3])
          respond_registration_success
        else
          respond_email_taken
        end
      else
        respond_with_corrected_format
      end
    else
      if @user
        # Add steps for adding expenses.
        expense = parse_expenses
        Expense.create(reason: expense[:reason], amount: expense[:amount], user: @user);
        total_expense = Expense.where(user: @user).sum(:amount)
        respond_success_expense_recording(total_expense)
      else
        respond_register_request
      end
    end
  end

  private
  def authenticate_number
    puts params
    @userNumber = params[:From]
    @message = params[:Body]
    @user = User.find_by phoneNumber: @userNumber
    # render plain: userStatus
  end

  # def parse_message
  #   check
  # end
  #

  def parse_expenses
    expense_string = @message.split(' ')
    expense = {}
    puts (expense_string.length)
    if (expense_string[0][0].to_f.is_a? Numeric)
      expense[:reason] = @message[@message.index(' ')+1..-1]
      expense[:amount] = @message.split(' ')[0].to_f
    elsif (expense_string[0][-1].to_f.is_a? Numeric)
      expense[:reason] = @message[0..-2]
      expense[:amount] = @message.split(' ')[-1].to_f
    else
      respond_with_correct_expense_format
    end
    return expense
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

  def respond_with_correct_expense_format
    render plain: 'For recording an expense respond in this format <expense reason> <expense amount> or <expense amount> <expense reason>. Be mindful of the white space.'
  end

  def respond_email_taken
    render plain: 'Please check your email Id. Email Id is already taken.'
  end

  def check_valid_email
    return false if (User.find_by email: @message_contents[3])
    return true
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

  def respond_success_expense_recording(today_expense)
    render plain: "Expense recorded. Today's total expenses is #{today_expense} $."
  end
end