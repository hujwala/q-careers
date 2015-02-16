FactoryGirl.define do
  sequence(:name) {|n| "candidate#{n}" }
  sequence(:email) {|n| "candidate.#{n}@domain.com" }
  factory :candidate do
    name
    email
    phone "990 191 6142"
    current_city "Davangere"
    current_state "karnataka"
    current_country "India"
    native_city "Davangere"
    native_state "karnataka"
    native_country "India"
    year_of_passing 2014
    experience_in_years 10
    skills "JAVA"
    resume { Rack::Test::UploadedFile.new('test/fixtures/test.pdf', 'test.pdf') }

  end
end
