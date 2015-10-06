require 'spec_helper'

describe Track do
  describe 'validations' do
    it 's3 urls are valid' do
      valid_urls = %w| http://whatever.com/file.mp3 http://overthere.com/and/in/a/deep/dir/file.mp3 https://selectors_choice.s3.amazonaws.com/missioncliffs/20151002/20151002_1.mp3|
      valid_urls.each do |url|
        track = Track.new url: url
        expect(track.errors[:url]).to be_blank
      end
    end
  end
end
