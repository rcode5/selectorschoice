# frozen_string_literal: true

module Admin
  class PalettesController < AdminController
    def show
      f = File.expand_path('app/assets/stylesheets/imports/colors.scss')
      @colors = SassColorExtractor::Base.parse_colors(f)
    end
  end
end
