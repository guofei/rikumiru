# coding: utf-8
class CompaniesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :admin_check, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_company, only: [:chart_data, :emotion_chart, :show, :edit, :update, :destroy]
  before_action :set_emotion, only: [:emotion_chart, :show]

  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.rank.where("tweet_count > 0").page params[:page]
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    if params[:k]
      @tweets = Keyword.find(params[:k]).tweets.where(useful: true).where(company: @company).reorder("created_at")
    else
      @tweets = Tweet.where(useful: true).where(company: @company).reorder("created_at")
    end
    @tweets = @tweets.where("emotion_score > 0.6") if params[:good] == "1"
    @tweets = @tweets.where("emotion_score < -0.6") if params[:bad] == "1"
    @tweets = @tweets.where("text like '%" + params[:keyword] + "%'") if params[:keyword]
    page = params[:page] ? params[:page] : @tweets.page.num_pages
    @tweets = @tweets.page page

    @hotkeywords_month = @company.hot_keywords.where(useful: true).where(recent_day: 30).limit 30
    @hotkeywords_week = @company.hot_keywords.where(useful: true).where(recent_day: 7).limit 15
  end

  def chart_data
    @keywords = @company.keywords.sort {|a, b| b.tweets_count_with_company(@company) <=> a.tweets_count_with_company(@company) }
    @chart_data = {}
    @keywords[0..10].each {|k| @chart_data[k.name] = k.tweets_count_with_company(@company) }
    render json: @chart_data
  end

  def emotion_chart
    @chart_data = {}

    @chart_data["Good (#{@emotion_good_percent}%)"] = @emotion_plus
    @chart_data["Bad (#{@emotion_bad_percent}%)"] = @emotion_minus
    @chart_data["Other (#{@emotion_other_percent}%)"] = @emotion_other
    render json: @chart_data
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)
    @company.tweet_count = 0

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :alice_name, :tweet_id)
    end

    def set_emotion
      @emotion_plus = @company.tweets.where(useful: true).where("emotion_score > 0.3").count
      @emotion_minus = @company.tweets.where(useful: true).where("emotion_score < -0.5").count
      @emotion_other = @company.tweets.where(useful: true).where("emotion_score > -0.5 and emotion_score < 0.3").count
      @emotion_good_percent = (100.0 * @emotion_plus / (@emotion_minus + @emotion_plus + @emotion_other + 1)).to_i
      @emotion_bad_percent = (100.0 * @emotion_minus / (@emotion_minus + @emotion_plus + @emotion_other + 1)).to_i
      @emotion_other_percent = (100.0 * @emotion_other / (@emotion_minus + @emotion_plus + @emotion_other + 1)).to_i
    end
end
