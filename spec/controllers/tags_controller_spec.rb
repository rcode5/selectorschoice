require 'spec_helper'

describe TagsController do
  describe '#index.json' do
    before do
      sample_tags = []
      sample_styles = []
      t = FactoryGirl.create :track, published: true
      10.times do |x| 
        tag = "tag%02d" % x
        style = "Style%02d" % x
        t.tag_list << tag
        t.style_list << style
      end
      t.tag_list << 'common_tag'
      t.style_list << 'common_style'
      t.save
      get :index, :format => :json
    end
    it 'returns json' do
      expect(response.content_type).to eql 'application/json'
    end

    it 'returns tags and styles (downcased)' do
      resp = JSON.parse(response.body)
      expect(resp).to include 'common_style'
      expect(resp).to include 'common_tag'
      expect(resp).to include 'tag02'
      expect(resp).to include 'style02'
      expect(resp.count).to eql 22
    end
  end
end