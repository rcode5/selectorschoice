# frozen_string_literal: true

require 'spec_helper'

feature 'Visitor' do
  let(:tracks) { FactoryGirl.create_list(:track, 3) }

  before do
    tracks
  end

  scenario 'can see all the tracks and drill down' do
    visit root_path
    expect(page).to have_css('.tracks .track', count: 3)
    click_on tracks.first.title
    expect(page).to have_css('.track', count: 1)
  end
end
