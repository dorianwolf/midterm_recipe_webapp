# Homepage (Root path)
get '/inventory' do
  @inventory = Inventory.new(
    name: params[:name]
  )
  if @inventory.save
    redirect "/"
  else
    @errors = "invalid inventory item"
  end
  erb :index
end
