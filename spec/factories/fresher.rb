FactoryGirl.define do
  factory :fresher, parent: :candidate do
    year_of_passing Candidate::YEAR_OF_PASSING_LIST
  end
end