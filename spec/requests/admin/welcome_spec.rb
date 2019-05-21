# frozen_string_literal: true

require 'rails_helper'

describe 'Welcome' do
  describe 'GET /' do
    it 'returns a success' do
      get '/'
      expect(response.status).to be(200)
    end
  end
end
