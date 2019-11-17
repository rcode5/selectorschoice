# frozen_string_literal: true

module Admin
  class FilesController < AdminController
    def index
      @files = Track.all.map(&:url)
    end
  end
end
