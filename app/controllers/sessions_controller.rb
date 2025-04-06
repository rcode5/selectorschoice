# frozen_string_literal: true

class SessionsController < Clearance::SessionsController
  def url_after_create
    admin_index_path
  end

  def url_after_destroy
    root_path
  end
end
