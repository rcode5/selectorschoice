require 'spec_helper'

describe 'welcome/index' do
  before do
    5.times { |x| FactoryGirl.create :track, published: ((x%2) == 0) }
    tracks = Track.published.all
    tracks.stub!(:total_pages).and_return(0)
    assign(:tracks, tracks)
    render
  end
  it 'renders published tracks' do
    assert_select '.track', count: Track.published.count
  end
end
