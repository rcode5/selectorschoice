# frozen_string_literal: true

FactoryBot.define do
  factory :track do
    title { |n| "hot new mix #{n}" }
    author { |_n| ['Mr Rogers', 'Soul Suspect'].cycle }
    url { |n| "http://s3.amazon.com/selectors_choice/rock_it_#{n}.mp3" }
    recorded_on { (Time.now - rand(50).days) }
    published { true }
    description { 'set description *with emphasis*' }
    playlist { '* song 1\n* song 2' }
  end
end
