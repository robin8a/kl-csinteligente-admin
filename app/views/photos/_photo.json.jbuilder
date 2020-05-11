json.extract! photo, :id, :ph_name, :ph_src, :project_id, :created_at, :updated_at
json.url photo_url(photo, format: :json)
