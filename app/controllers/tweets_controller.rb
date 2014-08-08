class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  # GET /tweets
  # GET /tweets.json
  def index
    if(params[:useful] == "1")
      if params[:keyword]
        @tweets = Tweet.where(useful: true).where("text like '%#{params[:keyword]}%'").reorder("updated_at desc").page params[:page]
        @count = Tweet.where(useful: true).where("text like '%#{params[:keyword]}%'").count
      else
        @tweets = Tweet.where(useful: true).reorder("updated_at desc").page params[:page]
        @count = Tweet.where(useful: true).count
      end
    elsif(params[:useful] == "0")
      if params[:keyword]
        @tweets = Tweet.where(useful: false).where("text like '%#{params[:keyword]}%'").reorder("updated_at desc").page params[:page]
        @count = Tweet.where(useful: false).where("text like '%#{params[:keyword]}%'").count
      else
        @tweets = Tweet.where(useful: false).reorder("updated_at desc").page params[:page]
        @count = Tweet.where(useful: false).count
      end
    elsif(params[:useful] == "null")
      if params[:keyword]
        @tweets = Tweet.where(useful: nil).where("text like '%#{params[:keyword]}%'").reorder("updated_at desc").page params[:page]
        @count = Tweet.where(useful: nil).where("text like '%#{params[:keyword]}%'").count
      else
        @tweets = Tweet.where(useful: nil).reorder("updated_at desc").page params[:page]
        @count = Tweet.where(useful: nil).count
      end
    else
      if params[:keyword]
        @tweets = Tweet.where("text like '%#{params[:keyword]}%'").reorder("updated_at desc").page params[:page]
        @count = Tweet.where("text like '%#{params[:keyword]}%'").count
      else
        @tweets = Tweet.reorder("updated_at desc").page params[:page]
        @count = Tweet.count
      end
    end
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
      params.require(:tweet).permit(:company_id, :text, :username, :useful)
    end
  end
