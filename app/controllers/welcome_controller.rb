# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    if tags_params.present?
      @tags = tags_params
      @tracks = Track.published.tagged_with(@tags, any: true)
      if params[:search].present?
        flash.now[:notice] =
          "We found #{'track'.pluralize(@tracks.length)} " \
          'that matched your search'
      end
    else
      @tracks = Track.published
    end
    @tracks = @tracks.by_recency.paginate(page: params[:page], per_page: 8)
  end

  def tags_params
    return unless params.key?(:tags)

    [params[:tags].split(',')].flatten.map { |t| t.strip.downcase }.uniq.sort
  end
end
