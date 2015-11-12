# Homepage (Root path)
helpers do

  def logged_in
    true if session[:id]
  end

  def open_pantry
    if logged_in
      items_id = Pantry.all.where(user_id: session[:id])
      items = []
      items_id.each do |item_id|
        items << Inventory.find(item_id).name
      end
      items
    end
  end

  def pantry_name_to_id(pantry)
    contents_ids = []
    pantry.each do |item|
      contents_ids << Inventory.find_by(name: item).id
    end
    contents_ids
  end

  def ingredient_id_to_name(ingredient_ids)
    ingredient_names = []
    ingredient_ids.each do |id|
      ingredient_names << Inventory.find(id).name
    end
  end

  def get_ingredients_id(recipe)
    ingredients_ids = Ingredient.all.where(recipe_id: recipe.id)
  end
end

get '/' do
  erb :index
end

get '/inventory' do
  @items_list = open_pantry
  erb :'/inventory/index'
end

post '/inventory/add' do
  item = Inventory.find_by(name: params(:name))
  addition = Pantry.new(
  inventory_id: item.id,
  user_id: session[:id]
  )
  addition.save
  erb :'/inventory/index'
end

post '/inventory/create' do
  @inventory = Inventory.new(
    name: params[:name],
    link: params[:link]
  )
  if @inventory.save
    redirect "/inventory/index"
  else
    @errors = "invalid inventory item"
  end
  erb :'index'
end

get '/recipes' do
  @recipes = Recipe.all
  erb :'recipes/index'
end

get '/recipe/:id' do
  @review = Review.where(blah)
  erb :'/recipe/display'
end

post '/recipes/create' do
  @recipe = Recipe.new(
  name: params[:name],
  link: params[:link]
  )
  if @recipe.save
    redirect '/inventory/index'
  else
    @errors = 'Could not save recipe. Please update and try again.'
  end
end

post '/recipes/get' do
  @recipes = Recipe.all
  @missing_ing = []
  @recipes.each do |recipe|

  end
end

get '/users/signup' do
  erb :'/users/signup'
end

post '/users/signup' do
  @user = User.new(
  username: params[:username],
  password: params[:password]
  )
  if @user.save
    session[:id] = @user.id
  else
    @error = 'Invalid username or password'
  end
  redirect '/'
end

post '/users/login' do
  if @user = User.find_by_username(params[:username]).try(:authenticate, params[:password])
    session[:id] = @user.id
    redirect '/inventory'
  else
    @error = 'Invalid username or password'
    erb :'/'
  end
end
