# frozen_string_literal: true

require 'rails_helper'

describe 'admin/tracks/index' do
  before(:each) do
    mock_cloud_front
    published = [FactoryBot.create(:track)]
    unpublished = [FactoryBot.create(:track, published: false)]
    @tracks = published + unpublished
    assign(:published, published)
    assign(:unpublished, unpublished)
    render
  end

  it 'renders a list of tracks' do
    expect(@tracks).to have_at_least(1).track
    @tracks.each do |track|
      assert_select 'tr td.admin-track__recorded_on', text: track.recorded_on.strftime('%m %d %Y')
      assert_select '.admin-track__info .title', track.pretty_title
      assert_select '.admin-track__info .author', match: /#{track.author}/
      assert_select '.admin-track__url input.admin-track__url--input'
      assert_select '.admin-track__edit-controls .icon-edit'
      assert_select '.admin-track__edit-controls .icon-show'
      assert_select '.admin-track__edit-controls .icon-delete'
    end
  end
end
