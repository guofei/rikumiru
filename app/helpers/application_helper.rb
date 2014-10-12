require 'matrix'

module ApplicationHelper
  def title(page_title)
    content_for :title, page_title.to_s
  end

  def show_admin?
    cookies[:showadmin] == 't'
  end

  def similarity?(prev_text, text)
    corpus = [TfIdfSimilarity::Document.new(prev_text), TfIdfSimilarity::Document.new(text)]
    model = TfIdfSimilarity::TfIdfModel.new(corpus)
    model.similarity_matrix.column(0)[1] > 0.7
  end
end
