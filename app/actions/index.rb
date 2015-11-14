before do
  @flash = session[:flash]
  session.delete(:flash)
end

get '/' do
  @user = User.create(
  username: 'tourist',
  password: 'password'
  )
  redirect '/inventory'
end
