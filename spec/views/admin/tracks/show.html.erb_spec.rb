# frozen_string_literal: true

require 'rails_helper'

describe 'admin/tracks/show' do
  before(:each) do
    mock_cloud_front
    @track = assign(:track, FactoryBot.create(:track,
                                              title: 'Title',
                                              display_title: 'Display Title',
                                              playlist: 'MyText',
                                              description: 'MyText'))
  end

  it 'renders attributes in <p>' do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Display Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
