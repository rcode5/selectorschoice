# frozen_string_literal: true

# This is a provisional fix for an rspec-rails issue
# (see https://github.com/rspec/rspec-rails/issues/476).
# It allows for a proper test execution with `config.threadsafe!`.
ActionView::TestCase::TestController.instance_eval do
  helper Rails.application.routes.url_helpers # , (append other helpers you need)
end
ActionView::TestCase::TestController.class_eval do
  def _routes
    Rails.application.routes
  end
end
