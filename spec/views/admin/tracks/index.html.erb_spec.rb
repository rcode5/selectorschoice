require 'spec_helper'

describe "admin/tracks/index" do
  before(:each) do
    @tracks = assign(:tracks, [FactoryGirl.create(Track), FactoryGirl.create(Track, published: false)])
  end

  it "renders a list of tracks" do
    render
    @tracks.each do |track|
      assert_select "tr td.recorded_on", :text => track.recorded_on.strftime("%m %d %Y")
      assert_select "tr .info .title", track.pretty_title
      assert_select "tr .info .author", :match => /#{track.author}/
      assert_select "tr .info .url input.url"
      assert_select "tr .edit-controls .icon-edit"
      assert_select "tr .edit-controls .icon-show"
      assert_select "tr .edit-controls .icon-delete"
    end
  end
end
