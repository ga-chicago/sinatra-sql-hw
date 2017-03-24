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

  price = data[:price]

  conn.exec("UPDATE restaurants SET #{price} WHERE id = #{id};")
  "Success"
end

delete '/restaurants/:id' do
  id = params[:id]

  conn.exec("DELETE FROM restaurants WHERE id = #{id};")
  "Success"
end


# Create a route that returns all of your food items
# Create a route that returns a single food item using its ID
# Create a route that creates a new food items
# Create a route that updates an existing food item using its ID
# Create a route that deletes a food item using its ID

get '/mountains' do

  res = conn.exec("SELECT * FROM mountains")
  mountains = []
  res.each do |mountain|
    mountains.push(mountain)
  end
  mountains.to_json
end

get '/mountains/:id' do

  id = params[:id]
  res = conn.exec("SELECT id, name FROM mountains WHERE id = #{id};")
  res[0].to_json
end

post '/mountains' do

  data = eval(request.body.read)

  name = data[:name]
  state = data[:state]
  highest_peak = data[:highest_peak]
  trails = data[:trails]

  conn.exec("INSERT INFO mountains (name, state, highest_peak, trails) VALUES ('#{name}', '#{state}', #{highest_peak}, #{trails});")

  "Success"
end

patch '/mountains/:id' do
  id = params[:id]

  trails = data[:trails]

  conn.exec("UPDATE mountains SET #{trails} WHERE id = #{id};")
  "Success"
end

delete '/mountains/:id' do
  id = params[:id]

  conn.exec("DELETE FROM mountains WHERE id = #{id}};")
  "Success"
end










