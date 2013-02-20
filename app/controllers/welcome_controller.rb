class WelcomeController < ApplicationController
  def index
    @tracks = Track.published.by_recency
  end
end
