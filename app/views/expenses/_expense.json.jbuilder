json.extract! expense, :id, :reason, :amount, :expense_id, :created_at, :updated_at
json.url expense_url(expense, format: :json)
