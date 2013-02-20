FactoryGirl.define do

  sequence :title do |n|
    "hot new mix #{n}"
  end

  sequence :author do |n|
    ["Mr Rogers", "Soul Suspect"][n%2]
  end
  
  sequence :url do |n|
    "http://s3.amazon.com/selectors_choice/rock_it_#{n}.mp3"
  end

  factory :track do
    title
    author
    url
    recorded_on { (Time.now - rand(50).days) }
    published true
    description 'set description *with emphasis*'
    playlist '* song 1\n* song 2'
  end

end
