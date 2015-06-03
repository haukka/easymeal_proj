json.array!(@allergen_and_favorite_aliments) do |allergen_and_favorite_aliment|
  json.extract! allergen_and_favorite_aliment, :id
  json.url allergen_and_favorite_aliment_url(allergen_and_favorite_aliment, format: :json)
end
