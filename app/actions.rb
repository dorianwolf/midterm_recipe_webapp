# Homepage (Root path)
helpers do

  def logged_in
    true if session[:id] != nil
  end

  def open_pantry
    if logged_in
      pantry = Pantry.all.where(user_id: session[:id])
      items = []
      pantry.each do |item|
        items << Inventory.find(item.inventory_id).name
      end
      items
    end
  end

  def put_in_pantry(item_array)
    item_array.each do |item|
      unless is_in_pantry(item)
        Pantry.create(
        user_id: session[:id],
        inventory_id: item
        )
      end
    end
  end


  def is_in_pantry(ingredient_id)
    user = User.find(session[:id])
    pantry = Pantry.all.where(user_id: user.id)
    if pantry.find_by(inventory_id: ingredient_id)
      return true
    else
      return false
    end
  end

  def has_all_ingredients(recipe)
    user = User.find(session[:id])
    ingredients = Ingredient.all.where(recipe_id: recipe.id)
    missing = []
    ingredients.each do |ingredient|
      missing << ingredient unless is_in_pantry(ingredient.inventory_id)
    end
    missing.length == 0
  end

end

before do
  @flash = session[:flash]
  session.delete(:flash)
end

get '/' do
  redirect '/inventory'
end

get '/inventory' do
  @pantry = open_pantry if logged_in
  erb :'/inventory/index'
end

post '/inventory/add' do
  item = Inventory.find_by(name: params[:name])
  addition = Pantry.new(
  inventory_id: item.id,
  user_id: session[:id]
  )
  addition.save
  erb :'/inventory/index'
end

post '/inventory/delete' do
  pantry = Pantry.where(user_id: session[:id])
  pantry.each do |item|
    params[:items].each do |input, other_input|
      Pantry.find(item.id).destroy if item.inventory_id == input.to_i
    end
  end
  redirect '/inventory'
end

get '/recipes' do
  #puts params.inspect
  @items = params[:items].keys
  put_in_pantry(@items)
  @items = open_pantry
  @recipes = Recipe.all
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
