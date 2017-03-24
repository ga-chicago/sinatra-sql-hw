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

  conn.exec("UPDATE restaurants SET name = '#{name}', cuisine = '#{cuisine}', price = #{price}, health = '#{health}' WHERE id = #{id};")
  "Success"
end

delete '/restaurants/:id' do
  id = params[:id]

  conn.exec("DELETE FROM restaurants WHERE id = #{id};")
  "Success"
end

get '/sandwich' do
  res = conn.exec("SELECT s.name, s.cheese, s.bread, s.condiment FROM sandwich s;")
  sandwiches = []
  res.each do |sandwich|
    sandwiches.push(sandwich)
  end
  sandwiches.to_json
end

get '/sandwich/:id' do
  id = params[:id]
  res = conn.exec("SELECT s.name, s.cheese, s.bread, s.condiment FROM sandwich s WHERE id = #{id};")
  res[0].to_json
end

post '/sandwich' do
  data = eval(request.body.read)

  name = data[:name]
  cheese = data[:cheese]
  bread = data[:bread]
  condiment = data[:condiment]

  conn.exec("INSERT INTO sandwich (name, cheese, bread, condiment)
             VALUES('#{name}','#{cheese}', '#{bread}', '#{condiment}');")
  "Order Up!"
end

patch '/sandwich/:id' do
  id = params[:id]
  data = eval(request.body.read)

  name = data[:name]
  cheese = data[:cheese]
  bread = data[:bread]
  condiment = data[:condiment]

  conn.exec("UPDATE sandwich SET name = '#{name}', cheese = '#{cheese}', bread = '#{bread}', condiment = '#{condiment}' WHERE id = #{id};")
  "Cheeseburger Cheeseburger Cheeseburger"
end

delete '/sandwich/:id' do
  id = params[:id]

  conn.exec("DELETE FROM sandwich WHERE id = #{id};")
  "We Be Gone!"
end
