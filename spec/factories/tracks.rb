# frozen_string_literal: true

FactoryBot.define do
  factory :track do
    title { |n| "hot new mix #{n}" }
    author { |_n| ['Mr Rogers', 'Soul Suspect'].cycle }
    filename { |n| "rock it #{n}.mp3" }
    recorded_on { (Time.now - rand(50).days) }
    published { true }
    description { 'set description *with emphasis*' }
    playlist { '* song 1\n* song 2' }
  end
end
