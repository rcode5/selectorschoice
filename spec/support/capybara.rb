# frozen_string_literal: true

require 'webdrivers'
require 'selenium/webdriver'

class CapybaraChromeConfig
  def self.chrome_capabilities(headless: false)
    Selenium::WebDriver::Chrome::Options.new.tap do |options|
      options.add_argument('--disable-popup-blocking')
      options.add_argument('--window-size=1900,1200')
      if headless
        options.add_argument('--headless')
        options.add_argument('--no-sandbox')
        options.add_argument('--disable-gpu')
      end
    end
  end
end

Capybara.register_driver :chrome do |app|
  options = CapybaraChromeConfig.chrome_capabilities(headless: false)
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options:,
  )
end

Capybara::Screenshot.register_driver :chrome do |driver, path|
  driver.browser.save_screenshot(path)
end

Capybara.register_driver :headless_chrome do |app|
  options = CapybaraChromeConfig.chrome_capabilities(headless: true)
  Capybara::Selenium::Driver.new(app, browser: :chrome, options:)
end

Capybara::Screenshot.register_driver(:headless_chrome) do |driver, path|
  driver.browser.save_screenshot(path)
end

Capybara.javascript_driver = %w[1 true on].include?(ENV.fetch('ACTUAL_CHROME', nil)) ? :chrome : :headless_chrome

Capybara.default_max_wait_time = 5

RSpec.configure do |config|
  config.before(:all, type: :feature, js: true) do
    Capybara.reset!
  end

  config.around(:each, js: true) do |ex|
    Capybara.reset_sessions!
    ex.run
  end
end
