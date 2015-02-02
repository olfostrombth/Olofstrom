json.array!(@questions) do |question|
  json.extract! question, :id, :name, :question, :option1, :option2, :option3, :answer, :quiz_id
  json.url question_url(question, format: :json)
end
