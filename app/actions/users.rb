get '/profile' do
  # show the profile
  erb :'users/profile'
end

get '/users' do
  # show all users
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
    erb :'inventory/index'
  end
end

post '/users/login' do
  if @user = User.find_by_username(params[:user][:username]).try(:authenticate, params[:user][:password])
    session[:id] = @user.id
    session[:flash] = "Hungry again? #{@user.username}"
    redirect '/inventory'
  else
    @error = 'Invalid username or password' # TOFIX
    erb :'inventory/index'
  end
end

post '/users/logout' do
  session.clear
  redirect '/inventory'
end
