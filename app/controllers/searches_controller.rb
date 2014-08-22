class SearchesController < ApplicationController
  def index
    @companies = Company.search(name_cont: params[:company]).result
    if @companies.count == 1
      redirect_to company_path(@companies.first) and return
    end
  end
end
