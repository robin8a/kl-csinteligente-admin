json.extract! observation, :id, :ob_name, :ob_type, :ob_desc, :ob_text, :created_at, :updated_at
json.url observation_url(observation, format: :json)
