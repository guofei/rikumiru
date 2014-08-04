class StaticPagesController < ApplicationController
  def home
    @tweets = Tweet.where(useful: true).take(100)
    @keywords = Keyword.all
  end
end
