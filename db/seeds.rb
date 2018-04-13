CRISPIN_GLOVER = 1064
IMAGE_DB_URL = 'https://image.tmdb.org/t/p/w200'
MOVIE_DB_URL = 'https://api.themoviedb.org'

def movies_from_api
  params = {
    params: {
      api_key: ENV['MOVIEDB_KEY'],
      with_cast: CRISPIN_GLOVER
    }
  }
  response = RestClient.get "#{MOVIE_DB_URL}/3/discover/movie", params
  JSON.parse(response)['results']
end

movies = movies_from_api
movies.each do |movie|
  Movie.create(
    title: movie['title'],
    rating: movie['vote_average'],
    image_url: "#{IMAGE_DB_URL}#{movie['poster_path']}",
    description: movie['overview']
  )
end

theaters = [
  { name: 'Lookingglass', capacity: 100 },
  { name: 'Goodman', capacity: 50 },
  { name: 'Steppenwolf', capacity: 150 },
  { name: 'Chicago', capacity: 5 }
]

prices = [3,5,7,11]

offset = 0
theaters.each do |theater|
  t = Theater.create(
    name: theater[:name],
    capacity: theater[:capacity]
  )
  time = Time.new.advance(day: 1).middle_of_day
  10.times do
    Showtime.create(
      theater_id: t.id,
      movie_id: Movie.all.sample.id,
      time: time.advance(minutes: offset),
      price: prices.sample
    )
    time = time.advance(hours: 3)
  end
  offset += 5
end

showtimes = Showtime.all 

showtimes.each do |showtime|
  if showtime.is_not_sold_out?
    Order.create(
      name: Faker::Name.first_name + '' + Faker::Name.last_name,
      email: Faker::Internet.email,
      showtime_id: showtime.id,
      quantity: rand(1..showtime.number_of_seats_available)
    )
  end
end  


