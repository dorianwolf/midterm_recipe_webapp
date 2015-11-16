<% Recipe.each do |recipe| %>
  <h1><%= recipe.name %></h1>
  <h2>Ingredients</h2>
  <ul class="list-unstyled">
  <% recipe.ingredients.each do |ingredient| %>
    <li><h3><%= Inventory.find(ingredient.inventory_id).name %><h3></li>
  </ul>
  <% end %>
  <h2><a href="<%= recipe.link %>">How to</a></h2>
<% end %>
