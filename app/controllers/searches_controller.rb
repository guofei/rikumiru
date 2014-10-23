class SearchesController < ApplicationController
  def index
    keywords = params[:company] || ''
    keywords.gsub!('#', '%23')
    redirect_to "https://www.google.co.jp/#q=site:www.rikulib.com+#{keywords}"
    # @companies = Company.search(name_cont: params[:company]).result
    # if @companies.count == 1
    #   redirect_to company_path(@companies.first) and return
    # end
  end
end
