json.array!(@mailmagas) do |mailmaga|
  json.extract! mailmaga, :id, :email
  json.url mailmaga_url(mailmaga, format: :json)
end
