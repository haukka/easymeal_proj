json.array!(@menu_schedules) do |menu_schedule|
  json.extract! menu_schedule, :id, :weekNumber, :year, :home_id
  json.url menu_schedule_url(menu_schedule, format: :json)
end
