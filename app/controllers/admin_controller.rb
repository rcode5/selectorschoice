# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :require_login

  layout 'admin'

  def index
    @track_counts = {
      all: Track.count,
      published: Track.published.count,
      unpublished: Track.unpublished.count,
    }
    @track_tags = {
      tags: Track.tag_counts_on(:tags),
      styles: Track.tag_counts_on(:styles),
    }
  end
end
