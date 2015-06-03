json.array!(@stocks) do |stock|
  json.extract! stock, :id, :home_id
  json.url stock_url(stock, format: :json)
end
