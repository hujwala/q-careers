FactoryGirl.define do
  sequence(:name) {|n| "candidate#{n}" }
  sequence(:email) {|n| "candidate.#{n}@domain.com" }
  factory :candidate do
    name
    email
    phone "990 191 6142"
    current_city "Davangere"
    native_city "Davangere"
    skills "JAVA"
    resume { Rack::Test::UploadedFile.new('test/fixtures/test.pdf', 'test.pdf') }

  end
end
