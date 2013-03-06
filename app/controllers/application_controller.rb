class ApplicationController < ActionController::Base
  include Clearance::Authentication
  protect_from_forgery
  
  before_filter :set_title
  
  def set_title
    @title = 'Selectors Choice DJ\'s'
  end
end
