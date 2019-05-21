# frozen_string_literal: true

require 'rails_helper'

describe 'Tracks' do
  before do
    sign_in_via_post 'test@example.com'
  end
  describe 'GET /admin/tracks' do
    it 'works! (now write some real specs)' do
      get admin_tracks_path
      expect(response.status).to be(200)
    end
  end
end
