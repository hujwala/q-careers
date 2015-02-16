class Fresher < Candidate

  validates :year_of_passing, :inclusion => {:in => YEAR_OF_PASSING_LIST, :message => "Please select from the list" }

end
