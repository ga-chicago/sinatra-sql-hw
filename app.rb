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

# ---------------------------------------------------

patch '/restaurants/:id' do
  id = params[:id]
  data = eval(request.body.read)
  name = data[:name]
  cuisine = data[:cuisine]
  price = data[:price]
  health = data[:health]

conn.exec("UPDATE restaurants SET name = #{name}, cuisine = #{cuisine}, price = #{price}, health = #{health}, WHERE id = #{id};")
"success"
end

delete '/restaurants/:id' do
  id = params[:id]
  conn.exec("DELETE FROM restaurants WHERE id = #{id};")

# -------------------------------------------------------

# HW BELOW THIS LINE!!

# hw: add update and delete
# create a whole other table
# create update delete -----

get '/drinks' do
  res = conn.exec("SELECT * FROM drinks")
  drinks = []
  res.each do |drink|
    drinks.push(drink)
  end

  drinks.to_json

end


get '/drinks/:id' do
  id = params[:id]
  puts id
  res = conn.exec("SELECT id, name FROM drinks WHERE id=#{id};")
  res [0].to_json
end

post '/drinks' do
  data = eval(request.body.read)
  name = data[:name]
  price = data[:price]
  flavor = data[:flavor]

conn.exec("INSERT INTO drinks (name, flavor, price) VALUES('#{name}', '#{flavor}', '#{price}');")
  "success"
end

def destroy 
  @post = Post.find(params[:id])
   @post.destroy

delete '/drinks/:id' do
  id = params[:id]
  destroy = :id
  res = conn.exec("SELECT id, name FROM drinks WHERE id=#{id};")
  res [0].to_json
  end
end
\
