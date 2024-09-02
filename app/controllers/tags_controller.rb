# frozen_string_literal: true

class TagsController < ApplicationController
  def index
    respond_to do |fmt|
      fmt.html { redirect_to '/' }
      fmt.json do
        tags = Track.tag_counts
        styles = Track.style_counts
        render json: (tags + styles).map { |t| t.name.downcase }.uniq.sort
      end
    end
  end
end
