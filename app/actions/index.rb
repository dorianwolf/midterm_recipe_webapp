get '/' do
  @user = User.create(
  username: 'tourist',
  password: 'password'
  )
  redirect '/inventory'
end
