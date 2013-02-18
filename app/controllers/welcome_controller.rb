class WelcomeController < ApplicationController
  def index
    @tracks = Track.by_recency
  end
end
