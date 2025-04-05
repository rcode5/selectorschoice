# frozen_string_literal: true

require 'rails_helper'

describe SearchService do
  let!(:tracks) do
    [
      FactoryBot.create(:track,
                        :published,
                        title: 'Touchstone Holiday party set 2022',
                        description: 'this was super fun',
                        playlist: 'james brown - sex machine'),
      FactoryBot.create(:track,
                        :published,
                        title: 'Disco Nap Birthday',
                        description: 'fun in the backyard',
                        playlist: 'green onions - booker t'),
      FactoryBot.create(:track,
                        :published,
                        :with_tags,
                        title: 'bliss bar',
                        description: 'sleepy swingin'),
      FactoryBot.create(:track,
                        title: 'cannot find me',
                        description: 'not yet in the world'),
    ]
  end
  it 'is searchable by title' do
    expect(SearchService.new('disco').search).to eq [tracks[1]]
  end
  it 'is searchable by tags' do
    expect(SearchService.new(tracks[2].tags.first).search).to eq [tracks[2]]
  end
  it 'is searchable by description' do
    expect(SearchService.new('super fun').search).to eq [tracks[0]]
  end
  it 'is searchable by playlist' do
    expect(SearchService.new('sex machine').search).to eq [tracks[0]]
  end
  it 'does not find unpublished works' do
    expect(SearchService.new('cannot').search).to be_empty
  end
  context 'if the item is published later' do
    it 'finds it' do
      tracks.last.update(published: true)
      expect(SearchService.new('cannot').search).to eq [tracks.last]
    end
  end
  context 'if the item is deleted' do
    it 'does not show up in results' do
      expect(SearchService.new('super fun').search).to eq [tracks[0]]
      tracks[0].destroy
      expect(SearchService.new('super fun').search).to be_empty
    end
  end
  context 'if the item is modified' do
    it 'does not show up in results unless you ask for the modified stuff' do
      expect(SearchService.new('super fun').search).to eq [tracks[0]]
      tracks[0].update!(description: 'what a terrible day we had')
      expect(SearchService.new('super fun').search).to be_empty
      expect(SearchService.new('terrible day').search).to eq [tracks[0]]
    end
  end
end
