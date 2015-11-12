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
  #
  # def pantry_name_to_id(pantry)
  #   contents_ids = []
  #   pantry.each do |item|
  #     contents_ids << Inventory.find_by(name: item).id
  #   end
  #   contents_ids
  # end
  #
  # def ingredient_id_to_name(ingredient_ids)
  #   ingredient_names = []
  #   ingredient_ids.each do |id|
  #     ingredient_names << Inventory.find(id).name
  #   end
  # end


# =>      ADD INGREDIENTS TO RECIPE

  def add_ingredient(ingredient_name, recipe_name)
    addition = Ingredient.new(
    inventory_id: Inventory.find_by(name: ingredient_name).id,
    recipe_id: Recipe.find_by(name: recipe_name).id
    )
    addition.save
  end


# =>      CHECK TO SEE IF USER HAS THE INGREDIENTS


  def is_in_pantry(ingredient_id)
    user = User.find(session[:id])
    pantry = Pantry.all.where(user_id: user.id)
    return false unless pantry.find(ingredient_id)
  end

  def has_all_ingredients(recipe)
    user = User.find(session[:id])
    ingredients = Ingredient.all.where(recipe_id: recipe.id)
    missing = []
    ingredients.each do |ingredient|
      missing << ingredient unless is_in_pantry(ingredient)
    end
    missing.length == 0
  end

end

before do
  @flash = session[:flash]
  session.delete(:flash)
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

get '/recipes' do
  @pantry = open_pantry
  erb :'recipes/index'
end

get '/recipe/:id' do
  @review = Review.where(blah)
  erb :'/recipe/display'
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
  @missing_ing = []
  @recipes.each do |recipe|

  end
end

get '/users/signup' do
  erb :'/users/signup'
end

post '/users/signup' do
  @user = User.new(params[:user])
  if @user.save
    session[:id] = @user.id
    session[:flash] = "Thanks for joining, #{@user.username}"
    redirect '/inventory'
  else
    @error = 'Invalid username or password' #TOFIX
    erb :'index'
  end
end

post '/users/login' do
  if @user = User.find_by_username(params[:user][:username]).try(:authenticate, params[:user][:password])
    session[:id] = @user.id
    session[:flash] = "Hungry again? #{@user.username}"
    redirect '/inventory'
  else
    @error = 'Invalid username or password' # TOFIX
    erb :'index'
  end
end

post '/users/logout' do
  session.clear
  redirect '/inventory'
end
