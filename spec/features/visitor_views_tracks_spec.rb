# frozen_string_literal: true

require 'rails_helper'

feature 'Visitor' do
  let(:tracks) do
    [
      FactoryBot.create(:track, :published, title: 'the first mix today',
playlist: "** bootylicious - Destiny's Child"),
      FactoryBot.create(:track, :published, title: 'the second mix today', playlist: 'james brown here'),
      FactoryBot.create(:track, :published, title: 'the third mix today'),
    ]
  end
  let(:unpublished_tracks) { FactoryBot.create_list(:track, 1) }

  before do
    mock_cloud_front
    tracks
  end

  scenario 'can see all the tracks and drill down' do
    visit root_path
    expect(page).to have_css('.tracks .track', count: 3)
    click_on tracks.first.title
    expect(page).to have_css('.track', count: 1)
  end

  scenario 'can search', js: true do
    visit root_path
    expect(page).to have_css('.tracks .track', count: 3)

    click_on 'search'

    fill_in 'search', with: "bootylicious\n"
    expect(page).to have_content 'the first mix today'

    fill_in 'search', with: "james brown\n"
    expect(page).to have_content 'the second mix today'

    fill_in 'search', with: "this garbage is not in the system\n"
    expect(page).to have_content 'well, hmm...'
  end
end
