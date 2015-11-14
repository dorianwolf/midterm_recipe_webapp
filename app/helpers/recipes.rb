# Homepage (Root path)
helpers do

  def current_user
    @user ||= User.find_by(id: session[:id])
  end

  def open_pantry
    return unless current_user
    pantry = Pantry.all.where(user_id: session[:id])
    items = []
    Pantry.where(user_id: session[:id]).map { |item| Inventory.find(item.inventory_id)}
    pantry.each do |item|
      items << Inventory.find(item.inventory_id).name
    end
    items
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
    user = current_user
    pantry = Pantry.all.where(user_id: user.id)
    if pantry.find_by(inventory_id: ingredient_id)
      return true
    else
      return false
    end
  end

  def missing_ingredients(recipe)
    user = User.find(session[:id])
    ingredients = Ingredient.all.where(recipe_id: recipe.id)
    missing = []
    ingredients.each do |ingredient|
      missing << Inventory.find(ingredient.inventory_id).name unless is_in_pantry(ingredient.inventory_id)
    end
    missing
  end

end
