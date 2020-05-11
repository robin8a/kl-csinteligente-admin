json.extract! cs_user, :id, :nickname, :created_at, :updated_at
json.url cs_user_url(cs_user, format: :json)
