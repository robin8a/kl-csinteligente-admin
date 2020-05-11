json.extract! weather, :id, :we_name, :created_at, :updated_at
json.url weather_url(weather, format: :json)
