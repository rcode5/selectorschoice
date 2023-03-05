# frozen_string_literal: true

require 'rails_helper'

feature 'Admin' do
  include_context 'admin logged in'
  before do
    mock_cloud_front
  end

  context 'when there are a few tracks' do
    before do
      FactoryBot.create(:track)
      FactoryBot.create(:track, :published)
      visit admin_index_path
    end

    scenario 'can see state of the db' do
      expect(page).to have_content 'Tracks'
      expect(page).to have_content 'Total:2'
      expect(page).to have_content 'Published:1'
      expect(page).to have_content 'In the wings:1'
    end

    scenario 'can add a track', js: true do
      click_on 'tracks'

      click_on 'add new track'

      fill_in :track_title, with: 'the new track title'

      click_on 'Create Track'

      expect(page).to have_content 'prohibited this track from being saved'
      expect(page).to have_content "Filename can't be blank"

      fill_in :track_title, with: 'track with recorded time'
      fill_in_datepicker(:recorded_on_day, with: '2020-10-10')
      fill_in :recorded_on_time, with: '2:00pm'
      fill_in :track_filename, with: 'the_dir/the_file.mp3'

      click_on 'Create Track'

      expect(page).to have_content 'track with recorded time(draft)'
      expect(page).to have_content '2020-10-10'
    end

    scenario 'can add a track with tags', js: true do
      click_on 'tracks'

      click_on 'add new track'

      fill_in :track_title, with: 'the new track title'

      click_on 'Create Track'

      expect(page).to have_content 'prohibited this track from being saved'
      expect(page).to have_content "Filename can't be blank"

      fill_in :track_title, with: 'track with tags and style'
      fill_in_selectize_multi('track_tag_list', with: 'my tag')
      fill_in_selectize_multi('track_style_list', with: 'my style')
      fill_in :track_filename, with: 'the_dir/the_file.mp3'
      check :track_published

      click_on 'Create Track'

      expect(page).to have_content 'track with tags and style(published)'
      expect(page).to have_content 'my tag'
      expect(page).to have_content 'my style'
    end
  end
end
