get '/recipes' do
  put_in_pantry(params[:pantry]) if current_user
  @items = open_pantry
  @recipes = Recipe.all
  erb :'recipes/index'
end

get '/recipes/:id' do
  @recipe = Recipe.find(params[:id])
  erb :'/recipes/display'
end

get '/recipes/all' do
  @recipes = Recipe.all
  redirect '/recipes/all'
end

get '/recipes/:id' do
  @recipe = Recipe.find(params[:id])
  erb :'/recipes/display'
end

post '/recipes/create' do
  @recipe = Recipe.new(params[:user])
  if @recipe.save
    redirect '/inventory/index'
  else
    @errors = 'Could not save recipe. Please update and try again.'
  end
end

post '/recipes/get' do
  @recipes = Recipe.all
  @missing_ing = {}
  @recipes.each do |recipe|
  end
end
