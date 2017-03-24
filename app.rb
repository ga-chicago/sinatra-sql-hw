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
  res[].to_json
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

patch '/restaurants:id'do
  id = params[:id]
  data = eval("UPDATE restaurants SET name = '#{name}', cuisine = '#{cuisine}', price = #{price}, health = '#{health}' WHERE id = #{id};"))
end

delete '/restaurants/:id' do
  id = params[:id]
  conn.exec("DELETE FROM restaurants WHERE ID = #{id};")
  "success"

end

get '/dessert' do
  res = conn.exec("SELECT name, type, flavor FROM dessert;")
   dessert = []
   res.each do |dessert|
     dessert.push(dessert)
   end
   dessert.to_json
end

get '/dessert/:id' do
  id = params[:id]
   res = conn.exec("SELECT name, type, flavor FROM dessert FROM dessert WHERE id = #{id};")
   res[0].to_json
 +end

post '/dessert' do
   data = eval(request.body.read)
 
   name = data[:name]
   type = data[:type]
   flavor = data[:flavor]
  
 
   conn.exec("INSERT INTO dessert (name, type, flavor)
              VALUES('#{name}','#{type}', '#{flavor}');")
   "yummmy!"
 end






