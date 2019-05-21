# frozen_string_literal: true

require 'rails_helper'

describe 'admin/tracks/new' do
  before(:each) do
    assign(:track, FactoryBot.build(:track,
                                    title: 'MyString',
                                    display_title: 'MyString',
                                    playlist: 'MyText',
                                    description: 'MyText'))
  end

  it 'renders new track form' do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select 'form', action: tracks_path, method: 'post' do
      assert_select 'input#track_title', name: 'track[title]'
      assert_select 'input#track_display_title', name: 'track[display_title]'
      assert_select 'textarea#track_playlist', name: 'track[playlist]'
      assert_select 'textarea#track_description', name: 'track[description]'
    end
  end
end
