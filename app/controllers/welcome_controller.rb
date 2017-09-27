class WelcomeController < ApplicationController
  def index
    if tags_params.present?
      @tags = tags_params
      @tracks = Track.published.tagged_with(@tags, any: true)
      if params[:search]
        flash.now[:notice] = "We found #{@tracks.count} track#{ 's' unless @tracks.count == 1 } that matched your search"
      end
    else
      @tracks = Track.published
    end
    @tracks = @tracks.by_recency.paginate(:page => params[:page], :per_page => 8)
  end

  def tags_params
    if params.has_key?(:tags)
      [params[:tags].split(',')].flatten.map(&:strip).map(&:downcase).uniq.sort
    end
  end
end
