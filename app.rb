require 'sinatra'
require 'json'
require 'pg'

conn = PGconn.open(:dbname => 'practice')

get '/restaurants' do
  res = conn.exec("SELECT * FROM restaurants;")
  restaurants = []
  res.each do |restaurant|
    restaurants.push(restaurant)
  end
  restaurants.to_json
end

get '/restaurants/:id' do
  id = params[:id]
  res = conn.exec("SELECT id, name FROM restaurants WHERE id = #{id};")
  res[0].to_json
end

post '/restaurants' do
  data = eval(request.body.read)

  name = data[:name]
  cuisine = data[:cuisine]
  price = data[:price]
  health = data[:health]

  conn.exec("INSERT INTO restaurants (name, cuisine, price, health) VALUES
  ('#{name}','#{cuisine}', #{price}, '#{health}');")
  "Success"
end

patch '/restaurants/:id' do
  id = params[:id]
  data = eval(request.body.read)
  
  name = data[:name]
  cuisine = data[:cuisine]
  price = data[:price]
  health = data[:health]

  conn.exec("UPDATE restaurants SET name='#{name}', cuisine='#{cuisine}', price=#{price}, health='#{health}' WHERE id=#{id}")
  "success"
end

delete '/restaurants/:id' do
  id = params[:id]
  conn.exec("DELETE FROM restaurants WHERE id = #{id};")
end


get '/movies'  do 
  res = conn.exec("SELECT * FROM movies;")
  movies = []
  res.each do |movie|
    movies.push(movie)
  end
  movies.to_json
end

get '/movies/:id' do
  id = params[:id]
  res = conn.exec("SELECT id,title,year,starring FROM movies WHERE id = #{id};")
  res[0].to_json
end

post '/movies' do
  data = eval(request.body.read)

  title = data[:title]
  director = data[:director]
  year = data[:year]
  starring = data[:starring]

  conn.exec("INSERT INTO movies (title, director, year, starring) VALUES
  ('#{title}','#{director}', #{year}, '#{starring}');")
  "Success"
end

patch '/movies/:id' do
  id = params[:id]
  data = eval(request.body.read)
  
  title = data[:title]
  director = data[:director]
  year = data[:year]
  starring = data[:starring]

  conn.exec("UPDATE movies SET title='#{title}', director='#{director}', year=#{year}, starring='#{starring}' WHERE id=#{id}")
  "success"
end

delete '/movies/:id' do
  id = params[:id]
  conn.exec("DELETE FROM movies WHERE id = #{id};")
end



