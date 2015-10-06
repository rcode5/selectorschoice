require 'spec_helper'

describe WelcomeController do
  describe '#index' do
    before do
      sample_tags = []
      sample_styles = []
      10.times do |x|
        t = FactoryGirl.create :track, published: ((x%2) == 0)
        tag = "Tag%02d" % x
        style = "Style%02d" % x
        t.tag_list = tag
        t.style_list = style
        t.tag_list << 'common_tag'
        t.style_list << 'common_style'
        t.save
      end
      get :index
    end
    it 'fetches only published tracks' do
      expect(assigns(:tracks).all?(&:published)).to be_true
    end
    it 'fetches tagged items if params includes tags' do
      get :index, :tags => 'tag02'
      expect(assigns(:tags)).to eql ['tag02']
      tag_list = assigns(:tracks).map(&:tag_list).flatten
      style_list = assigns(:tracks).map(&:style_list).flatten
      expect(tag_list).to include 'tag02'
      expect(tag_list).to include 'common_tag'
      expect(style_list).to include 'style02'
      expect(style_list).to include 'common_style'
    end

    it 'fetches tagged items if params includes tags with commas' do
      get :index, :tags => 'tag02, common_tag'
      expect(assigns(:tags)).to eql ['common_tag', 'tag02'].sort
      expect(assigns(:tracks).count).to eql 1
    end

    it 'searchs tags and styles equally' do
      get :index, :tags => 'tag02, style02'
      expect(assigns(:tracks).count).to eql 1
    end

  end
end
