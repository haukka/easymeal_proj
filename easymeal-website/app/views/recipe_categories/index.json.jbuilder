json.array!(@recipe_categories) do |recipe_category|
  json.extract! recipe_category, :id
  json.url recipe_category_url(recipe_category, format: :json)
end
