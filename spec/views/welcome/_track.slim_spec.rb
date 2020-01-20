# frozen_string_literal: true

require 'rails_helper'

describe 'welcome/_track', type: :view do
  before do
    mock_cloud_front
    track = FactoryBot.create :track, published: true
    @tr = assign(:track, track)
    render
  end
  it 'renders header body and footer sections' do
    assert_select '.track .hd'
    assert_select '.track .bd'
    assert_select '.track .ft'
  end
  it 'renders the title' do
    assert_select '.hd h2.title', /#{@tr.title}/
  end
  it 'renders the audio tag' do
    assert_select format('.bd .audio .pre-audio[track_id="%s"]', @tr.id)
  end
  it 'renders runs markdown conversion on the tracklist' do
    assert_select '.tracklist.markup' do
      assert_select 'ul li', /song 1/
    end
  end
  it 'renders a download link' do
    assert_select ".bd .download a[track_id='#{@tr.id}'] i.icon-download"
  end
end
