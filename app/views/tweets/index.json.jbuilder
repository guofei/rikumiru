json.array!(@tweets) do |tweet|
  json.extract! tweet, :id, :company_id, :text, :username, :useful
  json.url tweet_url(tweet, format: :json)
end
