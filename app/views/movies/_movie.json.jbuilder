json.extract! movie, :id, :title, :rating, :image_url, :description, :created_at, :updated_at
json.url movie_url(movie, format: :json)
