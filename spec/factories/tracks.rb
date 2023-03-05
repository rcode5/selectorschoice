# frozen_string_literal: true

author_names = ['Mr Rogers', 'Soul Suspect'].cycle
FactoryBot.define do
  factory :track do
    author { author_names.next }
    recorded_on { rand(50).days.ago }
    description { 'set description *with emphasis*' }
    playlist { '* song 1\n* song 2' }

    sequence(:title) { |n| "hot new mix #{n}" }
    sequence(:filename) { |n| "rock it #{n}.mp3" }

    trait(:published) do
      published { true }
    end
  end
end
