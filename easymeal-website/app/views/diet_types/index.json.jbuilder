json.array!(@diet_types) do |diet_type|
  json.extract! diet_type, :id, :user_id, :name
  json.url diet_type_url(diet_type, format: :json)
end

json.array!(@diseases) do |disease|
  json.extract! disease, :id, :name
  json.url disease_url(disease, format: :json)
end
