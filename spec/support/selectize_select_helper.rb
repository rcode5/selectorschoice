# frozen_string_literal: true

module SelectizeSelectHelper
  delegate :execute_script, to: :page

  def find_selectized_control_js(key)
    " document.querySelector('##{key}.selectized').nextElementSibling "
  end

  def find_selectized_input(key)
    " document.querySelector('##{key}.selectized') "
  end

  def open_selectize_chooser(key)
    execute_script " document.querySelector('##{key}').selectize.open(); "
  end

  def close_selectize_chooser(key)
    execute_script " document.querySelector('##{key}').selectize.close(); "
  end

  # Select a single item from a selectized select input where multiple=false given the id for base field
  def selectize_single_select(key, value)
    # It may be tempting to combine these into one execute_script, but don't; it will cause failures.
    open_selectize_chooser(key)
    execute_script "
                   var options = #{find_selectized_control_js(key)}.querySelectorAll('.option');
                   var option = Array.from(options).find((opt) => opt.innerHTML.match(/#{value}/));
                   option.click() "
  end

  # Select one or more items from a selectized select input where multiple=true.
  def selectize_multi_select(key, *values)
    values.flatten.each do |value|
      open_selectize_chooser(key)
      execute_script("
      #{find_selectized_control_js(key)}.querySelector('input').value = '#{value}';
      document.querySelector$('##{key}.selectized').selectize.createItem();
    ")
    end
  end

  def fill_in_selectize_multi(key, with:)
    values = [with].flatten.compact
    values.each do |tag|
      page.execute_script "#{find_selectized_control_js(key)}.click();"
      page.execute_script("#{find_selectized_input(key)}.value = '#{tag}';")
      page.execute_script("$(#{find_selectized_input(key)}).keyup().focus()")
      page.execute_script %Q{
      $(#{find_selectized_input(key)}).
        closest('.selectize-control').
        find(' .selectize-dropdown-content').
        children("div:contains('#{tag}')").click();
      }
      page.execute_script "$('body').mousedown()"
    end
  end
end

RSpec.configure do |config|
  config.include SelectizeSelectHelper, type: :feature
end
