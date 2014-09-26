class KeywordsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :admin_check, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_keyword, only: [:chart_data, :show, :edit, :update, :destroy]

  # GET /keywords
  # GET /keywords.json
  def index
    @keywords = Keyword.rank.page params[:page]
  end

  # GET /keywords/1
  # GET /keywords/1.json
  def show
    if params[:c]
      company = Company.find(params[:c])
      @tweets = @keyword.tweets.where(useful: true).where(company: company).reorder("created_at").includes(:company).page params[:page]
    else
      @tweets = @keyword.tweets.where(useful: true).reorder("created_at").includes(:company).page params[:page]
    end
    @companies = @keyword.companies.reorder("tweet_count desc").take(50)
  end

  def chart_data
    # company_tweet_count is saved in redis
    @chart_data = {}
    @keyword.company_tweet_count.members(:with_scores => true).reverse[0..10].each do |arr|
      name = Company.find(arr[0]).name
      @chart_data[name] = arr[1]
    end
    render json: @chart_data
  end

  # GET /keywords/new
  def new
    @keyword = Keyword.new
  end

  # GET /keywords/1/edit
  def edit
  end

  # POST /keywords
  # POST /keywords.json
  def create
    @keyword = Keyword.new(keyword_params)
    @keyword.tweet_count = 0

    respond_to do |format|
      if @keyword.save
        format.html { redirect_to @keyword, notice: 'Keyword was successfully created.' }
        format.json { render :show, status: :created, location: @keyword }
      else
        format.html { render :new }
        format.json { render json: @keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /keywords/1
  # PATCH/PUT /keywords/1.json
  def update
    respond_to do |format|
      if @keyword.update(keyword_params)
        format.html { redirect_to @keyword, notice: 'Keyword was successfully updated.' }
        format.json { render :show, status: :ok, location: @keyword }
      else
        format.html { render :edit }
        format.json { render json: @keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /keywords/1
  # DELETE /keywords/1.json
  def destroy
    @keyword.destroy
    respond_to do |format|
      format.html { redirect_to keywords_url, notice: 'Keyword was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_keyword
      @keyword = Keyword.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def keyword_params
      params.require(:keyword).permit(:name)
    end
end
