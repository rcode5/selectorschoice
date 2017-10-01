# frozen_string_literal: true

require 'spec_helper'

describe 'welcome/index' do
  describe 'with no args' do
    before do
      8.times { |x| FactoryGirl.create :track, published: x.even? }
      tracks = Track.published
      allow(tracks).to receive(:total_pages).and_return(2)
      allow(tracks).to receive(:total_entries).and_return(8)
      allow(tracks).to receive(:per_page).and_return(5)
      allow(tracks).to receive(:current_page).and_return(1)
      assign(:tracks, tracks)
      render
    end
    it 'renders published tracks' do
      assert_select '.track', count: Track.published.count
    end
    it 'renders a div for pagination' do
      assert_select '.apple_pagination'
    end
  end
end
