# Homepage (Root path)
helpers do

end

get '/' do
  erb :index
end

get '/inventory' do
  @inventory = Inventory.all
  erb :'/inventory/index'
end

get '/recipes' do
  @recipes = Recipes.all
  erb :'recipes/index'
end

post '/inventory' do
  @inventory = Inventory.new(
    name: params[:name]
  )
  if @inventory.save
    redirect "/"
  else
    @errors = "invalid inventory item"
  end
  erb :index
end

post '/recipes' do
  @recipe = Recipes.new(
  name: params[:name]
  link: params[:link]
  )
  if @recipe.save
    redirect '/'
  else
    @errors = 'Could not save recipe. Please update and try again.'
  end
end
