require 'spec_helper'

describe "tracks/show" do
  before(:each) do
    @track = assign(:track, stub_model(Track,
      :title => "Title",
      :display_title => "Display Title",
      :playlist => "MyText",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Display Title/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
  end
end
