json.array!(@hot_keywords) do |hot_keyword|
  json.extract! hot_keyword, :id, :company_id, :name
  json.url hot_keyword_url(hot_keyword, format: :json)
end
