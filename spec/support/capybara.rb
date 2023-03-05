# frozen_string_literal: true

require 'webdrivers'
require 'selenium/webdriver'

class CapybaraChromeConfig
  def self.chrome_capabilities(headless: false)
    headless_chrome_args = %w[disable-popup-blocking] + ['window-size=1900,1200']
    headless_chrome_args += %w[headless no-sandbox disable-gpu] if headless

    Selenium::WebDriver::Remote::Capabilities.chrome(
      'goog:chromeOptions': {
        args: headless_chrome_args,
        prefs: {
          browser: { set_download_behavior: { behavior: 'allow' } },
        },
      },
    )
  end
end

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome, capabilities: CapybaraChromeConfig.chrome_capabilities)
end

Capybara::Screenshot.register_driver :chrome do |driver, path|
  driver.browser.save_screenshot(path)
end

Capybara.register_driver :headless_chrome do |app|
  capabilities = CapybaraChromeConfig.chrome_capabilities(headless: true)
  Capybara::Selenium::Driver.new(app, browser: :chrome, capabilities:)
end

Capybara::Screenshot.register_driver(:headless_chrome) do |driver, path|
  driver.browser.save_screenshot(path)
end

Capybara.javascript_driver = ENV.fetch('ACTUAL_CHROME', nil) == 'true' ? :chrome : :headless_chrome
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
