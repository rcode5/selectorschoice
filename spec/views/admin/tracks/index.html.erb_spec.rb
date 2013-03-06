require 'spec_helper'

describe "admin/tracks/index" do
  before(:each) do
    published = [FactoryGirl.create(Track)]
    unpublished = [FactoryGirl.create(Track, published: false)]
    @tracks = published + unpublished
    assign(:published, published)
    assign(:unpublished, unpublished)
    render
  end

  it "renders a list of tracks" do
    @tracks.each do |track|
      assert_select "tr td.recorded_on", :text => track.recorded_on.strftime("%m %d %Y")
      assert_select "tr .info .title", track.pretty_title
      assert_select "tr .info .author", :match => /#{track.author}/
      assert_select "tr .track .url input.url"
      assert_select "tr .edit-controls .icon-edit"
      assert_select "tr .edit-controls .icon-show"
      assert_select "tr .edit-controls .icon-delete"
    end
  end
end
