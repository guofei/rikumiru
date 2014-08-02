class StaticPagesController < ApplicationController
  def home
    @tweets = Tweet.take(100)
  end
end
