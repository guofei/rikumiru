json.array!(@keyword_indices) do |keyword_index|
  json.extract! keyword_index, :id, :name
  json.url keyword_index_url(keyword_index, format: :json)
end
