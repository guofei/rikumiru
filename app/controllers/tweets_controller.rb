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
    if(params[:useful] == "1")
      if params[:keyword]
        if params[:bayesfilter] == "1"
          if params[:company]
            @tweets = Tweet.where(useful: true).where("company_id < #{params[:company].to_i}").where("text like '%#{params[:keyword]}%'").where(bayesfilter: true).reorder("updated_at desc").includes(:company).page params[:page]
            @count = Tweet.where(useful: true).where("company_id < #{params[:company].to_i}").where("text like '%#{params[:keyword]}%'").where(bayesfilter: true).count
          else
            @tweets = Tweet.where(useful: true).where("text like '%#{params[:keyword]}%'").where(bayesfilter: true).reorder("updated_at desc").includes(:company).page params[:page]
            @count = Tweet.where(useful: true).where("text like '%#{params[:keyword]}%'").where(bayesfilter: true).count
          end
        elsif params[:bayesfilter] == "0"
          @tweets = Tweet.where(useful: true).where("text like '%#{params[:keyword]}%'").where(bayesfilter: false).reorder("updated_at desc").includes(:company).page params[:page]
          @count = Tweet.where(useful: true).where("text like '%#{params[:keyword]}%'").where(bayesfilter: false).count
        else
          @tweets = Tweet.where(useful: true).where("text like '%#{params[:keyword]}%'").reorder("updated_at desc").includes(:company).page params[:page]
          @count = Tweet.where(useful: true).where("text like '%#{params[:keyword]}%'").count
        end
      else
        if params[:bayesfilter] == "1"
          if params[:company]
            @tweets = Tweet.where(useful: true).where("company_id < #{params[:company].to_i}").includes(:company).where(bayesfilter: true).reorder("updated_at desc").page params[:page]
            @count = Tweet.where(useful: true).where("company_id < #{params[:company].to_i}").where(bayesfilter: true).count
          else
            @tweets = Tweet.where(useful: true).includes(:company).where(bayesfilter: true).reorder("updated_at desc").page params[:page]
            @count = Tweet.where(useful: true).where(bayesfilter: true).count
          end
        elsif params[:bayesfilter] == "0"
          @tweets = Tweet.where(useful: true).includes(:company).where(bayesfilter: false).reorder("updated_at desc").page params[:page]
          @count = Tweet.where(useful: true).where(bayesfilter: false).count
        else
          @tweets = Tweet.where(useful: true).includes(:company).reorder("updated_at desc").page params[:page]
          @count = Tweet.where(useful: true).count
        end
      end
    elsif(params[:useful] == "0")
      if params[:keyword]
        @tweets = Tweet.where(useful: false).where("text like '%#{params[:keyword]}%'").reorder("updated_at desc").includes(:company).page params[:page]
        @count = Tweet.where(useful: false).where("text like '%#{params[:keyword]}%'").count
      else
        @tweets = Tweet.where(useful: false).reorder("updated_at desc").includes(:company).page params[:page]
        @count = Tweet.where(useful: false).count
      end
    elsif(params[:useful] == "null")
      if params[:keyword]
        @tweets = Tweet.where(useful: nil).where("text like '%#{params[:keyword]}%'").reorder("updated_at desc").includes(:company).page params[:page]
        @count = Tweet.where(useful: nil).where("text like '%#{params[:keyword]}%'").count
      else
        @tweets = Tweet.where(useful: nil).reorder("updated_at desc").includes(:company).page params[:page]
        @count = Tweet.where(useful: nil).count
      end
    else
      if params[:keyword]
        if params[:bayesfilter] == "1"
          @tweets = Tweet.where("text like '%#{params[:keyword]}%'").where(bayesfilter: true).reorder("updated_at desc").includes(:company).page params[:page]
          @count = Tweet.where("text like '%#{params[:keyword]}%'").where(bayesfilter: true).count
        elsif params[:bayesfilter] == "0"
          @tweets = Tweet.where("text like '%#{params[:keyword]}%'").where(bayesfilter: false).reorder("updated_at desc").includes(:company).page params[:page]
          @count = Tweet.where("text like '%#{params[:keyword]}%'").where(bayesfilter: false).count
        else
          @tweets = Tweet.where("text like '%#{params[:keyword]}%'").reorder("updated_at desc").includes(:company).page params[:page]
          @count = Tweet.where("text like '%#{params[:keyword]}%'").count
        end
      else
        if params[:bayesfilter] == "1"
          @tweets = Tweet.reorder("updated_at desc").where(bayesfilter: true).includes(:company).page params[:page]
          @count = Tweet.where(bayesfilter: true).count
        elsif params[:bayesfilter] == "0"
          @tweets = Tweet.reorder("updated_at desc").where(bayesfilter: false).includes(:company).page params[:page]
          @count = Tweet.where(bayesfilter: false).count
        else
          @tweets = Tweet.reorder("updated_at desc").includes(:company).page params[:page]
          @count = Tweet.count
        end
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
