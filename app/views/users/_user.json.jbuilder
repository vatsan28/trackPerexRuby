json.extract! user, :id, :user_id, :firstName, :lastName, :phoneNumber, :email, :created_at, :updated_at
json.url user_url(user, format: :json)
