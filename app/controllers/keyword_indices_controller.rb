class KeywordIndicesController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_check
  before_action :set_keyword_index, only: [:show, :edit, :update, :destroy]

  # GET /keyword_indices
  # GET /keyword_indices.json
  def index
    @keyword_indices = KeywordIndex.all
  end

  # GET /keyword_indices/1
  # GET /keyword_indices/1.json
  def show
  end

  # GET /keyword_indices/new
  def new
    @keyword_index = KeywordIndex.new
  end

  # GET /keyword_indices/1/edit
  def edit
  end

  # POST /keyword_indices
  # POST /keyword_indices.json
  def create
    @keyword_index = KeywordIndex.new(keyword_index_params)

    respond_to do |format|
      if @keyword_index.save
        format.html { redirect_to @keyword_index, notice: 'Keyword index was successfully created.' }
        format.json { render :show, status: :created, location: @keyword_index }
      else
        format.html { render :new }
        format.json { render json: @keyword_index.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /keyword_indices/1
  # PATCH/PUT /keyword_indices/1.json
  def update
    respond_to do |format|
      if @keyword_index.update(keyword_index_params)
        format.html { redirect_to @keyword_index, notice: 'Keyword index was successfully updated.' }
        format.json { render :show, status: :ok, location: @keyword_index }
      else
        format.html { render :edit }
        format.json { render json: @keyword_index.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /keyword_indices/1
  # DELETE /keyword_indices/1.json
  def destroy
    @keyword_index.destroy
    respond_to do |format|
      format.html { redirect_to keyword_indices_url, notice: 'Keyword index was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_keyword_index
      @keyword_index = KeywordIndex.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def keyword_index_params
      params.require(:keyword_index).permit(:name)
    end
end
