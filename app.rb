require 'sinatra'
require 'json'
require 'pg'
require 'rerun'

conn = PGconn.open(:dbname => 'practice')
get '/restaurants' do
	res = conn.exec('SELECT * FROM restaurants;')
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

	name = data[:Name]
	cuisine = data[:Cuisine]
	price = data[:Price]
	health = data[:Health]

	conn.exec("INSERT INTO restaurants (Name, Cuisine, Price, Health) VALUES('#{name}', '#{cuisine}', #{price}, '#{health}');")

	"success"

end

patch '/restaurants/:id' do
	id = params[:id]
	data = eval(request.body.read)

	name = data[:Name]
	cuisine = data[:Cuisine]
	price = data[:Price]
	health = data[:Health]

	conn.exec("UPDATE restaurants SET name = '#{name}', cuisine = '#{cuisine}', price = #{price}, health = '#{health}' WHERE id = #{id};")
	"success"
end

delete '/restaurants/:id' do
	id = params[:id]
	conn.exec("DELETE from restaurants where id = #{id};")
	"Success"
end


get '/drinks' do
	res = conn.exec('SELECT * FROM drinks;')
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

	conn.exec("INSERT INTO drinks (name, abv, shaken, stirred, type) VALUES( '#{name}', #{abv}, #{shaken}, #{stirred}, '#{type}');")
	"success"
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
	"success"
end

delete '/drinks/:id' do
	id = params[:id]
	conn.exec("DELETE from drinks where id = #{id};")
	"success"
end












