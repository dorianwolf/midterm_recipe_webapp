before do
  @flash = session[:flash]
  session.delete(:flash)
end

get '/' do
  redirect '/inventory'
end
