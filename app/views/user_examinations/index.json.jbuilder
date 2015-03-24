json.array!(@user_examinations) do |user_examination|
  json.extract! user_examination, :id, :examination_id, :user_id, :msg, :corrected
  json.url user_examination_url(user_examination, format: :json)
end
