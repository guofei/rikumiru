class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_check
  before_action :set_tweet, only: [:show, :edit, :update, :destroy, :vote]

  # GET /tweets
  # GET /tweets.json
  def userfilter
    @tweets = Tweet.where(useful: true).where("user_vote < 0").includes(:company).page params[:page]
    @count = Tweet.where(useful: true).where("user_vote < 0").count
  end

  def index
    @tweets = Tweet.reorder("updated_at desc")
    @tweets = @tweets.where(useful: true) if params[:useful] == "1"
    @tweets = @tweets.where(useful: false) if params[:useful] == "0"
    @tweets = @tweets.where(useful: nil) if params[:useful] == "null"
    @tweets = @tweets.where(bayesfilter: true) if params[:bayesfilter] == "1"
    @tweets = @tweets.where(bayesfilter: false) if params[:bayesfilter] == "0"
    @tweets = @tweets.where("updated_at <= ?", params[:day].to_i.days.ago) if params[:day]
    @tweets = @tweets.where("company_id <= #{params[:company].to_i}") if params[:company]
    @tweets = @tweets.where("text like '%#{params[:keyword]}%'") if params[:keyword]
    @tweets = @tweets.where("length(text) < ?", params[:maxlen].to_i) if params[:maxlen]

    @count = @tweets.count
    @tweets = @tweets.includes(:company).page params[:page]
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  # POST /tweets.json
  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_vote = 0

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to @tweet, notice: 'Tweet was successfully created.' }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  def unuseful
    tweet_ids = params[:tweets]
    tweet_ids.each do |tweet_id|
      tweet = Tweet.find(tweet_id)
      next if tweet.useful == false
      tweet.useful = false
      tweet.save
    end
    respond_to do |format|
      format.js
    end
  end

  def bayesfilter
    tweet_ids = params[:tweets]
    tweet_ids.each do |tweet_id|
      tweet = Tweet.find(tweet_id)
      next if tweet.bayesfilter == false
      tweet.bayesfilter = false
      tweet.save
    end
    respond_to do |format|
      format.js
    end
  end

  def removeall
    tweet_ids = params[:tweets]
    tweet_ids.each do |tweet_id|
      tweet = Tweet.find(tweet_id)
      tweet.destroy
    end
    respond_to do |format|
      format.js
    end
  end

  def vote
    @tweet.user_vote = 0 if @tweet.user_vote == nil
    if params[:up]
      @tweet.user_vote += 1
    elsif
      @tweet.user_vote -= 1
    end
    if @tweet.user_vote <= -3
      @tweet.useful = false
      @tweet.bayesfilter = false
    end
    respond_to do |format|
      if @tweet.save
        format.js
        format.html { redirect_to tweets_url, notice: 'Tweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.js
        format.html { redirect_to tweets_url, notice: 'Tweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to tweets_url, notice: 'Tweet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tweet_params
      params.require(:tweet).permit(:company_id, :text, :username, :useful, :bayesfilter)
    end
  end
