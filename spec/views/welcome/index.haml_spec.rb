require 'spec_helper'

describe 'welcome/index' do
  describe 'with no args' do
    before do
      8.times { |x| FactoryGirl.create :track, published: ((x%2) == 0) }
      tracks = Track.published.all
      tracks.stub!(:total_pages).and_return(2)
      tracks.stub!(:total_entries).and_return(8)
      tracks.stub!(:per_page).and_return(5)
      tracks.stub!(:current_page).and_return(1)
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
  describe 'with tags' do
    pending 'it shows only tagged tracks'
  end
end
