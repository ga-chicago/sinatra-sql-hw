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

  res = conn.exec("UPDATE restaurants SET name = '#{name}', cuisine = '#{cuisine}', price = #{price}, health = '#{health}' WHERE id = #{id};")
  "Success"
end

delete '/restaurants/:id' do
  id = params[:id]
  data = eval(request.body.read)

  res = conn.exec("DELETE FROM restaurants WHERE id = #{id};")
  "Success"
end

get '/food' do
  res = conn.exec("SELECT * FROM food;")
  food = []
  res.each do |item|
    food.push(item)
  end
  food.to_json
end

get '/food/:id' do
  id = params[:id]
  res = conn.exec("SELECT id, name FROM food WHERE id = #{id};")
  res[0].to_json
end

post '/food' do
  data = eval(request.body.read)

  name = data[:name]
  cuisine = data[:cuisine]

  conn.exec("INSERT INTO food (name, cuisine) VALUES
  ('#{name}','#{cuisine}');")
  "Success"
end

patch '/food/:id' do
  id = params[:id]
  data = eval(request.body.read)

  name = data[:name]
  cuisine = data[:cuisine]

  res = conn.exec("UPDATE food SET name = '#{name}', cuisine = '#{cuisine}' WHERE id = #{id};")
  "Success"
end

delete '/food/:id' do
  id = params[:id]
  data = eval(request.body.read)

  res = conn.exec("DELETE FROM food WHERE id = #{id};")
  "Success"
end
