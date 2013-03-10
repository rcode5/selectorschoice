class TagsController < ApplicationController
  def index
    respond_to do |fmt|
      fmt.html { redirect_to '/' }
      fmt.json {
        tags = Track.tag_counts
        styles = Track.tag_counts_on(:style)
        render json: (tags+styles).map(&:name).compact.uniq.sort
      }
    end
  end
end
