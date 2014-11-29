class MailmagasController < ApplicationController
  before_action :set_mailmaga, only: [:show, :edit, :update, :destroy]

  # GET /mailmagas
  # GET /mailmagas.json
  def index
    @mailmagas = Mailmaga.all
  end

  # GET /mailmagas/1
  # GET /mailmagas/1.json
  def show
  end

  # GET /mailmagas/new
  def new
    @mailmaga = Mailmaga.new
  end

  # GET /mailmagas/1/edit
  def edit
  end

  # POST /mailmagas
  # POST /mailmagas.json
  def create
    @mailmaga = Mailmaga.new(mailmaga_params)

    respond_to do |format|
      if @mailmaga.save
        format.html { redirect_to maga_path, notice: 'Mailmaga was successfully created.' }
        format.json { render :show, status: :created, location: @mailmaga }
      else
        format.html { render :new }
        format.json { render json: @mailmaga.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mailmagas/1
  # PATCH/PUT /mailmagas/1.json
  def update
    respond_to do |format|
      if @mailmaga.update(mailmaga_params)
        format.html { redirect_to @mailmaga, notice: 'Mailmaga was successfully updated.' }
        format.json { render :show, status: :ok, location: @mailmaga }
      else
        format.html { render :edit }
        format.json { render json: @mailmaga.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mailmagas/1
  # DELETE /mailmagas/1.json
  def destroy
    @mailmaga.destroy
    respond_to do |format|
      format.html { redirect_to mailmagas_url, notice: 'Mailmaga was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mailmaga
      @mailmaga = Mailmaga.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mailmaga_params
      params.require(:mailmaga).permit(:email, :company_id, :keyword_id)
    end

    def maga_path
      value = @mailmaga
      value = @mailmaga.company if @mailmaga.company
      value = @mailmaga.keyword if @mailmaga.keyword
      value
    end
end
