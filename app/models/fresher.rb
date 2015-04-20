class Fresher < Candidate

  # Constants
  CURRENT_YEAR = Date.today.year
  YEAR_OF_PASSING_LIST = (CURRENT_YEAR-6..CURRENT_YEAR).to_a
  validates :year_of_passing, :inclusion => {:in => YEAR_OF_PASSING_LIST, :message => "Please select from the list" }

end
