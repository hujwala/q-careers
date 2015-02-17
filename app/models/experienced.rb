class Experienced < Candidate

  validates :experience_in_years, :inclusion => {:in => YEARS_LIST, :message => "Please select from the list" }

end
