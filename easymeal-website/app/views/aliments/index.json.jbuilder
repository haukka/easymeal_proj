json.array!(@aliments) do |aliment|
  json.extract! aliment, :id
  json.url aliment_url(aliment, format: :json)
end
