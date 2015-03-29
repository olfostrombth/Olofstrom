json.array!(@slideritems) do |slideritem|
  json.extract! slideritem, :id, :text
  json.url slideritem_url(slideritem, format: :json)
end
