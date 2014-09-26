class CompaniesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :admin_check, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_company, only: [:chart_data, :show, :edit, :update, :destroy]

  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.rank.where("tweet_count > 0").page params[:page]
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    if params[:k]
      keyword = Keyword.find(params[:k])
      @tweets = keyword.tweets.where(useful: true).where(company: @company).reorder("created_at").page params[:page]
    else
      @tweets = @company.tweets.where(useful: true).reorder("created_at").page params[:page]
    end
    @keywords = @company.keywords
  end

  def chart_data
    @keywords = @company.keywords.sort {|a, b| b.tweets_count_with_company(@company) <=> a.tweets_count_with_company(@company) }
    @chart_data = {}
    @keywords[0..10].each {|k| @chart_data[k.name] = k.tweets_count_with_company(@company) }
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
end
