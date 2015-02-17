FactoryGirl.define do
  factory :experienced, parent: :candidate do
    experience_in_years Candidate::YEARS_LIST
  end
end