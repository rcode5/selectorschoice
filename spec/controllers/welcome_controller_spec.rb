require 'spec_helper'

describe WelcomeController do
  describe '#index' do
    before do
      5.times { |x| FactoryGirl.create :track, published: ((x%2) == 0) }
      get :index
    end
    it 'fetches only published tracks' do
      expect(assigns(:tracks).all?(&:published)).to be_true
    end
  end
end
