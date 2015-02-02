json.array!(@comments) do |comment|
  json.extract! comment, :id, :msg, :category_id
  json.url comment_url(comment, format: :json)
end
