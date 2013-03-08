class Track < ActiveRecord::Base
  validates :title, presence: true
  validates :url, url: true, presence: true

  acts_as_taggable
  acts_as_taggable_on :styles

  attr_accessible :description, :display_title, :playlist, :recorded_on, :title, :url, :tag_list, :style_list, :author, :published


  def pretty_title
    display_title.present? ? display_title : title
  end

  class << self
    
    def by_recency
      order('recorded_on desc, updated_at desc')
    end
    def published
      where(published: true)
    end
    def unpublished
      where(published: [false, nil])
    end
  end
end
