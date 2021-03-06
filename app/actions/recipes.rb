get '/recipes' do
  if current_user
    put_in_pantry(params[:pantry]) if params[:pantry]
    @items = open_pantry
  else
    @items = params[:pantry]
  end
  @recipes = Recipe.all
  erb :'recipes/index'
end

get '/recipes/all' do
  @recipes = Recipe.all
  erb :'/recipes/all'
end

post '/recipes/display' do
  if current_user
    put_in_pantry(params[:pantry]) if params[:pantry]
    @items = open_pantry
  else
    @items = params[:pantry]
  end
    @recipes  = []
    Recipe.all.each do |recipe|
      missing = missing_ingredients(recipe, @items)
      @recipes << recipe if missing.length <= 1
    end
  erb :'recipes/index'
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
