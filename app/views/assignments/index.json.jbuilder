json.array!(@assignments) do |assignment|
  json.extract! assignment, :id, :name, :desc, :step_id
  json.url assignment_url(assignment, format: :json)
end
