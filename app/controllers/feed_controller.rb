# frozen_string_literal: true

class FeedController < ApplicationController
  def show
    @tracks = Track.published.by_recency
    respond_to do |fmt|
      fmt.html do
        redirect_to :root
      end
      fmt.json do
        render json: @tracks
      end
      fmt.xml do
        @pub_date = Track.maximum(:updated_at)
        @last_build_date = Track.maximum(:updated_at)
        render
      end
      fmt.rss do
        redirect_to feed_path(format: :xml)
      end
    end
  end
end
