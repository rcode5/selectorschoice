# frozen_string_literal: true

class FeedController < ApplicationController
  def show
    @tracks = Track.published.by_recency
    respond_to do |fmt|
      fmt.html {
        redirect_to :root
      }
      fmt.json {
        render json: @tracks
      }
      fmt.xml {
        @pub_date = Track.maximum(:updated_at)
        @last_build_date = Track.maximum(:updated_at)
        render
      }
      fmt.rss {
        redirect_to feed_path(format: :xml)
      }
    end

  end
end
