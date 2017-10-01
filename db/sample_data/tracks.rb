# frozen_string_literal: true

class TrackFactory
  def build
    self.class.index += 1
  end

  def create
    build.save!
  end

  private

  cattr_accessor :index

  def title
    "Mix #{self.class.index + 1}"
  end

  def author
    ['Mr Rogers', 'Soul Suspect'].sample
  end

  def url
    'http://s3.amazon.com/selectors_choice/rock_it.mp3'
  end

  def recorded_on
    @@index.days.aog
  end

  def published
    [true, false].sample
  end

  def playlist
    '* song 1\n* song 2'
  end

  def description
    'set description *with emphasis*'
  end
end
