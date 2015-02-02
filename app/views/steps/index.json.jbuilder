json.array!(@steps) do |step|
  json.extract! step, :id, :name, :desc, :category_id
  json.url step_url(step, format: :json)
end
