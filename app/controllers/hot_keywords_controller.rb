class HotKeywordsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_check
  before_action :set_hot_keyword, only: [:show, :edit, :update, :destroy]

  # GET /hot_keywords
  # GET /hot_keywords.json
  def index
    @hot_keywords = HotKeyword.page params[:page]
  end

  # GET /hot_keywords/1
  # GET /hot_keywords/1.json
  def show
  end

  # GET /hot_keywords/new
  def new
    @hot_keyword = HotKeyword.new
  end

  # GET /hot_keywords/1/edit
  def edit
  end

  # POST /hot_keywords
  # POST /hot_keywords.json
  def create
    @hot_keyword = HotKeyword.new(hot_keyword_params)

    respond_to do |format|
      if @hot_keyword.save
        format.html { redirect_to @hot_keyword, notice: 'Hot keyword was successfully created.' }
        format.json { render :show, status: :created, location: @hot_keyword }
      else
        format.html { render :new }
        format.json { render json: @hot_keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hot_keywords/1
  # PATCH/PUT /hot_keywords/1.json
  def update
    respond_to do |format|
      if @hot_keyword.update(hot_keyword_params)
        format.html { redirect_to @hot_keyword, notice: 'Hot keyword was successfully updated.' }
        format.json { render :show, status: :ok, location: @hot_keyword }
      else
        format.html { render :edit }
        format.json { render json: @hot_keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hot_keywords/1
  # DELETE /hot_keywords/1.json
  def destroy
    @hot_keyword.destroy
    respond_to do |format|
      format.html { redirect_to hot_keywords_url, notice: 'Hot keyword was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hot_keyword
      @hot_keyword = HotKeyword.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hot_keyword_params
      params.require(:hot_keyword).permit(:company_id, :name)
    end
end
