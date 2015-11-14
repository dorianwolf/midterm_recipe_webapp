before '/inventory' do
  redirect '/users/signup' unless current_user
  @flash = session[:flash]
  session.delete(:flash)
end

get '/inventory' do
  @pantry = open_pantry if current_user != nil
  erb :'/inventory/index'
end

post '/inventory/add' do
  params[:pantry].each do |item_id|
    item = Inventory.find(item_id)
    addition = Pantry.new(
    inventory_id: item.id,
    user_id: session[:id]
    )
    addition.save
  end
  erb :'/inventory/index'
end

post '/inventory/delete' do
  pantry = Pantry.where(user_id: session[:id])
  pantry.each do |item|
    params[:pantry].each do |input|
      Pantry.find(item.id).destroy if item.inventory_id == input.to_i
    end
  end
  redirect '/inventory'
end
