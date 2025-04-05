# frozen_string_literal: true

require 'rails_helper'

describe FeedController do
  render_views

  before do
    allow(SelectorsChoice::CloudFront).to receive(:new).and_return(
      instance_double(SelectorsChoice::CloudFront, get_presigned_url: 'https://the-signed-url.com/'),
    )
  end
  describe '#show.xml' do
    let(:published_tracks) do
      [
        FactoryBot.create(:track, recorded_on: 10.days.ago, published: true),
        FactoryBot.create(:track, recorded_on: 20.days.ago, published: true),
      ]
    end
    let(:unpublished_track) { FactoryBot.create(:track, title: 'not here') }
    before do
      freeze_time do
        travel_to Time.zone.local(2025, 4, 2, 0, 0, 0, 0)
        published_tracks
        unpublished_track
      end
    end
    it 'returns json' do
      get :show, format: :xml

      expect(response.content_type).to eql 'application/xml; charset=utf-8'
    end

    context 'with the xml response' do
      it 'returns the overall podcast channel info' do
        get :show, format: :xml
        xml_response = Nokogiri::XML(response.body)

        expect(xml_response.xpath('//channel/title').text).to match 'Selectors Choice'
        expect(xml_response.xpath('//channel/pubDate').text).to eq 'Wed, 02 Apr 2025 00:00:00 +0000'
        expect(xml_response.xpath('//channel/lastBuildDate').text).to eq 'Wed, 02 Apr 2025 00:00:00 +0000'
        expect(xml_response.xpath('//channel/itunes:image').first.attributes['href'].value).to include(
          'test.host/assets/podcast_image',
        )
      end

      it 'returns the items' do
        get :show, format: :xml
        xml_response = Nokogiri::XML(response.body)

        expect(xml_response.xpath('(//channel/item/title)[1]').text).to match published_tracks.first.title
        expect(xml_response.xpath('(//channel/item/title)[2]').text).to match published_tracks.last.title
        expect(xml_response.text).to_not include 'not here'

        expect(xml_response.xpath('(//channel/item/pubDate)[1]').text).to eq 'Sun, 23 Mar 2025 00:00:00 +0000'
        expect(xml_response.xpath('(//channel/item/pubDate)[2]').text).to eq 'Thu, 13 Mar 2025 00:00:00 +0000'
      end
    end
  end
end
