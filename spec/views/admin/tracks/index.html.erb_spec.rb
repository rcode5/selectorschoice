require 'spec_helper'

describe "admin/tracks/index" do
  before(:each) do
    @tracks = assign(:tracks, [FactoryGirl.create(Track), FactoryGirl.create(Track, published: false)])
  end

  it "renders a list of tracks" do
    render
    @tracks.each do |track|
      assert_select "tr>td", :text => track.recorded_on.strftime("%m %d %Y")
      assert_select "tr>td", :text => track.pretty_title
      assert_select "tr>td", :text => track.author
      assert_select "tr>td .icon-external-url"
      assert_select "tr>td .icon-edit"
      assert_select "tr>td .icon-show"
      assert_select "tr>td .icon-delete"


    end
  end
end
