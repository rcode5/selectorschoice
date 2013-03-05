class WelcomeController < ApplicationController
  def index
    if params[:tags]
      @tags = [params[:tags].split(',')].flatten.sort.uniq
      @tracks = Track.published.tagged_with(@tags)
    else
      @tracks = Track.published
    end
    @tracks = @tracks.by_recency.paginate(:page => params[:page], :per_page => 5)
  end
end
