class AdminController < ApplicationController
  before_filter :authorize
  layout 'admin'
  def index
  end
end
