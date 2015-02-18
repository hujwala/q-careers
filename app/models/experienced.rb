class Experienced < Candidate

  # Constants
  YEARS_LIST = (1..25).to_a
  validates :experience_in_years, :inclusion => {:in => YEARS_LIST, :message => "Please select from the list" }

end
