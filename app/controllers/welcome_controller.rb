class WelcomeController < ApplicationController
  def index
    if params[:tags] && params[:tags].present?
      @tags = [params[:tags].split(',')].flatten.map(&:strip).map(&:downcase).uniq.sort
      @tracks = Track.published.tagged_with(@tags)
      if params[:search]
        flash.now[:notice] = "We found #{@tracks.count} track#{ 's' unless @tracks.count == 1 } that matched your search"
      end
    else
      @tracks = Track.published
    end
    @tracks = @tracks.by_recency.paginate(:page => params[:page], :per_page => 8)
  end
end
