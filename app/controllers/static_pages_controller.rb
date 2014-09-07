class StaticPagesController < ApplicationController
  def home
    @tweets = Tweet.where(useful: true).limit(10).includes(:company)
    @keywords = Keyword.rank.take(20)
    @companies = Company.rank.take(20)
  end

  def update
    @offset = params[:offset].to_i
    @tweets = Tweet.where(useful: true).limit(10).offset(@offset).includes(:company)
    @offset += 10
    respond_to do |format|
      format.js
    end
  end

  def chart_data
    render json: Tweet.period_count_array
  end
end
