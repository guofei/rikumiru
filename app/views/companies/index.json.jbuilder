json.array!(@companies) do |company|
  json.extract! company, :id, :name, :alice_name, :tweet_id
  json.url company_url(company, format: :json)
end
