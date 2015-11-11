# Homepage (Root path)
helpers do

  def logged_in
    true if session[:id]
  end

  def open_pantry
    if logged_in
      @items_id = Pantry.all.where(user_id: session[:id])
      @items = []
      @items_id.each do |item_id|
        @items << Inventory.find(item_id).name
      end
    end
  end
end

get '/' do
  erb :index
end

get '/inventory' do
  @inventory = Inventory.all
  erb :'/inventory/index'
end

get '/recipes' do
  @recipes = Recipe.all
  erb :'recipes/index'
end

get 'users/signup' do
  erb :'users/signup'
end

get 'users/login' do
  erb :'users/login'
end

get 'inventory' do
  @items_list = open_pantry
  erb :'inventory'
end

post 'users/signup' do
  @user = User.new(
  username: params[:username],
  password: params[:password]
  )
  if @user.save
    session[:id] = @user.id
  else
    @error = 'Invalid username or password'
  end
end

post 'users/login' do
  if @user = User.find_by_username(params[:username]).try(:authenticate, params[:password])
    session[:id] = @user.id
    redirect '/'
  else
    @error = 'Invalid username or password'
    erb :'users/login'
  end
end

post '/inventory/add' do
  item = Inventory.find_by(name: params(:name))
  addition = Pantry.new(
  inventory_id: item.id,
  user_id: session[:id]
  )
  addition.save
  erb :'/'
end

post '/inventory/create' do
  @inventory = Inventory.new(
    name: params[:name],
    link: params[:link]
  )
  if @inventory.save
    redirect "/"
  else
    @errors = "invalid inventory item"
  end
  erb :index
end

post '/recipes/create' do
  @recipe = Recipe.new(
  name: params[:name],
  link: params[:link]
  )
  if @recipe.save
    redirect '/'
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
