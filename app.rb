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

  conn.exec("UPDATE restaurants SET name =' #{name}', cuisine = '#{cuisine}', price = #{price}, health = '#{health}' WHERE id = #{id};")
  "Success"
end


delete '/restaurants/:id' do
  id = params[:id]
  conn.exec("DELETE FROM restaurants WHERE id = #{id};")
  "Success"
end

get '/drinks' do
  res = conn.exec("SELECT * FROM drinks;")
  drinks = []
  res.each do |drink|
    drinks.push(drink)
  end
  drinks.to_json
end

post '/drinks' do
  data = eval(request.body.read)

  name = data[:name]
  abv = data[:abv]
  shaken = data[:shaken]
  stirred = data[:stirred]
  type = data[:type]

  conn.exec("INSERT INTO drinks (name, abv, shaken, stirred, type) VALUES('#{name}', #{abv}, #{shaken}, #{stirred}, '#{type}');")
  "Success"
end

patch '/drinks/:id' do
  id = params[:id]

  data = eval(request.body.read)

  name = data[:name]
  abv = data[:abv]
  shaken = data[:shaken]
  stirred = data[:stirred]
  type = data[:type]

  conn.exec("UPDATE drinks SET name = '#{name}', abv = #{abv}, shaken = #{shaken}, stirred = #{stirred}, type = '#{type}' WHERE id = #{id};")
  "Success"
end

delete '/drinks/:id'do
  id = params[:id]
  conn.exec("DELETE FROM drinks WHERE id = #{id};")
  "Success"
end
