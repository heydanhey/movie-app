json.extract! order, :id, :email, :quantity, :showtime_id, :created_at, :updated_at, :movie, :showtime
json.url order_url(order, format: :json)
