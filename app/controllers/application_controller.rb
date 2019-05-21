# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Clearance::Controller
  include Clearance::Authentication
  protect_from_forgery

  before_action :set_title

  def set_title
    @title = 'Selectors Choice DJ\'s'
  end
end
