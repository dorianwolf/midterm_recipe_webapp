get '/' do
  @user = User.create(
  username: 'tourist',
  password: 'password'
  )
  session[:id] = @user.id
  redirect '/inventory'
end
