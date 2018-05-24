# frozen_string_literal: true

require 'rails_helper'

describe 'welcome/index', type: :view do
  describe 'with no args' do
    before do
      8.times { |x| FactoryBot.create :track, published: x.even? }
      tracks = Track.published.paginate(page: 1, per_page: 2)
      assign(:tracks, tracks)
      render
    end
    it 'renders published tracks' do
      assert_select '.track', count: 2
    end
    it 'renders a div for pagination' do
      assert_select '.apple_pagination'
    end
  end
end
