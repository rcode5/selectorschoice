class WelcomeController < ApplicationController
  def index
    @tracks = Track.published.by_recency.paginate(:page => params[:page], :per_page => 5)
  end
end
