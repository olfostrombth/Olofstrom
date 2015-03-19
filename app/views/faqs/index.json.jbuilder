json.array!(@faqs) do |faq|
  json.extract! faq, :id, :frequent_questions, :frequent_answers
  json.url faq_url(faq, format: :json)
end
