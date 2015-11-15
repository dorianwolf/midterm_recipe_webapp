get '/recipes' do
  #puts params.inspect
  #put_in_pantry(params[:pantry])
  @items = params[:pantry]
  @recipes = Recipe.all
  erb :'recipes/index'
end

get '/recipe/:id' do
  @recipe = Recipe.find(params[:id])
  erb :'/recipes/display'
end

get '/recipe/all' do
  @recipes = Recipe.all
  redirect '/recipes/all'
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
