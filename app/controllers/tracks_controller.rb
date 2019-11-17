# frozen_string_literal: true

class TracksController < ApplicationController
  def show
    @track = Track.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: TrackSerializer.new(@track).serialized_json }
    end
  end
end
