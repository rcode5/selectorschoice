# frozen_string_literal: true

require 'rails_helper'

describe WelcomeController, type: :controller do
  describe '#index' do
    before do
      10.times do |index|
        track = FactoryBot.create :track, published: index.even?
        tag = format('Tag%02d', index)
        style = format('Style%02d', index)
        track.tag_list = [tag, 'common_tag']
        track.style_list = [style, 'common_style']
        track.save
      end
      get :index
    end
    it 'fetches only published tracks' do
      expect(assigns(:tracks).all?(&:published)).to be_truthy
    end
    it 'fetches tagged items if params includes tags' do
      get :index, params: { tags: 'tag02' }
      expect(assigns(:tags)).to eql ['tag02']
      tag_list = assigns(:tracks).map(&:tag_list).flatten
      style_list = assigns(:tracks).map(&:style_list).flatten
      expect(tag_list).to include 'tag02'
      expect(tag_list).to include 'common_tag'
      expect(style_list).to include 'style02'
      expect(style_list).to include 'common_style'
    end

    it 'fetches tagged items if params includes tags with commas' do
      get :index, params: { tags: 'tag02, common_tag' }
      expect(assigns(:tags)).to match_array %w[common_tag tag02]
      expect(assigns(:tracks).count).to eql 5
    end

    it 'works with apostrophes in the tags' do
      get :index, params: { tags: "50's rock, tag02" }
      expect(assigns(:tags)).to match_array ["50's rock", 'tag02']
      expect(assigns(:tracks).count).to eql 1
    end

    it 'searches tags and styles equally' do
      get :index, params: { tags: 'tag02, style02' }
      expect(assigns(:tracks).count).to eql 1
    end

    it 'works with the `search` param' do
      get :index, params: { tags: 'tag02, style02', search: 'whatever' }
      expect(assigns(:tracks).count).to eql 1
    end
  end
end
