# frozen_string_literal: true

# bug in rails-dom-testing
# https://github.com/rails/rails-dom-testing/issues/48
# fixed in 2.x but we need rails 5
class SubstitutionContext
  def substitute_with_dup!(selector, *args)
    substitute_without_dup!(selector.dup, *args)
  end
  alias_method_chain :substitute!, :dup
end
