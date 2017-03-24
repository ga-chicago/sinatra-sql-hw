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
	data = eval(request.body.read)
	id = params[:id]

    name = data[:name]
    cuisine = data[:cuisine]
    price = data[:price]
    health = data[:health]

	res = conn.exec("UPDATE restaurants SET (name, cuisine, price, health) = ('#{name}','#{cuisine}', #{price}, '#{health}') WHERE id = #{id};")
	"success"
end


delete '/restaurants/:id' do
	id = params[:id]
	res = conn.exec("DELETE FROM restaurants WHERE id = #{id};")
	"Success"
end


get '/dishes' do
	res = conn.exec('SELECT * FROM dishes;')

	dishes = []
	res.each do |dish|
		dishes.push(dish)
	end
	dishes.to_json
end

get '/dishes/:id' do
  id = params[:id]
  res = conn.exec("SELECT id, type FROM dishes WHERE id = #{id};")
  res[0].to_json
end

post '/dishes' do
	data = eval(request.body.read)

	type = data[:type]
	color = data[:color]
	price = data[:price]
	breakability = data[:breakability]

	conn.exec("INSERT INTO dishes (type, color, breakability, price) VALUES
	('#{type}','#{color}', #{breakability}, '#{price}');")
	"Success"
end

patch '/dishes/:id' do
	data = eval(request.body.read)
	id = params[:id]

	type = data[:type]
	color = data[:color]
	price = data[:price]
	breakability = data[:breakability]

	res = conn.exec("UPDATE dishes SET (type, color, breakability, price) = ('#{type}','#{color}', #{breakability}, '#{price}') WHERE id = #{id};")
	"success"
end

delete '/dishes/:id' do
	id = params[:id]
	res = conn.exec("DELETE FROM dishes WHERE id = #{id};")
	"Success"
end
