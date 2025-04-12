# frozen_string_literal: true

# extra capybara/bootstrap matchers
module Capybara
  class Session
    def has_alert?(type, msg = nil)
      if msg
        has_selector?(".alert-#{type}", text: msg)
      else
        has_selector?(".alert-#{type}")
      end
    end
    alias has_flash? has_alert?

    def has_form_errors_on?(field_id, msg = nil)
      locator = ".form-group.has-error.#{field_id}"
      return has_css?(locator) if msg.nil?

      within(locator) do
        has_selector?('.help-block', text: msg)
      end
    end
  end
end

module CapybaraHelpers
  def table_row_matching(content)
    content_matcher = content.is_a?(String) ? /#{content}/ : content
    match = all('table tbody tr').select do |row|
      content_matcher =~ row.text
    end
    raise "Can't find row matching \"#{content}\"" unless match.first

    match.first
  end

  def find_first_link_or_button(locator)
    find_links_or_buttons(locator).first
  end

  def find_last_link_or_button(locator)
    find_links_or_buttons(locator).last
  end

  def all_links_or_buttons_with_title(title)
    all('a,button').select { |a| a['title'] == title }
  end

  def find_links_or_buttons(locator)
    result = all("##{locator}")
    return result unless result.empty?

    result = all('a,button', text: locator)
    return result unless result.empty?

    all_links_or_buttons_with_title(locator)
  end

  def click_on_first(locator)
    first = find_links_or_buttons(locator).first
    raise "Can't find the first #{locator} button or link" unless first

    first.click
  end

  def click_on_last(locator)
    last = find_links_or_buttons(locator).last
    raise "Can't find the last #{locator} button or link" unless last

    last.click
  end

  def click_on_table_action_icon(locator)
    find(".tooltipable[data-original-title='#{locator}']").click
  end

  def click_on_nav_item(locator)
    within('.navbar') do
      click_on(locator)
    end
  end

  ##
  #
  # This helper, appropriately placed in a JS feature spec, will allow you to output any logging that occurred in the
  # browser session. This also depends on Chrome logging_prefs being set to { browser: "ALL" } in
  # /spec/support/features/capybara_chromedriver.rb.
  #
  # To use this, you must pass an argument with your feature spec scenario definition block. For instance:
  #
  # feature "JS feature spec", js: true do
  #   scenario "do stuff" do |example|
  #     ...
  #     output_console_log(example)
  #   end
  # end
  #
  def output_console_log(example)
    return unless example.metadata[:js]

    # rubocop:disable Style/SafeNavigationChainLength
    logs = page.driver.browser&.manage&.logs&.get(:browser) || []
    # rubocop:enable Style/SafeNavigationChainLength
    puts(logs.map { |line| "[JSLOG]: #{line}" }.join("\n"))
  end
end

RSpec.configure do |config|
  config.include CapybaraHelpers, type: :feature
end
