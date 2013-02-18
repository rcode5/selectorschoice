class AdminController < ApplicationController
  before_filter :authorize, :flash_it

  layout 'admin'

  def index
  end

  private
  def flash_it
    flash.now[:error] = 'error dude'
    flash.now[:notice] = 'notice me'
    flash.now[:warning] = 'warn me'
  end
end
