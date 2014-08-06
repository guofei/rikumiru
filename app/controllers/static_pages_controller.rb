class StaticPagesController < ApplicationController
  def home
    @tweets = Tweet.where(useful: true).take(100)
    @keywords = Keyword.rank.take(20)
    @companies = Company.sorted_by_name.take(20)
  end
end
