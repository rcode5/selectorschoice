class Track < ActiveRecord::Base
  validates :title, uniqueness: true, presence: true
  validates url: true, presence: true
  attr_accessible :description, :display_title, :playlist, :recorded_on, :title, :url

  class << self
    def by_recency
      order('recorded_on desc, updated_at desc')
    end
  end
end
