class SubIndicesController < ApplicationController
  before_action :set_sub_index, only: [:show]

  # GET /sub_indices/1
  # GET /sub_indices/1.json
  def show
    @companies = @sub_index.companies.where("tweet_count > 0").page(params[:page]).per(30)
    @main_indices = MainIndex.all
    render :template => "companies/index"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sub_index
      @sub_index = SubIndex.find(params[:id])
    end
end
