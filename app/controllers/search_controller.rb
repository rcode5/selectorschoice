class SearchController < ApplicationController
  def show
    @query = search_params[:search]
    @tracks = SearchService.new(@query).search.paginate(page: params[:page], per_page: 40)
  end

  private

  def search_params
    params.permit(:search)
  end
end
