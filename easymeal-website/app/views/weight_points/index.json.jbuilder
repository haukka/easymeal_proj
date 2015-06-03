json.array!(@weight_points) do |weight_point|
  json.extract! weight_point, :id, :user_id, :weight, :date
  json.url weight_point_url(weight_point, format: :json)
end
