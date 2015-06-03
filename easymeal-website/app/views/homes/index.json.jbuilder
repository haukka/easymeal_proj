json.array!(@homes) do |home|
  json.extract! home, :id, :street, :city, :householder
  json.url home_url(home, format: :json)
end
