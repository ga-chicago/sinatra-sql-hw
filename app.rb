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
  new_info = eval(request.body.read)
  the_id = params[:id]
  name = new_info[:name]
  cuisine = new_info[:cuisine]
  price = new_info[:price]
  health = new_info[:health]
  result = conn.exec("UPDATE restaurants SET name='#{name}', cuisine='#{cuisine}', price=#{price}, health='#{health}' WHERE ID=#{the_id}")
  p result
  "did the update, I think"
end

delete '/restaurants/:id' do
  the_id = params[:id]
  results = conn.exec("DELETE FROM restaurants WHERE ID=#{the_id}")
  p results
  "did the delete, i think"
end

##TRAINS -- HW PART 2
 
get '/trains' do
  res = conn.exec("SELECT * FROM trains;")
  trains = []
  res.each do |train|
    trains.push(train)
  end
  trains.to_json
end

get '/trains/:id' do
  id = params[:id]
  res = conn.exec("SELECT id, name FROM trains WHERE id = #{id};")
  res[0].to_json
end

post '/trains' do
  data = eval(request.body.read)

  color = data[:color]
  end1 = data[:end1]
  end2 = data[:end2]

  conn.exec("INSERT INTO trains (color, end1, end2) VALUES
  ('#{color}','#{end1}', '#{end2}');")
  "come on ride the success train you're a success"
end

patch '/trains/:id' do
  new_info = eval(request.body.read)
  the_id = params[:id]
  color = new_info[:color]
  end1 = new_info[:end1]
  end2 = new_info[:end2]
  result = conn.exec("UPDATE trains SET color='#{color}', end1='#{end1}', end2='#{end2}' WHERE ID=#{the_id}")
  p result
  "did the update, I think, mr. conductor"
end

delete '/trains/:id' do
  the_id = params[:id]
  results = conn.exec("DELETE FROM trains WHERE ID=#{the_id}")
  p results
  "did the delete, of CTA TRAIN"
end