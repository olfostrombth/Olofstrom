json.array!(@examinations) do |examination|
  json.extract! examination, :id, :name, :desc, :category_id
  json.url examination_url(examination, format: :json)
end
