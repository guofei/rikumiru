class KeywordsController < ApplicationController
  def index
    @keywords = Keyword.all
    @tweet = Tweet.first
  end
end
